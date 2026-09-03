# Networking Fundamentals Homework Tasks & Lab Report

### Student Details
| Field | Value |
|---|---|
| **Name** | Monika |
| **Email** | [monika.24bcs10333@sst.scaler.com](mailto:monika.24bcs10333@sst.scaler.com) |
| **Enrollment Number** | 10333 (`24bcs10333`) |
| **Host Machine** | ASUS Laptop (`moneca-VivoBook-ASUSLaptop-X515JA-X515JA`), Ubuntu Linux 24.04 |
| **Repository** | [Monika-Bhardwaj/devops-heros](https://github.com/Monika-Bhardwaj/devops-heros) |

---

## Task 1: Practice Networking Commands

All commands were executed directly on Monika's Ubuntu laptop to understand OSI layer operations, packet routing, DNS resolution, and TCP/IP stack configuration.

---

## Task 2: Networking Commands, Real Outputs & Explanations

### 1. `ping` (ICMP Echo Request / Reply)
- **Purpose**: Tests Layer 3 network reachability and measures Round Trip Time (RTT).
- **Command Executed**:
  ```bash
  ping -c 4 google.com
  ```
- **Real Observed Output**:
  ```text
  PING google.com (192.178.173.113) 56(84) bytes of data.
  64 bytes from lcbome-in-f113.1e100.net (192.178.173.113): icmp_seq=1 ttl=113 time=25.6 ms
  64 bytes from lcbome-in-f113.1e100.net (192.178.173.113): icmp_seq=2 ttl=113 time=23.8 ms
  64 bytes from lcbome-in-f113.1e100.net (192.178.173.113): icmp_seq=3 ttl=113 time=24.2 ms
  64 bytes from lcbome-in-f113.1e100.net (192.178.173.113): icmp_seq=4 ttl=113 time=90.0 ms

  --- google.com ping statistics ---
  4 packets transmitted, 4 received, 0% packet loss, time 3003ms
  rtt min/avg/max/mdev = 23.756/40.860/89.954/28.352 ms
  ```
- **What was learned**: Transmitted 4 ICMP packets with 0% packet loss. TTL of 113 indicates packets traversed intermediate hops with acceptable latency (~23-40ms).

---

### 2. `ip addr` (Network Interface Address Configuration)
- **Purpose**: Displays and manages network interfaces, MAC addresses, MTU, and assigned IP addresses (modern standard replacing legacy `ifconfig`).
- **Command Executed**:
  ```bash
  ip addr show dev wlo1
  ```
- **Real Observed Output**:
  ```text
  2: wlo1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default
      link/ether e8:fb:1c:f3:d3:2b brd ff:ff:ff:ff:ff:ff
      inet 100.129.171.9/20 brd 100.129.175.255 scope global dynamic noprefixroute wlo1
      inet6 fe80::bc83:6001:d871:753d/64 scope link noprefixroute
  ```
- **What was learned**: The Wi-Fi adapter `wlo1` has MAC address `e8:fb:1c:f3:d3:2b` and is assigned IP `100.129.171.9` with a `/20` subnet mask (`255.255.240.0`).

---

### 3. `ip route` (Kernel Routing Table)
- **Purpose**: Displays the kernel routing tables and default gateway.
- **Command Executed**:
  ```bash
  ip route
  ```
- **Real Observed Output**:
  ```text
  default via 100.129.160.1 dev wlo1 proto dhcp src 100.129.171.9 metric 600
  100.129.160.0/20 dev wlo1 proto kernel scope link src 100.129.171.9 metric 600
  ```
- **What was learned**: Outbound packets not destined for the local `/20` subnet are forwarded to the default gateway at `100.129.160.1` via device `wlo1`.

---

### 4. `hostname` (System Host Identification)
- **Purpose**: Displays the system network node name.
- **Command Executed**:
  ```bash
  hostname
  ```
- **Real Observed Output**:
  ```text
  moneca-VivoBook-ASUSLaptop-X515JA-X515JA
  ```
- **What was learned**: Confirms the ASUS laptop hostname on the local network.

---

### 5. `dig` (DNS Lookup Utility)
- **Purpose**: Performs DNS queries against configured recursive nameservers.
- **Command Executed**:
  ```bash
  dig +short google.com
  ```
- **Real Observed Output**:
  ```text
  192.178.173.100
  192.178.173.101
  192.178.173.139
  192.178.173.113
  ```
- **What was learned**: DNS returns multiple `A` records (IPv4 addresses) for load balancing and geographic fault tolerance.

---

### 6. `curl -I` (HTTP Header Inspection)
- **Purpose**: Fetches HTTP/HTTPS response headers without downloading the full body payload.
- **Command Executed**:
  ```bash
  curl -I https://google.com
  ```
- **Real Observed Output**:
  ```text
  HTTP/2 301 
  location: https://www.google.com/
  content-type: text/html; charset=UTF-8
  server: gws
  ```
- **What was learned**: Returns HTTP/2 status 301 (Moved Permanently), redirecting to the canonical domain with Google Web Server (`gws`).

---

### 7. `tracepath` (Path MTU & Route Hop Tracing)
- **Purpose**: Traces the network path hop-by-hop and discovers path MTU.
- **Command Executed**:
  ```bash
  tracepath -n -m 5 google.com
  ```
- **Real Observed Output**:
  ```text
   1?: [LOCALHOST]                      pmtu 1500
   1:  100.129.160.1                                         6.959ms 
   2:  202.131.133.5                                         5.830ms 
   3:  115.117.125.189                                      65.523ms 
  ```
- **What was learned**: Packets traverse from local gateway (`100.129.160.1`) through upstream ISP routers to reach destination servers.

---

## Screenshot Evidence

### 1. Ping and Network Interface Verification
![Ping and IP Address](<../Screenshots/Networking_Fundamentals/ping_and_ip_addr.png>)

### 2. Routes, DNS, HTTP Headers, and Tracepath
![Routing, DNS, Curl, Tracepath](<../Screenshots/Networking_Fundamentals/routes_ports_dns_curl.png>)
