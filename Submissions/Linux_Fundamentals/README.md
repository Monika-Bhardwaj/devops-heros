# Linux Fundamentals Homework Tasks & Lab Report

### Student Details
| Field | Value |
|---|---|
| **Name** | Monika |
| **Email** | [monika.24bcs10333@sst.scaler.com](mailto:monika.24bcs10333@sst.scaler.com) |
| **Enrollment Number** | 10333 (`24bcs10333`) |
| **Host System** | Ubuntu Linux 24.04 (Kernel 7.0) on ASUS Laptop |
| **Repository** | [Monika-Bhardwaj/devops-heros](https://github.com/Monika-Bhardwaj/devops-heros) |

---

## Task 1: Soft Link & Hard Link

### What is a Soft Link (Symbolic Link)?
A **soft link** (or symlink) is a pointer that references the path of another file or directory.
- It stores the target file's path string, not its inode data.
- It can span across different disk filesystems and partitions.
- It can link to both files and directories.
- If the original target file is moved or deleted, the soft link breaks ("dangling symlink").

### What is a Hard Link?
A **hard link** is a direct directory entry referencing the identical inode and data blocks on the disk.
- It shares the exact same inode number as the original file.
- Changes made through either filename immediately reflect on the other.
- If the original filename is removed, the data remains accessible through the hard link until all link counts reach zero.
- Hard links cannot cross filesystem boundaries and cannot link directories (to prevent filesystem loops).

### Comparison Summary
| Feature | Soft Link (`ln -s`) | Hard Link (`ln`) |
|---|---|---|
| **Inode Number** | Distinct inode pointing to path | Identical inode sharing data |
| **Across Filesystems** | Supported | Not supported |
| **Directory Support** | Supported | Not supported |
| **Original File Deletion** | Link becomes broken/dangling | File content remains intact |

### Commands Executed on Laptop
```bash
# Create original test file
echo "Hello Linux - Monika ASUS Laptop" > original.txt

# Create soft link
ln -s original.txt softlink.txt

# Create hard link
ln original.txt hardlink.txt

# Inspect inodes
ls -li original.txt softlink.txt hardlink.txt
```

**Observed Output:**
```text
1979514 -rw-rw-r-- 2 moneca moneca 33 Sep  3 05:53 hardlink.txt
1979514 -rw-rw-r-- 2 moneca moneca 33 Sep  3 05:53 original.txt
1979515 lrwxrwxrwx 1 moneca moneca 12 Sep  3 05:53 softlink.txt -> original.txt
```
*(Notice that `original.txt` and `hardlink.txt` share inode `1979514`, whereas `softlink.txt` has its own inode `1979515`)*.

```bash
# Verify contents
cat original.txt  # Output: Hello Linux - Monika ASUS Laptop
cat softlink.txt  # Output: Hello Linux - Monika ASUS Laptop
cat hardlink.txt  # Output: Hello Linux - Monika ASUS Laptop

# Delete original file
rm original.txt

# Test link behavior after deletion
cat softlink.txt  # Result: cat: softlink.txt: No such file or directory (broken link)
cat hardlink.txt  # Result: Hello Linux - Monika ASUS Laptop (data preserved!)
```

### Screenshot Evidence: Soft and Hard Link Verification
![Soft and Hard Links Verification](<../../Screenshots/Linux_Fundamentals/soft_and_hard_links.png>)

### Interview Question & Answer
**Q: How does Linux handle file deletion when both soft links and hard links exist?**  
**A:** In Linux, file content is tracked by an inode and a link counter (`st_nlink`). A hard link increments the inode's link counter. When you run `rm original.txt`, the directory entry is unlinked and the link count decreases by 1. Because the hard link still points to that inode, the inode link count remains > 0 and the storage blocks are preserved; the data remains completely accessible through the hard link. A soft link, on the other hand, merely stores the string path of `original.txt`. When `original.txt` is removed, the soft link still points to that path name, which no longer exists, resulting in a broken/dangling symbolic link that returns `No such file or directory`.

---

## Task 2: `adduser` vs `useradd`

### Technical Comparison
| Feature | `adduser` | `useradd` |
|---|---|---|
| **Type** | High-level interactive Perl wrapper script | Low-level native compiled binary utility |
| **Distribution** | Debian, Ubuntu | Universal standard Linux utility |
| **Home Directory** | Created automatically with `/etc/skel` files | Not created unless `-m` flag is explicitly passed |
| **Password Prompt** | Prompts interactively for password and details | Creates locked account without password unless `-p` or `passwd` run |
| **Default Shell** | Automatically sets `/bin/bash` | Often defaults to `/bin/sh` unless `-s` provided |
| **Best Use Case** | Interactive manual user management on Ubuntu/Debian | Automated shell scripts and cross-distribution provisioning |

### Why `adduser` is Preferred on Ubuntu
`adduser` is preferred on Ubuntu for interactive administration because it applies sensible system defaults:
1. Automatically assigns unique UID and GID according to Debian policy (`/etc/adduser.conf`).
2. Creates the home directory (`/home/<username>`) and populates default skeleton configuration files (`.bashrc`, `.profile`).
3. Interactively guides the administrator through setting a secure password and user metadata.

### Verification Commands Executed
```bash
which adduser useradd
adduser --version
useradd --help
id moneca
```

### Screenshot Evidence: `adduser` vs `useradd`
![adduser vs useradd](<../../Screenshots/Linux_Fundamentals/adduser_vs_useradd.png>)

---

## Task 3: `journalctl`

### What is `journalctl`?
`journalctl` is the command-line utility for querying and analyzing system logs collected by **systemd-journald**. It indexes binary journal files, enabling fast filtering by service, priority, boot session, and timestamp without manually parsing raw log files.

### Common `journalctl` Commands
- `journalctl`: Display all logs starting from earliest recorded event.
- `journalctl -n 50`: Show last 50 log entries.
- `journalctl -f`: Follow log stream live (similar to `tail -f`).
- `journalctl -b`: Show logs from current system boot.
- `journalctl -u <service>`: Filter logs for a specific systemd unit (e.g. `journalctl -u NetworkManager`).
- `journalctl -p err`: Filter logs by syslog priority (e.g. `err`, `warning`, `info`).
- `journalctl --since "1 hour ago"`: Query logs within a specific time window.

### Verification Commands Executed
```bash
journalctl -u NetworkManager -n 6 --no-pager
```

### Screenshot Evidence: `journalctl` Service Logs
![journalctl Service Logs](<../../Screenshots/Linux_Fundamentals/journalctl_service_logs.png>)

---

## Task 4: Linux Command Cheat Sheet

### Cheat Sheet Reference Table
| Category | Command | Syntax / Example | Purpose |
|---|---|---|---|
| **System Info** | `uname` | `uname -sr` | Display Linux kernel release and system name |
| **Identity** | `whoami` | `whoami` | Display currently active user name |
| **Directory** | `pwd` | `pwd` | Print current working directory path |
| **Memory** | `free` | `free -h` | Display total, used, and available RAM and swap in human-readable units |
| **Disk Usage** | `df` | `df -h /` | Display disk partition capacity, used, and free space |
| **Processes** | `ps` | `ps aux \| head -10` | Show snapshot of running processes |
| **File Listing** | `ls` | `ls -la` | List all files including hidden with permissions and sizes |
| **File Creation** | `touch` | `touch sample.txt` | Create empty file or update timestamps |
| **Text Search** | `grep` | `grep -rn "pattern" .` | Search files recursively for regex patterns |
| **Networking** | `ip addr` | `ip addr show` | Display network interfaces, IPv4, IPv6, and MAC addresses |

### Verification Commands Executed
```bash
pwd && whoami && uname -sr && free -h && df -h /
```

### Screenshot Evidence: Linux Cheat Sheet Execution
![Linux Cheat Sheet](<../../Screenshots/Linux_Fundamentals/linux_cheat_sheet_commands.png>)