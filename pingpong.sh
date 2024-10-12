#!/bin/bash

IP_LIST="/root/hunt/monitor/ip_list.txt"

add_ip() {
    echo "$1" >> "$IP_LIST"
    echo "Successfully added $1 to the IP list."
}

check_ip_exists() {
    if grep -Fxq "$1" "$IP_LIST"; then
        echo "The IP address $1 is already in the list."
    else
        add_ip "$1"
    fi
}

clean_ip_list() {
    if [[ -f "$IP_LIST" ]]; then
        sort -u "$IP_LIST" -o "$IP_LIST"
        echo "The IP list has been cleaned up. Duplicate entries have been removed."
    else
        echo "Sorry, the IP list file could not be found."
    fi
}

show_ip_list() {
    if [[ -f "$IP_LIST" ]]; then
        echo "Here are the current IP addresses in the list:"
        cat "$IP_LIST"
    else
        echo "Sorry, the IP list file could not be found."
    fi
}

remove_ip() {
    if grep -Fxq "$1" "$IP_LIST"; then
        sed -i "/$1/d" "$IP_LIST"
        echo "The IP address $1 has been removed from the list."
    else
        echo "The IP address $1 is not in the list."
    fi
}

count_ips() {
    if [[ -f "$IP_LIST" ]]; then
        total_ips=$(wc -l < "$IP_LIST")
        echo "There are currently $total_ips unique IP addresses in the list."
    else
        echo "Sorry, the IP list file could not be found."
    fi
}

case "$1" in
    --add|a)
        check_ip_exists "$2"
        ;;
    --clean|c)
        clean_ip_list
        ;;
    --show|s)
        show_ip_list
        ;;
    --remove|r)
        remove_ip "$2"
        ;;
    --count|n)
        count_ips
        ;;
    *)
        echo "Usage: $0 --add <IP_ADDRESS> | a <IP_ADDRESS> | --clean | c | --show | s | --remove <IP_ADDRESS> | r <IP_ADDRESS> | --count | n"
        exit 1
        ;;
esac
