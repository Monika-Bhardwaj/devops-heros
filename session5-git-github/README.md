# Git and GitHub Homework Tasks & Lab Report

### Student Details
| Field | Value |
|---|---|
| **Name** | Monika |
| **Email** | [monika.24bcs10333@sst.scaler.com](mailto:monika.24bcs10333@sst.scaler.com) |
| **Enrollment Number** | 10333 (`24bcs10333`) |
| **Host System** | ASUS Laptop (`moneca-VivoBook-ASUSLaptop-X515JA-X515JA`), Ubuntu Linux 24.04 |
| **Repository** | [Monika-Bhardwaj/devops-heros](https://github.com/Monika-Bhardwaj/devops-heros) |

---

## Task 1: `git commit -a -m` vs `git commit -m`

### Technical Differences Explained
| Feature | `git commit -m "msg"` | `git commit -a -m "msg"` |
|---|---|---|
| **Staging Area Requirement** | Requires explicit `git add` to stage files into index before committing | Automatically stages all tracked files that were modified or deleted |
| **Untracked / New Files** | Does not commit untracked files | **Does NOT stage untracked files** (still requires explicit `git add`) |
| **Safety / Precision** | Higher precision; allows committing specific granular changes | Convenient shortcut for committing all ongoing modifications to existing tracked files |

### Live Practical Demonstration
1. Modified tracked file `tracked_file.txt` and created untracked file `untracked_file.txt`.
2. Ran `git commit -m "Testing commit -m without git add"`:
   - **Observed Result**: Git refused to commit, reporting `Changes not staged for commit: modified: tracked_file.txt` and `no changes added to commit`.
3. Ran `git commit -a -m "Testing commit -a -m (auto-stages tracked changes)"`:
   - **Observed Result**: Git automatically staged `tracked_file.txt` and committed it (`[main 47bb83b]`), while leaving `untracked_file.txt` intact as untracked (`?? untracked_file.txt`).

### Screenshot Evidence: Git Commit Comparison
![Git Commit -a -m Comparison](<../Screenshots/Git_GitHub/git_commit_comparison.png>)

---

## Task 2: Git Cherry-Pick

### What is `git cherry-pick`?
`git cherry-pick <commit-hash>` is a powerful Git command that takes the changes introduced in a specific commit from another branch and applies them as a new commit on the currently checked-out branch without requiring a full branch merge or rebase.

### Step-by-Step Workflow Executed
1. **Created baseline commits on `main` branch**:
   - `1cc44e0`: `main: feature commit 1`
   - `82ebd2c`: `main: feature commit 2`
2. **Created and switched to feature branch**:
   ```bash
   git checkout -b feature-monika
   ```
3. **Created 3 commits on `feature-monika`**:
   - `daa68a3`: `feature: add feature A`
   - `5d62efb`: `feature: add feature B targeted for cherry-pick` (Target commit)
   - `bcc1a1b`: `feature: add feature C`
4. **Identified the target commit using `git log --oneline`**:
   Commit hash `5d62efb` was identified for `feature_b.txt`.
5. **Switched to `main` branch**:
   ```bash
   git checkout main
   ```
6. **Executed cherry-pick**:
   ```bash
   git cherry-pick 5d62efb
   ```
   **Output:**
   ```text
   [main c694f8a] feature: add feature B targeted for cherry-pick
    1 file changed, 1 insertion(+)
    create mode 100644 feature_b.txt
   ```
7. **Verified history on `main`**:
   `git log --oneline -n 3` confirmed that `feature_b.txt` is now available directly on `main` with new commit hash `c694f8a`, while preserving commit history cleanly!

### Screenshot Evidence: Git Cherry-Pick Workflow
![Git Cherry Pick Workflow](<../Screenshots/Git_GitHub/git_cherry_pick_workflow.png>)
