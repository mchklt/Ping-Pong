

# PingPong Host Monitoring Tool

PingPong is a Bash script that provides a simple solution for monitoring the status of hosts (IP addresses) using ping. It allows you to add, remove, display, clean duplicate entries, and count unique IPs. The script includes built-in support for notifications, enabling you to receive alerts when a host is reachable or becomes live.

## Features
- **Ping Hosts**: Continuously monitor the status of IP addresses using ping.
- **Add Hosts**: Add new IP addresses to monitor.
- **Remove Hosts**: Remove IP addresses from the list.
- **Show Hosts**: Display all currently monitored IP addresses.
- **Clean IP List**: Automatically remove duplicate entries from the list.
- **Count Hosts**: Get the total number of unique IP addresses in the list.
- **Built-in Notifications**: Receive real-time notifications when a host becomes reachable.

## Setup

1. **Clone the repository** and navigate to the script directory:
   ```bash
   git clone https://github.com/mchklt/pingpong.git
   cd pingpong
   ```

2. **Make the script executable**:
   ```bash
   chmod +x pingpong.sh
   ```

3. **Install `notify`**:
   The script requires the `notify` tool for sending alerts. Install it using `go`:
   ```bash
   go install -v github.com/projectdiscovery/notify/cmd/notify@latest
   ```

4. **Setup `notify` for Telegram**:
   Configure your `notify` settings to enable Telegram notifications. Set up your API key and chat ID in the `notify` config file:
   ```bash
   notify -config
   ```

5. **Move the script to your system path** to make it accessible from any location:
   ```bash
   sudo mv pingpong.sh /usr/local/bin/pingpong
   ```

6. **Run the script from anywhere**:
   You can now use the script globally. Examples:
   - Add a new host:  
     `pingpong --add 192.168.1.1`
   - Clean the list of hosts:  
     `pingpong --clean`
   - Show the current list of hosts:  
     `pingpong --show`
   - Count unique hosts:  
     `pingpong --count`
   - Receive notifications when an IP responds to ping automatically through the script.
