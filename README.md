
# Pingpong - IP/Host Monitoring Tool

**Pingpong** is a simple and effective Bash tool designed to monitor the status of IP addresses or hosts through ping checks. The tool provides an easy-to-use interface for adding, managing, and monitoring IPs. It works in the background and sends notifications when a host becomes live using the `notify` tool.

## Features

- **IP Management**: Add, clean, and view IPs to be monitored using a simple command-line interface.
- **Background Monitoring**: Continuously monitor the status of IPs in the background using `nohup`.
- **Notification Support**: Receive notifications via `notify` when an IP goes live. Duplicate notifications are suppressed for 24 hours.
- **Log Tracking**: Generates a log file with timestamps for when IPs become live or unreachable.
- **Auto-reset Notifications**: Daily reset of the notification list to ensure repeated notifications for IPs that become live again.

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/mchklt/pingpong.git
   ```

2. Move the scripts to the appropriate directories:
   ```bash
   sudo mkdir -p /usr/local/bin/pingpong
   sudo cp pingpong/monitor.sh /usr/local/bin/pingpong/monitor.sh
   sudo cp pingpong /usr/local/bin/pingpong
   ```

3. Make the scripts executable:
   ```bash
   sudo chmod +x /usr/local/bin/pingpong/monitor.sh
   sudo chmod +x /usr/local/bin/pingpong
   ```

4. Create the IP list file:
   ```bash
   sudo touch /usr/local/bin/pingpong/ip_list.txt
   ```

## Usage

- **Add an IP**:
   ```bash
   pingpong --add 192.168.1.1
   ```

- **Clean the IP list** (remove duplicates):
   ```bash
   pingpong --clean
   ```

- **Show the IP list**:
   ```bash
   pingpong --show
   ```

- **Count the IPs**:
   ```bash
   pingpong --count
   ```

- **Start Monitoring in the background**:
   ```bash
   nohup /usr/local/bin/pingpong/monitor.sh &
   ```

   This command will run `monitor.sh` in the background, even if you log out of your terminal session, and the output will be logged into a `nohup.out` file.

## Notifications

Ensure the `notify` tool is installed and properly configured. Notifications will alert you whenever an IP is live, and you will not receive duplicate notifications for the same IP within a 24-hour period.
