# Git and GitHub Homework Solutions

### Student Details
| Field | Value |
|---|---|
| **Name** | Monika |
| **Email** | monika.24bcs10333@sst.scaler.com |
| **Enrollment Number** | 10333 (24bcs10333) |
| **Repository** | [Monika-Bhardwaj/devops-heros](https://github.com/Monika-Bhardwaj/devops-heros) |

---

## Task 1: `git commit -a -m` vs `git commit -m`

### Understanding the Difference

| Command | What it does |
|---------|--------------|
| `git commit -m "message"` | Commits only files that are already staged (added with `git add`) |
| `git commit -a -m "message"` | Automatically stages all **tracked** files that have been modified, then commits them (skips the `git add` step) |

> **Note:** `-a` only works on files Git is already tracking. New files still need to be added manually.

### Workflow Performed

- Deleted multiple image files and `Networking_Fundamentals.md` from `Submissions/` directory
- Staged only `Networking_Fundamentals.md` using `git add` and committed with `git commit -m "Testing the command"` (commit `2d60d5f`)
- Staged `image-1.png` individually using `git add`
- Used `git commit -a -m "Testing the command with -a flag"` which automatically staged all remaining deleted image files (`image-1.png` through `image-8.png` and `image.png`) and committed them together (commit `a28ff51`)
- Verified both commits in history using `git log`

### Commands Used

```bash
# Stage only one file and commit
git add Submissions/Networking_Fundamentals.md
git commit -m "Testing the command"

# Stage one file manually, then use -a for remaining tracked files
git add Submissions/image-1.png
git commit -a -m "Testing the command with -a flag"

# Verify commits
git log
```

**Output:**
![alt text](<../Screenshots/Git_GitHub/Screenshot 2026-09-01 at 9.05.22 PM.png>)
![git commit demonstration](<../Screenshots/Git_GitHub/Screenshot 2026-09-01 at 9.06.15 PM.png>)
### Key Takeaway

| Command | When to Use |
|---------|-------------|
| `git commit -m` | When you want to stage specific files individually first |
| `git commit -a -m` | When you want to quickly commit all changes to tracked files |

---

## Task 2: Git Cherry-Pick

### What is Cherry-Pick?

`git cherry-pick` allows you to take a specific commit from one branch and apply it to another branch without merging the entire branch.

### Workflow Performed

- Created 3 baseline commits on `main` branch (Testing the command, Testing the command with -a flag, screenshots corrected)
- Created and switched to new branch `racoon`
- Made 3 additional commits on `racoon` branch (first commit, second commit, third commit) creating files `temp_racoon.txt`, `temp_racoon2.txt`, `temp_racoon3.txt`
- Used `git log --oneline` to identify the commit hash `c6ca12c` (second commit) on `racoon` branch
- Switched back to `main` and executed `git cherry-pick c6ca12c85f46b941da8399991e929751428e09d4`
- Verified the cherry-picked commit (`2dff4d3`) was successfully applied to `main` with file `temp_racoon2.txt`

### Commands Used

```bash
# View branch structure
git branch
# Output: main, * racoon

# Switch to main branch
git checkout main

# Cherry-pick specific commit from racoon branch
git cherry-pick c6ca12c85f46b941da8399991e929751428e09d4

# Verify the cherry-pick was successful
git status
# Output: Your branch is ahead of 'origin/main' by 3 commits

# Verify the commit in history
git log --oneline --grep="second" -i
# Output: 2dff4d3 (HEAD -> main) second commit
```

**Output:**
![git log branches](<../Screenshots/Git_GitHub/Screenshot 2026-09-01 at 9.12.39 PM.png>)
![git branch tracking](<../Screenshots/Git_GitHub/Screenshot 2026-09-01 at 9.17.44 PM.png>)
![alt text](<../Screenshots/Git_GitHub/Screenshot 2026-09-02 at 11.55.14 AM.png>)
![alt text](<../Screenshots/Git_GitHub/Screenshot 2026-09-02 at 11.56.51 AM.png>)

### Key Takeaway

| Command | Purpose |
|---------|---------|
| `git cherry-pick <commit-hash>` | Apply a specific commit from another branch to current branch |
| `git log --oneline` | View commit history to identify commit hashes |
| `git checkout -b branch-name` | Create and switch to a new branch |
| `git checkout branch-name` | Switch to an existing branch |

---

## Combined Summary

### What We Learned

| Task | Key Learning |
|------|--------------|
| **Task 1** | `git commit -a -m` automatically stages all tracked changes, while `git commit -m` requires manual staging with `git add`. The `-a` flag saves time but only works on already tracked files. |
| **Task 2** | `git cherry-pick` allows selective commit transfer between branches. It's useful when you want specific changes without merging entire branches. We successfully brought the "second commit" from the `racoon` branch into `main`. |

### Commands to Remember

```bash
# Task 1 Commands
git add <file>
git commit -m "message"
git commit -a -m "message"
git log

# Task 2 Commands
git checkout -b <branch-name>
git checkout <branch-name>
git log --oneline
git cherry-pick <commit-hash>
git branch
git status
```

---
