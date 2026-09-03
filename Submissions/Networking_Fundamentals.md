# Networking Homework Solutions

### Student Details
| Field | Value |
|---|---|
| **Name** | Monika |
| **Email** | monika.24bcs10333@sst.scaler.com |
| **Enrollment Number** | 10333 (24bcs10333) |
| **Repository** | [Monika-Bhardwaj/devops-heros](https://github.com/Monika-Bhardwaj/devops-heros) |

---

## Task 1: Practice Commands

Practiced networking commands from the devops-hero GitHub repository and understood their usage for network troubleshooting and configuration.

---

## Task 2: Networking Commands Practice

### Understanding the Commands

| Command | Purpose |
|---------|---------|
| `ping` | Tests network connectivity to a host |
| `traceroute` | Traces the path packets take to reach a destination |
| `ifconfig` | Displays network interface configuration |
| `route` | Shows and manipulates the IP routing table |
| `netstat` | Displays network connections and routing tables |
| `hostname` | Shows the system's hostname |
| `dig` | DNS lookup utility |
| `curl -I` | Fetches HTTP headers from a URL |

---

### Workflow Performed

- Used `ping` to test connectivity to google.com and local addresses
- Used `traceroute` to trace network path to google.com and 8.8.8.8
- Used `ifconfig` to display all network interfaces and their configurations
- Used `route -n get default` to find the default gateway
- Used `netstat -rn` to view the routing table
- Used `hostname` to check the system's hostname
- Used `dig` for DNS resolution of google.com
- Used `curl -I` to fetch HTTP headers from google.com

---

### Commands Used with Explanations

```bash
# 1. PING - Test network connectivity
ping -c 4 google.com
# Sends 4 ICMP packets to google.com
# Output shows: 0% packet loss, round-trip times

ping -c 4 127.0.0.1
# Tests localhost connectivity (loopback)
# Should always succeed

ping -c 4 192.168.1.1
# Tests connectivity to default gateway
# Shows request timeout if gateway doesn't respond to ICMP

# 2. TRACEROUTE - Trace network path
traceroute google.com
# Shows each hop packets take to reach google.com
# Useful for identifying network bottlenecks

traceroute -n 8.8.8.8
# -n option prevents DNS resolution (faster)
# Shows IP addresses only

# 3. IFCONFIG - Display network interfaces
ifconfig
# Shows all active network interfaces
# Displays IP addresses, MAC addresses, and interface status

ifconfig | grep "flags=" | grep -v "lo0"
# Filters output to show only active interfaces
# Excludes loopback (lo0)

# 4. ROUTE - View routing information
route -n get default
# Shows the default gateway
# Output shows: gateway: 192.168.1.1, interface: en0

route -n
# Displays routing table in numeric format

# 5. NETSTAT - Display network statistics
netstat -rn
# Shows routing table with numeric addresses
# -r = routing table, -n = numeric

netstat -rn | head -20
# Shows first 20 lines of routing table

# 6. HOSTNAME - Display system hostname
hostname
# Output: moneca-VivoBook-ASUSLaptop-X515JA-X515JA
# Shows the system's network hostname

# 7. DIG - DNS lookup
dig +short google.com
# Shows only the IP address of google.com
# Output: 142.251.220.110

dig
# Full DNS query showing all records and query details
# Shows root nameservers, server IP, query time

# 8. CURL - Fetch HTTP headers
curl -I google.com
# -I fetches only HTTP headers
# Shows: 301 Moved Permanently, Server: gws
# Useful for checking website status and response headers
```

---

### Screenshots

![alt text](<../Screenshots/Networking_Fundamentals/Screenshot 2026-09-01 at 1.11.00 PM.png>)
![alt text](<../Screenshots/Networking_Fundamentals/Screenshot 2026-09-01 at 8.28.26 AM.png>)
![alt text](<../Screenshots/Networking_Fundamentals/Screenshot 2026-09-01 at 8.33.51 AM.png>)
![alt text](<../Screenshots/Networking_Fundamentals/Screenshot 2026-09-01 at 8.34.44 AM.png>)
![alt text](<../Screenshots/Networking_Fundamentals/Screenshot 2026-09-01 at 8.36.13 AM.png>)
![alt text](<../Screenshots/Networking_Fundamentals/Screenshot 2026-09-01 at 12.42.00 PM.png>)
![alt text](<../Screenshots/Networking_Fundamentals/Screenshot 2026-09-01 at 12.44.36 PM.png>)
![alt text](<../Screenshots/Networking_Fundamentals/Screenshot 2026-09-01 at 12.47.50 PM copy.png>)
![alt text](<../Screenshots/Networking_Fundamentals/Screenshot 2026-09-01 at 12.47.50 PM.png>)

---

### Key Takeaways

| Command | What I Learned |
|---------|----------------|
| `ping` | Tests if a host is reachable and measures response time |
| `traceroute` | Shows the path packets take through the network |
| `ifconfig` | Displays network interface information (IP, MAC, status) |
| `route` | Shows how packets are routed to destinations |
| `netstat` | Displays routing tables and network statistics |
| `dig` | Queries DNS to resolve domain names to IP addresses |
| `curl -I` | Fetches HTTP response headers to check web server status |

---

## Combined Summary

### What We Learned

| Task | Key Learning |
|------|--------------|
| **Task 1** | Practiced various networking commands for troubleshooting and network diagnostics |
| **Task 2** | Understood the purpose of each command through practical execution and observation |

### Commands to Remember

```bash
# Network Testing
ping -c 4 <host>
traceroute <host>
traceroute -n <host>

# Interface Configuration
ifconfig
ifconfig | grep "flags=" | grep -v "lo0"

# Routing Information
route -n get default
netstat -rn

# DNS and Web
dig +short <domain>
curl -I <url>
hostname
```

---
