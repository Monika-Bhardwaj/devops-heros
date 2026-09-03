# Linux Homework Tasks – Solutions & Notes

### Student Details
| Field | Value |
|---|---|
| **Name** | Monika |
| **Email** | monika.24bcs10333@sst.scaler.com |
| **Enrollment Number** | 10333 (24bcs10333) |
| **Repository** | [Monika-Bhardwaj/devops-heros](https://github.com/Monika-Bhardwaj/devops-heros) |

---

# Linux Homework Tasks – Simple Notes and Commands

## Task 1: Soft Link & Hard Link

### What is a Soft Link?

A **soft link**, also called a **symbolic link**, is like a shortcut to another file.

- It points to the path of the original file.
- If the original file is deleted, the soft link stops working.
- It can point to files or directories.
- It can also point to a file on another filesystem.

### What is a Hard Link?

A **hard link** is another name for the same file data.

- Both the original file and the hard link point to the same data.
- If the original filename is deleted, the hard link can still access the data.
- Hard links normally cannot be created for directories.
- Hard links cannot normally cross filesystem boundaries.

### Main Difference

| Soft Link | Hard Link |
|---|---|
| Works like a shortcut | Another name for the same file |
| Points to a pathname | Points to the same inode/data |
| Breaks if the original path is deleted | Still works if the original filename is deleted |
| Can point to directories | Normally cannot point to directories |
| Can cross filesystems | Cannot cross filesystem boundaries |

### Commands

Create a test file:

```bash
echo "Hello Linux" > original.txt
```

Create a soft link:

```bash
ln -s original.txt softlink.txt
```

Create a hard link:

```bash
ln original.txt hardlink.txt
```

Check them:

```bash
ls -li original.txt softlink.txt hardlink.txt
```

The `-i` option shows the inode number. The original file and hard link should have the same inode number.

Test the links:

```bash
cat original.txt
cat softlink.txt
cat hardlink.txt
```

Delete the original file:

```bash
rm original.txt
```

Now check:

```bash
cat softlink.txt
cat hardlink.txt
```

The soft link should fail because its target no longer exists. The hard link should still show:

```text
Hello Linux
```

Delete the links:

```bash
rm softlink.txt
rm hardlink.txt
```

### Interview Answer

**Question: What is the difference between a soft link and a hard link?**

A soft link is like a shortcut and points to the path of another file. If the original file is removed, the soft link becomes broken. A hard link is another name for the same file data and inode, so it can still access the data even if the original filename is deleted. Hard links normally cannot be used for directories or across different filesystems.

---

![alt text](<../Screenshots/Linux_Fundamentals/Screenshot 2026-08-31 at 9.56.15 PM.png>)

# Task 2: `adduser` vs `useradd`

## `useradd`

`useradd` is a low-level Linux command used to create users.

Example:

```bash
sudo useradd -m testuser
```

The `-m` option creates a home directory for the user.

You may also need to set a password:

```bash
sudo passwd testuser
```

## `adduser`

`adduser` is a more user-friendly command available on Debian/Ubuntu systems.

It provides an interactive process and usually handles things such as:

- Creating the user's home directory
- Setting up the user's basic information
- Asking for a password
- Creating the user more conveniently

Example:

```bash
sudo adduser testuser
```

It will ask you for a password and some optional user information.

## Which one is preferred on Ubuntu?

On **Ubuntu**, `adduser` is generally preferred for normal interactive user creation because it is easier to use and provides sensible defaults.

`useradd` is still useful when you need a lower-level command or when creating users in scripts with specific options.

### Simple interview answer

**Question: What is the difference between `adduser` and `useradd`?**

`useradd` is a lower-level command for creating users. `adduser` is a more user-friendly Debian/Ubuntu utility that makes user creation easier by handling common setup steps interactively. On Ubuntu, `adduser` is generally preferred for creating a normal user manually.

## Create a Test User

Recommended Ubuntu command:

```bash
sudo adduser testuser
```

Check that the user exists:

```bash
id testuser
```

You can also check the user's home directory:

```bash
ls -la /home/testuser
```

### Remove the test user after practice

```bash
sudo deluser --remove-home testuser
```

We only run the removal command if you no longer need the test user.

![alt text](<../Screenshots/Linux_Fundamentals/Screenshot 2026-08-31 at 10.02.31 PM.png>)

---

# Task 3: `journalctl`

## What is `journalctl`?

`journalctl` is a Linux command used to view logs collected by **systemd's journal**.

Logs can help us understand:

- What happened on the system
- Why a service failed
- When a service started or stopped
- Errors and warnings
- System events

Most useful commands require `sudo` when you are viewing logs that are not available to your normal user.

## View All Available Logs

```bash
sudo journalctl
```

This can show a lot of information.

## View the Newest Logs First

```bash
sudo journalctl -r
```

## View Logs from the Current Boot

```bash
sudo journalctl -b
```

## Follow Logs Live

This is similar to watching logs in real time:

```bash
sudo journalctl -f
```

Press `Ctrl+C` to stop.

## Check Logs for a Specific Service

Use the `-u` option with the service name.

For example, for SSH:

```bash
sudo journalctl -u ssh
```

On some Linux distributions, the service may be named `sshd` instead:

```bash
sudo journalctl -u sshd
```

You can check the service status first:

```bash
systemctl status ssh
```

Then view its logs:

```bash
sudo journalctl -u ssh
```

## View Recent Logs

For example, the last 50 lines:

```bash
sudo journalctl -n 50
```

For the last 50 lines of a specific service:

```bash
sudo journalctl -u ssh -n 50
```

## View Logs from a Specific Time

For example:

```bash
sudo journalctl --since "1 hour ago"
```

Or:

```bash
sudo journalctl --since today
```

## Simple interview answer

**Question: What is `journalctl` used for?**

`journalctl` is used to view logs collected by systemd's journal. It is useful for troubleshooting the system and services. We can use options such as `-u` to check logs for a specific service, `-b` for the current boot, and `-f` to follow logs in real time.


![alt text](<../Screenshots/Linux_Fundamentals/Screenshot 2026-08-31 at 10.05.21 PM.png>)
---

# Task 4: Linux Command Cheat Sheet

## Terminal Commands to Run

| Task | Command | Purpose |
|------|---------|---------|
| Check current location | `pwd` | Shows your current directory |
| Check current user | `whoami` | Shows the logged-in username |
| Create homework folder | `mkdir -p ~/linux-homework` | Creates the homework directory |
| Enter homework folder | `cd ~/linux-homework` | Moves into the homework directory |
| Create test file | `echo "Hello Linux" > original.txt` | Creates a file with text |
| Create soft link | `ln -s original.txt softlink.txt` | Creates a symbolic/soft link |
| Create hard link | `ln original.txt hardlink.txt` | Creates a hard link |
| Check links | `ls -li original.txt softlink.txt hardlink.txt` | Shows files and inode numbers |
| Read original file | `cat original.txt` | Displays file contents |
| Read soft link | `cat softlink.txt` | Tests the soft link |
| Read hard link | `cat hardlink.txt` | Tests the hard link |
| Delete original file | `rm original.txt` | Deletes the original file |
| Test soft link after deletion | `cat softlink.txt` | Shows that the soft link is broken |
| Test hard link after deletion | `cat hardlink.txt` | Shows that the hard link still works |
| Delete soft link | `rm softlink.txt` | Removes the soft link |
| Delete hard link | `rm hardlink.txt` | Removes the hard link |
| Create test user | `sudo adduser testuser` | Creates a user on Ubuntu |
| Check test user id | `id testuser` | Shows user and group information |
| Check user's home directory | `ls -la /home/testuser` | Shows the user's home directory |
| Delete test user | `sudo deluser --remove-home testuser` | Removes the test user and home directory |
| View system logs | `sudo journalctl` | Displays system logs |
| View current boot logs | `sudo journalctl -b` | Shows logs from the current boot |
| View last 50 logs | `sudo journalctl -n 50` | Shows the latest 50 log entries |
| View recent logs | `sudo journalctl --since "1 hour ago"` | Shows logs from the last hour |
| View SSH logs | `sudo journalctl -u ssh -n 50` | Shows the latest 50 SSH logs |
| Follow logs live | `sudo journalctl -f` | Displays new logs in real time |
| Check SSH service | `sudo systemctl status ssh` | Checks whether SSH is running |
| List services | `systemctl list-units --type=service` | Lists available services |
| Create practice directory | `mkdir practice` | Creates a practice directory |
| Enter practice directory | `cd practice` | Moves into the directory |
| Create file | `touch file.txt` | Creates an empty file |
| Write to file | `echo "Linux practice" > file.txt` | Adds text to the file |
| Copy file | `cp file.txt copy.txt` | Creates a copy |
| Rename file | `mv copy.txt renamed.txt` | Renames the file |
| List files | `ls -l` | Shows detailed file information |
| Search text | `grep "Linux" file.txt` | Searches for "Linux" in the file |
| Find file | `find . -name "file.txt"` | Searches for file.txt |
| Remove practice folder | `rm -r practice` | Deletes the practice directory |
| Create permissions folder | `mkdir permissions-test` | Creates a folder for permission practice |
| Create permissions file | `touch file.txt` | Creates a test file |
| Check permissions | `ls -l file.txt` | Displays file permissions |
| Change permissions | `chmod 644 file.txt` | Changes file permissions |
| Remove permissions folder | `rm -r permissions-test` | Deletes the practice folder |
| Check disk space | `df -h` | Shows disk usage |
| Check memory | `free -h` | Shows RAM and swap usage |
| Check processes | `ps aux` | Shows running processes |
| Check network | `ip addr` | Shows network interfaces and IP addresses |
| Check ports | `ss -tuln` | Shows listening network ports |

---

## ⭐ Most Important Commands to Memorize

| Command | Remember it as |
|---------|----------------|
| `ln -s` | Create soft link |
| `ln` | Create hard link |
| `adduser` | Create user on Ubuntu |
| `journalctl` | View system logs |
| `journalctl -u` | View service logs |
| `journalctl -f` | View logs live |
| `systemctl status` | Check service status |
| `ls -l` | Check file permissions |
| `chmod` | Change permissions |
| `chown` | Change ownership |
| `ps aux` | View processes |
| `df -h` | Check disk space |
| `free -h` | Check memory |
| `ip addr` | Check IP/network |
| `grep` | Search text |
| `find` | Find files/directories |