# Updating a formula after an upstream release

Updates are manual: no workflow in this tap listens for upstream releases, and
`.github/dependabot.yml` only watches GitHub Actions. After a new upstream
release is published (npm package or GitHub release assets must exist):

```sh
git fetch origin
git switch -c bump/<name>-<version> origin/main
python3 .github/scripts/bump_formula.py <name> <version>   # rewrites url + sha256
git diff                                                   # review
brew style Formula/<name>.rb
brew audit --strict --online wstein/tap/<name>
git commit -am "chore(<name>): update to v<version>"
git push -u origin HEAD
gh pr create --fill
```

`<version>` may be given with or without a leading `v`.

## What the script does

For every `url "…"` line that is immediately followed by a `sha256 "…"` line
with the same indentation, the script rewrites the version in the URL (twice
for `…/vX.Y.Z/<tool>_X.Y.Z_<os>_<arch>.tar.gz`), downloads the asset and
replaces the checksum with the one it computed. It prints every new URL and
digest. It does not touch anything else, so a formula whose pairs are not
adjacent is not updated (the script fails with "no url/sha256 pair found" only
when there is no pair at all; check `git diff` shows every platform changed).

## Cross-check against the release

For GitHub-release formulae compare the printed digests with the release's
checksum file:

```sh
gh release download v<version> -R <owner/repo> -p SHA256SUMS -O -
```

A formula whose release tag has a prefix (`bdock`) uses `<prefix>/v<version>`
(`bdock/v<version>`) instead of `v<version>`.
Such a formula also carries an explicit `version` line, which the script updates
along with url and sha256.

Every digest the script printed must appear there for the same file name. If
not, stop and investigate; do not edit the checksum by hand.

## Idempotence check

Running the script with the version already in the formula must leave
`git diff` empty. Use this after editing `FORMULAE` or after restructuring a
formula by hand.

## When upstream changes how it ships

If upstream adds or removes platforms or renames assets, edit the formula by
hand (keeping each `url`/`sha256` pair adjacent), adjust the URL rewriting in
`.github/scripts/bump_formula.py` if needed, update the platforms column in the
README, and run the idempotence check.

CI (`brew test-bot` on macOS Intel, macOS Apple Silicon and Linux) must pass
before merging; the owner merges.

## Future

Upstream releases do not notify the tap yet; a dispatch from upstream release
workflows to an automated bump PR would be new work.
