# Updating a formula after an upstream release

Updates are manual. After a new upstream release is published (npm package or
GitHub release assets must exist):

```sh
git switch -c bump/<name>-<version> origin/main
python3 .github/scripts/bump_formula.py <name> <version>   # rewrites url + sha256
git diff                                                   # review
brew style Formula/<name>.rb
brew audit --strict --online wstein/tap/<name>
git commit -am "chore(<name>): update to v<version>"
git push -u origin HEAD
gh pr create --fill
```

The script downloads each asset and computes its checksum. CI (`brew test-bot`
on macOS Intel, macOS Apple Silicon and Linux) must pass before merging.

If upstream changes how it ships (new platforms, renamed assets), edit the
formula by hand and, if needed, adjust the URL rewriting in
`.github/scripts/bump_formula.py`.
