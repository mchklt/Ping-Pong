#PingPong Host Monitoring Tool

PingPong is a Bash script that provides a simple solution for monitoring the status of hosts (IP addresses) using ping. It allows you to add, remove, display, clean duplicate entries, and count unique IPs. The script includes built-in support for notifications, enabling you to receive alerts when a host is reachable or becomes live.

Features

Ping Hosts: Continuously monitor the status of IP addresses using ping.
Add Hosts: Add new IP addresses to monitor.
Remove Hosts: Remove IP addresses from the list.
Show Hosts: Display all currently monitored IP addresses.
Clean IP List: Automatically remove duplicate entries from the list.
Count Hosts: Get the total number of unique IP addresses in the list.
Built-in Notifications: Receive real-time notifications when a host becomes reachable.
Setup

Clone the repository and navigate to the script directory:

git clone https://github.com/mchklt/pingpong.git
cd pingpong
Make the script executable:

chmod +x pingpong.sh
Install notify:
The script requires the notify tool for sending alerts. Install it using go:

go install -v github.com/projectdiscovery/notify/cmd/notify@latest
Setup notify for Telegram:
Configure your notify settings to enable Telegram notifications. Set up your API key and chat ID in the notify config file:

notify -config
Move the script to your system path to make it accessible from any location:

sudo mv pingpong.sh /usr/local/bin/pingpong
Run the script from anywhere:
You can now use the script globally. Examples:

Add a new host:
pingpong --add 192.168.1.1
Clean the list of hosts:
pingpong --clean
Show the current list of hosts:
pingpong --show
Count unique hosts:
pingpong --count
Receive notifications when an IP responds to ping automatically through the script.
