# homebrew-tap

Homebrew formulae maintained by [Werner Stein](https://github.com/wstein).

The tap itself is licensed under the [EUPL-1.2](LICENSE). Each formula's `license` field describes the packaged upstream software.

## Formulae

| Formula | Description | Platforms |
| --- | --- | --- |
| `cx-cli` | Repository-native toolchain for MCP workspaces and AI handoffs | macOS, Linux |
| `histlog` | Log-structured shell history with NDJSON capture and SQLite query projection | macOS (arm64), Linux (x86_64) |
| `smill` | Git-native cheatsheet compiler for Markdown and YAML reference sheets | macOS (arm64), Linux (x86_64, arm64) |
| `cscribe` | Plain-text Zettelkasten tooling for Markdown notes | macOS, Linux (x86_64, arm64) |

## How do I install these formulae?

`brew install wstein/tap/<formula>`

Or `brew tap wstein/tap` and then `brew install <formula>`.

Or, in a `brew bundle` `Brewfile`:

```ruby
brew tap "wstein/tap"
brew "<formula>"
```

## Updates

Formulae are updated manually after an upstream release; see
[docs/updating-a-formula.md](docs/updating-a-formula.md). Every change goes
through a PR and must pass `brew test-bot` on macOS (Intel and Apple Silicon
runners) and Linux.

## Contributing

To add another app to this tap, see [docs/adding-a-formula.md](docs/adding-a-formula.md).

Coding agents (LLMs) should start with [AGENTS.md](AGENTS.md), which lists the formulae, the exact commands and the rules for pull requests.

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).
