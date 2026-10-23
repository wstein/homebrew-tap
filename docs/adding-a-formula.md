# Adding a new app to the tap

This tap owns the formula structure. Updates are manual (see
[updating-a-formula.md](updating-a-formula.md)): nothing upstream notifies the
tap, so a new app needs a formula plus two small registrations.

## 1. Write the formula

Create `Formula/<name>.rb` (lowercase, dashes). Pick the pattern that fits:

- **npm package**: `url` is the registry tarball
  (`https://registry.npmjs.org/<scope>/<pkg>/-/<pkg>-X.Y.Z.tgz`), install with
  `std_npm_args` and `bin.install_symlink Dir["#{libexec}/bin/*"]`
  (see `Formula/cx-cli.rb`).
- **Prebuilt release archives**: one `url`/`sha256` pair per platform, chosen
  with `OS.mac?` / `Hardware::CPU.arm?` (see `Formula/histlog.rb`,
  `Formula/smill.rb`, `Formula/cscribe.rb`, `Formula/whr.rb`). Declare only the platforms the
  upstream release really ships and Homebrew supports (macOS arm64/Intel,
  Linux x86_64/arm64); add `depends_on arch:` when a platform is missing.
  Inspect the archive first (`tar -tzf`): Homebrew strips a single top-level
  directory, so `bin.install "<tool>"` works for `<tool>_X.Y.Z_<os>_<arch>/<tool>`.
- **Source build**: follow the
  [Formula Cookbook](https://docs.brew.sh/Formula-Cookbook).

Rules the bump script relies on:

- Every release asset is declared as `url "…"` immediately followed by
  `sha256 "…"` on the next line, with equal indentation. Nothing else may sit
  between them. Nesting (for example `if Hardware::CPU.arm?` inside
  `if OS.mac?`) is fine as long as each pair stays together.
- The version appears in the URL, so no separate `version` line is needed.
  For GitHub releases of the shape
  `…/releases/download/vX.Y.Z/<tool>_X.Y.Z_<os>_<arch>.tar.gz` the version
  appears twice; the bump script rewrites both.
- A release tag with a path prefix (`bdock/v0.1.0`) needs an explicit top-level
  `version "X.Y.Z"` line, because Homebrew cannot parse the version from such a
  URL (it detected `64`). The bump script rewrites an existing `version` line.
- Never type a `sha256` by hand. Compute it from the downloaded asset and
  cross-check it against the release's `SHA256SUMS` asset (below).
- `license` is the upstream SPDX identifier (check the upstream `LICENSE`).
- Include a real `test do` block: assert on the version output (a plain
  `--version` or `version` command; use `assert_match version.to_s` only if the
  output contains the version) and, where the CLI has one, run a harmless
  command on files created inside `testpath`. A `test do` block must not use
  the network or touch the user's files.

## 2. Verify checksums and layout

For a prebuilt-archive formula, with `<tag>` the release tag and `<owner/repo>`
the upstream repository:

```sh
mkdir -p /tmp/<name>-dl && cd /tmp/<name>-dl
gh release download <tag> -R <owner/repo> -p '<name>_*' -p SHA256SUMS
sha256sum <name>_*_darwin_*.tar.gz <name>_*_linux_*.tar.gz   # shasum -a 256 on macOS
grep -E '<archive-name-1>|<archive-name-2>' SHA256SUMS       # must match line for line
tar -tzf <archive>                                           # confirm where the binary is
```

Run the Linux binary of your own architecture if you can (extract into an empty
directory and call its version command) to confirm what the version output and
the `test do` commands really print.

## 3. Verify with Homebrew

```sh
brew tap wstein/tap /path/to/this/checkout   # or work from the tap directory
brew style Formula/<name>.rb
brew audit --strict --new --online wstein/tap/<name>
brew install --build-from-source wstein/tap/<name>
brew test wstein/tap/<name>
```

## 4. Register the formula

1. **`.github/scripts/bump_formula.py`**: add an entry to `FORMULAE` (a regex
   for the version inside the URL and a function that rewrites the URL for a
   new version), then check it is a no-op on the current version:
   `python3 .github/scripts/bump_formula.py <name> <current-version>` must
   leave `git diff` empty. The script downloads every asset, so this also
   proves the URLs resolve and the stored checksums are right.
2. **README**: add a row to the formulae table (platforms as the formula
   supports them).
3. **`AGENTS.md`**: add the formula to the inventory.

Open a PR with conventional commits, for example `feat: add <name> formula`.
Merging requires the `brew test-bot` jobs to be green; the owner merges.
