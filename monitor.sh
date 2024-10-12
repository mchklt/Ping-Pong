#!/bin/bash

IP_LIST="/usr/local/bin/pingpong/ip_list.txt"
LOG_FILE="/usr/local/bin/pingpong/monitor.log"
SLEEP_TIME=60
NOTIFIED_IPS="/usr/local/bin/pingpong/notified_ips.txt"
NOTIFY_THRESHOLD=86400  # 24 hours in seconds

check_ip_status() {
    local ip=$1
    local timestamp=$(date +%s)

    if grep -q "$ip" "$NOTIFIED_IPS"; then
        last_notified_time=$(grep "$ip" "$NOTIFIED_IPS" | cut -d '|' -f2)
        time_diff=$((timestamp - last_notified_time))

        if [ $time_diff -lt $NOTIFY_THRESHOLD ]; then
            echo "$(date) - Skipping $ip, already notified within 24 hours." >> $LOG_FILE
            return
        fi
    fi

    ping -c 2 "$ip" > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "$(date) - $ip is live." >> $LOG_FILE
        if ! grep -q "$ip" "$NOTIFIED_IPS"; then
            echo "$ip|$timestamp" >> "$NOTIFIED_IPS"
            echo "$ip is live" | notify -id mchklt
        else
            sed -i "/$ip/d" "$NOTIFIED_IPS"
            echo "$ip|$timestamp" >> "$NOTIFIED_IPS"
            echo "$ip is live again after 24 hours." | notify -id mchklt
        fi
    else
        echo "$(date) - $ip is unreachable." >> $LOG_FILE
    fi
}

reset_notified_ips() {
    if [ -f "$NOTIFIED_IPS" ]; then
        mv "$NOTIFIED_IPS" "$NOTIFIED_IPS.bak"
        echo "" > "$NOTIFIED_IPS"
    fi
}

while true; do
    if [[ -f $IP_LIST ]]; then
        if [[ "$(date +%H)" == "00" && "$(date +%M)" == "00" ]]; then
            reset_notified_ips
        fi
        while read -r ip; do
            [[ -z "$ip" || "$ip" =~ ^# ]] && continue
            check_ip_status "$ip"
        done < "$IP_LIST"
    else
        echo "$(date) - IP list file not found!" >> $LOG_FILE
        echo "IP list file not found!" | notify -id mchklt
    fi
    sleep $SLEEP_TIME
done
