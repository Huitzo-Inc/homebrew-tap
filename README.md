# Huitzo Homebrew Tap

Official [Homebrew](https://brew.sh) tap for [Huitzo](https://huitzo.ai) -- the Operating System for Intelligence.

## Install

```sh
brew install Huitzo-Inc/tap/huitzo
```

After the first install, Homebrew remembers the tap. Future commands work with just the formula name:

```sh
brew upgrade huitzo
brew info huitzo
brew uninstall huitzo
```

## What Gets Installed

The `huitzo` formula installs the **Huitzo Launcher** -- a lightweight Rust binary (~2 MB) that:

1. Discovers Python 3.11+ on your system
2. Creates a managed virtual environment at `~/.huitzo/venv/`
3. Installs the Huitzo CLI from PyPI
4. Keeps it up to date automatically

All CLI commands pass through transparently:

```sh
huitzo --version          # Python CLI version
huitzo pack new my-pack   # Create a new Intelligence Pack
huitzo pack dev           # Start local development server
huitzo --launcher-version # Launcher binary version
```

## Available Formulas

| Formula | Description | Platforms |
|---------|-------------|-----------|
| `huitzo` | Huitzo CLI Launcher | macOS (Intel + Apple Silicon), Linux (x86_64 + aarch64) |

## Updating

```sh
brew update && brew upgrade huitzo
```

## Troubleshooting

**Tap not found:**
```sh
brew tap Huitzo-Inc/tap
brew install huitzo
```

**Python not found after install:**
The launcher needs Python 3.11+ on your system. Install it with:
```sh
brew install python@3.13
```

**Reset the managed environment:**
```sh
huitzo --launcher-bootstrap
```

## Links

- [Huitzo CLI Launcher](https://github.com/Huitzo-Inc/huitzo-launcher) -- Source code and releases
- [Huitzo Documentation](https://huitzo.ai) -- Platform documentation
- [Huitzo SDK](https://github.com/Huitzo-Inc/sdk) -- Intelligence Pack SDK
