# Expected Results (Not Captured Execution)

These are acceptance criteria, not claims that the commands were executed in the package-building environment.

## Lifecycle

- Install: release `session15` reaches `deployed`, revision 1.
- Upgrade V2: revision 2, replica count 3, app version 2.0.0.
- Upgrade V3: revision 3, replica count 4, app version 3.0.0.
- Rollback to 2: a new revision is created; effective configuration returns to replica count 3 and app version 2.0.0.
- Uninstall: release is removed.

## Repository/search

After adding Bitnami and updating repositories:

```bash
helm repo list
helm search repo nginx
```

should return the configured repository and matching chart entries, subject to current repository contents/network availability.
