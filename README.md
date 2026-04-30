# techwizrd/homebrew-tap

Official Homebrew tap for formulae maintained by [Kunal K. Sarkhel](https://github.com/techwizrd).

## Install

```bash
brew tap techwizrd/tap
brew install fishmarks
```

Available formulae:

- `fishmarks`
- `tapcue`

Or install directly without tapping first:

```bash
brew install techwizrd/tap/fishmarks
```

## Upgrade

```bash
brew update
brew upgrade fishmarks
```

## Uninstall

```bash
brew uninstall fishmarks
```

## Repository layout

- `Formula/`: Homebrew formula definitions.
- `.github/workflows/`: CI checks for formula changes.
- `.github/workflows/autobump.yml`: Scheduled formula version bump PRs.
- `.github/workflows/bottles.yml`: Manual bottle build/publish workflow for this tap.

## Bottles

This tap can publish bottles to GitHub Releases in this repository.

- Run the `Bottles` workflow from Actions (`workflow_dispatch`) and choose a formula name.
- Bottle artifacts are uploaded to a release tag like `tapcue-0.1.0` in `techwizrd/homebrew-tap`.
- The workflow then merges bottle checksums into the formula file.

No bottle files need to be added to the upstream `techwizrd/tapcue` repository.

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

Workflow linting also includes a macOS Bash compatibility guard for GitHub Actions. Avoid Bash 4+ builtins such as `mapfile` and `readarray` in workflow `run:` blocks because `shell: bash` on GitHub macOS runners uses Bash 3.2.
