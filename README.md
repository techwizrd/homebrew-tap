# techwizrd/homebrew-tap

Official Homebrew tap for formulae maintained by [Kunal K. Sarkhel](https://github.com/techwizrd).

## Install

```bash
brew tap techwizrd/tap
brew install tapcue
```

Or install directly without tapping first:

```bash
brew install techwizrd/tap/tapcue
```

## Upgrade

```bash
brew update
brew upgrade tapcue
```

## Uninstall

```bash
brew uninstall tapcue
```

## Repository layout

- `Formula/`: Homebrew formula definitions.
- `.github/workflows/`: CI checks for formula changes.
- `.github/workflows/autobump.yml`: Scheduled formula version bump PRs.

## Maintainers

When updating a formula:

1. Edit the corresponding file in `Formula/`.
2. Use tagged upstream releases for stable formula URLs.
3. Run local checks:
   - `brew style Formula/*.rb`
   - `for f in Formula/*.rb; do brew audit --strict --online --formula "techwizrd/local/$(basename "$f" .rb)"; done`
   - `prek run --all-files`
4. Open a pull request.

This repository includes `.pre-commit-config.yaml` with general linting plus Homebrew-specific checks. The `brew audit` hook mirrors your local `Formula/*.rb` files into a local `techwizrd/local` tap before auditing, so `prek run --all-files` works on uncommitted changes.
