# Fork Update Guide (MUIO-Mac)

This repo is the macOS port of MUIO. We keep base code aligned with upstream
(`OSeMOSYS/MUIO`) and carry mac-specific changes in the `macport` branch.

## One-time setup

```
git remote add upstream https://github.com/OSeMOSYS/MUIO.git
```

## Sync upstream into your fork

```
git fetch upstream
git checkout main
git merge --ff-only upstream/main
git push origin main
```

## Update the macport branch

```
git checkout macport
git rebase upstream/main
git push origin macport --force-with-lease
```

If conflicts occur:

```
git add <files>
git rebase --continue
```

## Notes

- Keep mac-specific changes in `macport` only.
- Avoid editing base logic unless required for macOS compatibility.
