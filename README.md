# Wstein Tap

Homebrew formulae maintained by [Werner Stein](https://github.com/wstein).

The tap itself is licensed under the [EUPL-1.2](LICENSE). Each formula's `license` field describes the packaged upstream software.

## Formulae

| Formula | Description | Platforms |
| --- | --- | --- |
| `cx-cli` | Repository-native toolchain for MCP workspaces and AI handoffs | macOS, Linux |
| `histlog` | Log-structured shell history with NDJSON capture and SQLite query projection | macOS (arm64), Linux (x86_64) |

## How do I install these formulae?

`brew install wstein/tap/<formula>`

Or `brew tap wstein/tap` and then `brew install <formula>`.

Or, in a `brew bundle` `Brewfile`:

```ruby
brew tap "wstein/tap"
brew "<formula>"
```

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).
