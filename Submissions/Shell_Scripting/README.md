# Shell Scripting Homework Task – System Information Script

### Student Details
| Field | Value |
|---|---|
| **Name** | Monika |
| **Email** | [monika.24bcs10333@sst.scaler.com](mailto:monika.24bcs10333@sst.scaler.com) |
| **Enrollment Number** | 10333 (`24bcs10333`) |
| **Host System** | Ubuntu Linux 24.04 (moneca-VivoBook-ASUSLaptop-X515JA-X515JA) |
| **Repository** | [Monika-Bhardwaj/devops-heros](https://github.com/Monika-Bhardwaj/devops-heros) |

---

## Assignment Requirements Checklist
- [x] Prints current date (`date`)
- [x] Prints hostname (`hostname`)
- [x] Prints username (`whoami`)
- [x] Prints disk usage (`df -h`)
- [x] Prints running processes (`ps aux`)
- [x] Uses variables to store and use data
- [x] Takes user input using `read -p`
- [x] Creates a directory using `mkdir`
- [x] Creates a file using `touch`
- [x] Stores the running processes information in the file using `>` output redirection

---

## Commands Used & Explanations

| Command / Construct | Usage in Script | Explanation |
|---|---|---|
| `echo` | `echo "..."` | Prints formatted status text, headers, and section dividers |
| `date` | `date` / `$(date)` | Obtains current system date, time, and timezone |
| `hostname` | `hostname` / `$(hostname)` | Retrieves system network nodename (`moneca-VivoBook-ASUSLaptop-X515JA-X515JA`) |
| `whoami` | `whoami` / `$(whoami)` | Retrieves the current active login username (`moneca`) |
| `df` | `df -h` | Reports filesystem disk space usage in human-readable gigabytes/megabytes |
| `ps` | `ps aux` | Lists a full snapshot of all running processes in the system |
| `read -p` | `read -p "Enter ...: " VAR` | Displays interactive prompt and accepts standard input from the user |
| **Variables** | `CURRENT_DATE`, `USER_NAME`, etc. | Stores dynamic command substitution values for reuse |
| `mkdir` | `mkdir -p "$DIR_NAME"` | Safely creates directory specified by the user |
| `touch` | `touch "$DIR_NAME/$FILE_NAME"` | Creates empty file or updates file access timestamp |
| `>` **Redirection** | `echo "$RUNNING_PROCESSES" > "$DIR_NAME/$FILE_NAME"` | Overwrites target file with complete process list |

---

## Script Source Code (`system_info.sh`)

```bash
#!/bin/bash

# System Information Script
# This script collects and displays system information

# Print current date
echo "=========================================="
echo "        SYSTEM INFORMATION REPORT"
echo "=========================================="
echo ""

echo "Current Date and Time: $(date)"
echo ""

echo "Hostname: $(hostname)"
echo ""

echo "Current User: $(whoami)"
echo ""

# Using variables to store data
CURRENT_DATE=$(date)
HOST_NAME=$(hostname)
USER_NAME=$(whoami)
DISK_USAGE=$(df -h)
RUNNING_PROCESSES=$(ps aux)

echo "--- Variables Stored ---"
echo "Date: $CURRENT_DATE"
echo "Host: $HOST_NAME"
echo "User: $USER_NAME"
echo ""

echo "Disk Usage:"
echo "$DISK_USAGE"
echo ""

echo "Running Processes (first 10 lines):"
echo "$RUNNING_PROCESSES" | head -10
echo ""

echo "=========================================="
read -p "Enter a directory name to create: " DIR_NAME
read -p "Enter a filename to create (with extension): " FILE_NAME
echo ""

mkdir -p "$DIR_NAME"
echo "Directory '$DIR_NAME' created successfully!"

touch "$DIR_NAME/$FILE_NAME"
echo "File '$FILE_NAME' created inside '$DIR_NAME'"

echo "$RUNNING_PROCESSES" > "$DIR_NAME/$FILE_NAME"
echo "Running processes information saved to '$DIR_NAME/$FILE_NAME'"

echo ""
echo "=========================================="
echo "Script execution completed!"
echo "Check '$DIR_NAME/$FILE_NAME' for process data"
echo "=========================================="
```

---

## Live Execution Output on Monika's Laptop

```text
moneca@moneca-VivoBook-ASUSLaptop-X515JA-X515JA:~/devops-heros/session3-shell-scripting$ ./system_info.sh
==========================================
        SYSTEM INFORMATION REPORT
==========================================

Current Date and Time: Thu Sep  3 05:55:17 AM IST 2026

Hostname: moneca-VivoBook-ASUSLaptop-X515JA-X515JA

Current User: moneca

--- Variables Stored ---
Date: Thu Sep  3 05:55:17 AM IST 2026
Host: moneca-VivoBook-ASUSLaptop-X515JA-X515JA
User: moneca

Disk Usage:
Filesystem      Size  Used Avail Use% Mounted on
tmpfs           3.8G  2.9M  3.8G   1% /run
/dev/nvme0n1p8  143G   28G  108G  21% /
tmpfs           9.4G   47M  9.4G   1% /dev/shm
efivarfs        128K   43K   81K  35% /sys/firmware/efi/efivars
none            1.0M     0  1.0M   0% /run/credentials/systemd-journald.service
none            1.0M     0  1.0M   0% /run/credentials/systemd-resolved.service
tmpfs           9.4G   67M  9.4G   1% /tmp
/dev/nvme0n1p1  256M   55M  202M  22% /boot/efi
tmpfs           1.9G   92K  1.9G   1% /run/user/1000

Running Processes (first 10 lines):
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root           1  0.0  0.0  25928 16516 ?        Ss   04:40   0:02 /usr/lib/systemd/systemd
root           2  0.0  0.0      0     0 ?        S    04:40   0:00 [kthreadd]
root           3  0.0  0.0      0     0 ?        S    04:40   0:00 [pool_workqueue_release]
root           4  0.0  0.0      0     0 ?        I<   04:40   0:00 [kworker/R-rcu_gp]
root           5  0.0  0.0      0     0 ?        I<   04:40   0:00 [kworker/R-sync_wq]
root           6  0.0  0.0      0     0 ?        I<   04:40   0:00 [kworker/R-kvfree_rcu_reclaim]
root           7  0.0  0.0      0     0 ?        I<   04:40   0:00 [kworker/R-slub_flushwq]
root           8  0.0  0.0      0     0 ?        I<   04:40   0:00 [kworker/R-netns]
root          10  0.0  0.0      0     0 ?        I<   04:40   0:00 [kworker/0:0H-kblockd]

==========================================
Enter a directory name to create: monika_sysinfo
Enter a filename to create (with extension): processes.txt

Directory 'monika_sysinfo' created successfully!
File 'processes.txt' created inside 'monika_sysinfo'
Running processes information saved to 'monika_sysinfo/processes.txt'

==========================================
Script execution completed!
Check 'monika_sysinfo/processes.txt' for process data
==========================================
```

### Verification of Generated File
```bash
ls -lh monika_sysinfo/processes.txt
# Output: -rw-rw-r-- 1 moneca moneca 52K Sep  3 05:55 monika_sysinfo/processes.txt
```

---

## Screenshot Evidence: Script Execution
![Shell Script Execution on Laptop](<../Screenshots/Shell_Scripting/system_info_execution.png>)
