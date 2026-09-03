# Shell Scripting Homework Task – System Information Script

### Student Details
| Field | Value |
|---|---|
| **Name** | Monika |
| **Email** | monika.24bcs10333@sst.scaler.com |
| **Enrollment Number** | 10333 (24bcs10333) |
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
- [x] Stores running processes information in the file using `>` output redirection

---

## Commands Used

- `mkdir`: Creates new directories (`mkdir -p "$DIR_NAME"`)
- `touch`: Creates empty files (`touch "$DIR_NAME/$FILE_NAME"`)
- `echo`: Outputs text and variables to the console
- `df`: Displays disk space usage of filesystems (`df -h`)
- `ps`: Reports current process snapshot (`ps aux`)
- `read -p`: Prompts the user interactively and stores input into variables
- **Variables**: Storing system data dynamically (`CURRENT_DATE`, `HOST_NAME`, `USER_NAME`, `DISK_USAGE`, `RUNNING_PROCESSES`, etc.)
- `>` **Output Redirection**: Redirects standard output stream to overwrite a target file

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

## How to Execute the Script

1. Give execute permissions:
   ```bash
   chmod +x system_info.sh
   ```

2. Run the script:
   ```bash
   ./system_info.sh
   ```

---

## Execution Output

```text
==========================================
        SYSTEM INFORMATION REPORT
==========================================

Current Date and Time: Thu Sep  3 05:23:33 AM IST 2026

Hostname: moneca-VivoBook-ASUSLaptop-X515JA-X515JA

Current User: moneca

--- Variables Stored ---
Date: Thu Sep  3 05:23:33 AM IST 2026
Host: moneca-VivoBook-ASUSLaptop-X515JA-X515JA
User: moneca

Disk Usage:
Filesystem      Size  Used Avail Use% Mounted on
tmpfs           3.8G  2.9M  3.8G   1% /run
/dev/nvme0n1p8  143G   27G  108G  20% /
tmpfs           9.4G   52M  9.4G   1% /dev/shm
efivarfs        128K   43K   81K  35% /sys/firmware/efi/efivars
none            1.0M     0  1.0M   0% /run/credentials/systemd-journald.service
none            1.0M     0  1.0M   0% /run/credentials/systemd-resolved.service
tmpfs           9.4G   67M  9.4G   1% /tmp
/dev/nvme0n1p1  256M   55M  202M  22% /boot/efi
tmpfs           1.9G   92K  1.9G   1% /run/user/1000

Running Processes (first 10 lines):
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root           1  0.0  0.0  25928 16512 ?        Ss   04:40   0:01 /usr/lib/systemd/systemd --switched-root --system --deserialize=53 splash
root           2  0.0  0.0      0     0 ?        S    04:40   0:00 [kthreadd]
root           3  0.0  0.0      0     0 ?        S    04:40   0:00 [pool_workqueue_release]
root           4  0.0  0.0      0     0 ?        I<   04:40   0:00 [kworker/R-rcu_gp]
root           5  0.0  0.0      0     0 ?        I<   04:40   0:00 [kworker/R-sync_wq]
root           6  0.0  0.0      0     0 ?        I<   04:40   0:00 [kworker/R-kvfree_rcu_reclaim]
root           7  0.0  0.0      0     0 ?        I<   04:40   0:00 [kworker/R-slub_flushwq]
root           8  0.0  0.0      0     0 ?        I<   04:40   0:00 [kworker/R-netns]
root          10  0.0  0.0      0     0 ?        I<   04:40   0:00 [kworker/0:0H-kblockd]

==========================================
Enter a directory name to create: sysinfo_logs
Enter a filename to create (with extension): process_report.txt

Directory 'sysinfo_logs' created successfully!
File 'process_report.txt' created inside 'sysinfo_logs'
Running processes information saved to 'sysinfo_logs/process_report.txt'

==========================================
Script execution completed!
Check 'sysinfo_logs/process_report.txt' for process data
==========================================
```

---

## Verification of Output File

```bash
head -n 10 sysinfo_logs/process_report.txt
```

```text
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root           1  0.0  0.0  25928 16512 ?        Ss   04:40   0:01 /usr/lib/systemd/systemd --switched-root --system --deserialize=53 splash
root           2  0.0  0.0      0     0 ?        S    04:40   0:00 [kthreadd]
root           3  0.0  0.0      0     0 ?        S    04:40   0:00 [pool_workqueue_release]
root           4  0.0  0.0      0     0 ?        I<   04:40   0:00 [kworker/R-rcu_gp]
root           5  0.0  0.0      0     0 ?        I<   04:40   0:00 [kworker/R-sync_wq]
root           6  0.0  0.0      0     0 ?        I<   04:40   0:00 [kworker/R-kvfree_rcu_reclaim]
root           7  0.0  0.0      0     0 ?        I<   04:40   0:00 [kworker/R-slub_flushwq]
root           8  0.0  0.0      0     0 ?        I<   04:40   0:00 [kworker/R-netns]
root          10  0.0  0.0      0     0 ?        I<   04:40   0:00 [kworker/0:0H-kblockd]
```

---

## Screenshots

![Shell Script Execution Screenshot](<../Screenshots/Shell_Scripting/Screenshot 2026-08-31 at 10.48.31 PM.png>)
