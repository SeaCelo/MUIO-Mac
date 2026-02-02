# Fork Update Guide (MUIO-Mac)

This repo is the macOS port of MUIO. It is a standalone fork and does not send
PRs upstream. We keep a local `upstream-master` branch as a snapshot of the
upstream Windows foundation (`OSeMOSYS/MUIO`) and carry mac-specific changes
in the `main` branch.

## One-time setup

```
git remote add upstream https://github.com/OSeMOSYS/MUIO.git
```

## Update your local clone

Use this when you want the latest changes from the macOS port:

```
git checkout main
git pull
```

## Create a feature branch

Use a short, descriptive name:

```
git checkout -b feature/your-change
```

Make your changes, then commit:

```
git add -A
git commit -m "Describe your change"
```

## Submit a PR

Push your branch to your fork and open a PR against `main` in `SeaCelo/MUIO-Mac`:

```
git push -u origin feature/your-change
```

## Update the upstream snapshot branch

```
git fetch upstream
git checkout -B upstream-master upstream/master
```

## Rebase the macOS branch when desired

Why rebase? If upstream changes core functions or data handling, rebasing keeps
the macOS port aligned while preserving mac-specific changes.

```
git checkout main
git rebase upstream-master
git push origin main --force-with-lease
```

If conflicts occur:

```
git add <files>
git rebase --continue
```

## Notes

- `main` is the supported macOS branch that users should clone.
- `upstream-master` is local only and should not be pushed to origin.
- Never push to upstream; upstream is a read-only reference.
- Keep mac-specific changes in `main` only.
- Avoid editing base logic unless required for macOS compatibility.
