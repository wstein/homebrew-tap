# Adding a new app to the tap

This tap owns the formula structure. Upstream release workflows only send a
version number; the tap bumps `url`/`sha256`, opens a PR and auto-merges it
once `test-bot` passes. A new app therefore needs a formula plus three small
registrations.

## 1. Write the formula

Create `Formula/<name>.rb` (lowercase, dashes). Pick the pattern that fits:

- **npm package**: `url` is the registry tarball
  (`https://registry.npmjs.org/<scope>/<pkg>/-/<pkg>-X.Y.Z.tgz`), install with
  `std_npm_args` and `bin.install_symlink Dir["#{libexec}/bin/*"]`
  (see `Formula/cx-cli.rb`).
- **Prebuilt binary or tarball**: one `url`/`sha256` pair per platform inside
  `if OS.mac? … else … end`, plus `depends_on arch:` (see `Formula/histlog.rb`).
- **Source build**: follow the
  [Formula Cookbook](https://docs.brew.sh/Formula-Cookbook).

Rules the bump script relies on:

- Every release asset is declared as `url "…"` immediately followed by
  `sha256 "…"` on the next line, with equal indentation.
- The version appears in the URL, so no separate `version` line is needed.
- Include a real `test do` block that asserts on `--version` or similar.

## 2. Verify locally

```sh
brew tap wstein/tap /path/to/this/checkout   # or work from the tap directory
brew style Formula/<name>.rb
brew audit --strict --new --online wstein/tap/<name>
brew install --build-from-source wstein/tap/<name>
brew test wstein/tap/<name>
```

## 3. Register the formula

1. **`.github/scripts/bump_formula.py`**: add an entry to `FORMULAE` (a regex
   for the version inside the URL and a function that rewrites the URL for a
   new version) so [manual bumps](updating-a-formula.md) work. Check it is a
   no-op on the current version:
   `python3 .github/scripts/bump_formula.py <name> <current-version>` must leave
   `git diff` empty.
2. **README**: add a row to the formulae table.

Open a PR with conventional commits, for example `feat(<name>): add formula`.
Merging requires the three `test-bot` checks to be green.
