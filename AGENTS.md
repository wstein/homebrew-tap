# Agent instructions for wstein/homebrew-tap

This is a Homebrew tap (`brew install wstein/tap/<formula>`) owned by Werner
Stein. It contains formulae only; the upstream software lives in other
repositories. Humans: see [README.md](README.md) and [docs/](docs/).

## Formulae

| Formula | Upstream | Packaging |
| --- | --- | --- |
| `cx-cli` | wstein/cx-cli | npm tarball, `std_npm_args` |
| `histlog` | wstein/histlog | prebuilt archives (macOS arm64, Linux x86_64) |
| `smill` | wstein/sheetmill | prebuilt archives (macOS arm64, Linux x86_64/arm64) |
| `cscribe` | wstein/chartscribe | prebuilt archives (macOS arm64/Intel, Linux x86_64/arm64) |
| `cubacle` | wstein/cubacle | prebuilt archives (macOS arm64/Intel, Linux x86_64/arm64) |
| `whr` | wstein/workharbor | prebuilt archives (macOS arm64, Linux x86_64/arm64) |
| `stw` | wstein/sourcesteward | prebuilt archives (macOS arm64/Intel, Linux x86_64/arm64) |
| `bdock` | wstein/bundledock | prebuilt archives (macOS arm64, Linux x86_64/arm64); tag `bdock/vX.Y.Z` |

## Bump a formula

```sh
git fetch origin && git switch -c bump/<name>-<version> origin/main
python3 .github/scripts/bump_formula.py <name> <version>   # downloads assets, rewrites url + sha256
git diff                                                   # every platform pair must change
gh release download v<version> -R <owner/repo> -p SHA256SUMS -O -   # digests must match
# prefixed tag (bdock): bdock/v<version> instead of v<version>
git commit -am "chore(<name>): update to v<version>"
git push -u origin HEAD && gh pr create --fill
```

Details: [docs/updating-a-formula.md](docs/updating-a-formula.md). Upstream
releases do not notify the tap; bumps are manual (dispatch automation is
future work).

## Add a formula

Follow [docs/adding-a-formula.md](docs/adding-a-formula.md): write
`Formula/<name>.rb`, inspect the archive (`tar -tzf`), verify checksums against
`SHA256SUMS`, register it in `FORMULAE` in `.github/scripts/bump_formula.py`,
check `python3 .github/scripts/bump_formula.py <name> <current-version>` leaves
`git diff` empty, and add a README table row and a row above.

## Rules

- One PR per change; Conventional Commits, one logical change per commit
  (`feat: add <name> formula`, `chore(<name>): update to v<version>`).
- Never push `main`, never merge: push your own topic branch and open the PR.
  The owner merges.
- Keep each `url "…"` immediately followed by `sha256 "…"` with equal
  indentation; the bump script depends on it.
- Tags with a path prefix (`bdock/v…`) need an explicit top-level `version` line
  (Homebrew cannot parse the version from the URL); the bump script updates it.
- Never edit a `sha256` by hand: compute it from the downloaded asset (the
  script does) and cross-check against the release's `SHA256SUMS`.
- `test do` must be real and must not use the network or the user's files:
  assert the version output and use files under `testpath`.
- No `Claude-Session:` trailer or session URL in commits or PR bodies.
- Do not add vendor-specific agent files (no `CLAUDE.md`); this file is the
  single agent entry point.

## Checks that must be green

The `brew test-bot` workflow (`.github/workflows/tests.yml`) on `macos-15-intel`,
`macos-26` and the Linux Homebrew container: `--only-tap-syntax` on every run,
`--only-formulae` on pull requests.

## What you cannot verify locally

Without a `brew` binary you cannot run `brew style`, `brew audit`,
`brew install` or `brew test`, nor test macOS binaries or arm64 archives on an
x86_64 host. Run what you can (the bump script, `sha256sum`, `tar -tzf`, the
Linux binary of your architecture) and say in the PR which Homebrew checks were
not run; rely on `brew test-bot` CI.
