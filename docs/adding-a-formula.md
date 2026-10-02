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

## 3. Register it for automatic updates

1. **`.github/scripts/bump_formula.py`**: add an entry to `FORMULAE`: a regex
   for the version inside the URL, and a function that rewrites the URL for a
   new version. Check it is a no-op on the current version:
   `python3 .github/scripts/bump_formula.py <name> <current-version>` must leave
   `git diff` empty.
2. **`.github/workflows/update-formula.yml`**: add `<name>` to the
   `workflow_dispatch` options and to the `case` list in "Validate inputs".
   Unknown names are rejected on purpose.
3. **README**: add a row to the formulae table.

Open a PR with conventional commits, for example
`feat(<name>): add formula` and `ci: register <name> for auto-bump`.
Merging requires the three `test-bot` checks to be green.

## 4. Wire up the upstream release

In the upstream repository's release workflow, after the release assets or npm
package are published, add:

```yaml
homebrew:
  needs: [<publish-job>]
  runs-on: ubuntu-latest
  environment: homebrew
  permissions: {}
  steps:
    - id: app
      uses: actions/create-github-app-token@bcd2ba49218906704ab6c1aa796996da409d3eb1 # v3
      with:
        app-id: ${{ secrets.TAP_APP_ID }}
        private-key: ${{ secrets.TAP_APP_PRIVATE_KEY }}
        owner: wstein
        repositories: homebrew-tap
    - env:
        GH_TOKEN: ${{ steps.app.outputs.token }}
      run: |
        gh api repos/wstein/homebrew-tap/dispatches \
          -f event_type=new-release \
          -f 'client_payload[formula]=<name>' \
          -f 'client_payload[version]=<version without v>'
```

The assets must exist before this job runs, because the tap downloads them to
compute checksums.

Add the repo secrets `TAP_APP_ID` and `TAP_APP_PRIVATE_KEY` (in the `homebrew`
environment) in the upstream repository.

## 5. Check it end to end

```sh
gh workflow run update-formula.yml -R wstein/homebrew-tap -f formula=<name> -f version=<current-version>
```

Using the current version should end with "Formula already at …" and no PR.
The first real release should produce a `bump/<name>-<version>` PR that
merges itself after CI.

## One-time setup (already done for this tap)

- A GitHub App (`wstein-tap-bot`) with Contents and Pull requests write access,
  installed on `homebrew-tap`; secrets `APP_ID` and `APP_PRIVATE_KEY` in the tap.
- The `main` ruleset requiring a PR and the `test-bot` checks, and
  "Allow auto-merge" enabled in the repo settings.

## Troubleshooting

- **Bump PR never gets CI**: it was opened with `GITHUB_TOKEN`. It must use the
  App token, or workflows will not trigger.
- **"no url/sha256 pair found"**: the formula's `url`/`sha256` lines are not
  adjacent or are indented differently.
- **Checksum download fails**: the dispatch ran before the assets were published.
  Re-run with `workflow_dispatch`.
