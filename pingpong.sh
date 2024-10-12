#!/bin/bash

IP_LIST="/usr/local/bin/pingpong/ip_list.txt"

add_ip() {
    local ip=$1
    echo "$ip" >> "$IP_LIST"
    echo "Added $ip to the IP list."
}

clean_ip_list() {
    if [[ -f "$IP_LIST" ]]; then
        sort -u "$IP_LIST" -o "$IP_LIST"
        echo "Cleaned up the IP list: duplicates removed."
    else
        echo "IP list file not found!"
    fi
}

show_ips() {
    if [[ -f "$IP_LIST" ]]; then
        echo "Currently monitored IP addresses:"
        cat "$IP_LIST"
    else
        echo "IP list file not found!"
    fi
}

count_ips() {
    if [[ -f "$IP_LIST" ]]; then
        unique_count=$(sort -u "$IP_LIST" | wc -l)
        echo "Total unique IP addresses: $unique_count"
    else
        echo "IP list file not found!"
    fi
}

if [[ $# -eq 0 ]]; then
    echo "Usage: $0 --add <IP_ADDRESS> | --clean | --show | --count"
    exit 1
fi

case $1 in
    --add | a)
        if [[ -z "$2" ]]; then
            echo "Usage: $0 --add <IP_ADDRESS>"
            exit 1
        fi
        add_ip "$2"
        ;;
    --clean | c)
        clean_ip_list
        ;;
    --show | s)
        show_ips
        ;;
    --count | cnt)
        count_ips
        ;;
    *)
        echo "Invalid option. Usage: $0 --add <IP_ADDRESS> | --clean | --show | --count"
        exit 1
        ;;
esac
