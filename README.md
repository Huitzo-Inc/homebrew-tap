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

1. Provisions a managed CPython via `uv` (`uv python install`) if no usable
   Python is already on your system -- you don't need Python preinstalled
2. Creates a managed virtual environment at `~/.huitzo/venv/`
3. Installs the Huitzo CLI from Huitzo's release manifest (`cli-release.json`);
   integrity is checked via a SHA-256 published inside that same feed --
   the manifest itself is **not signed** (Ed25519 signing is tracked
   separately and not yet implemented)
4. Keeps the CLI up to date automatically (the launcher binary itself
   is updated via `brew upgrade huitzo`)

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
| `huitzo` | Huitzo CLI Launcher | macOS (Apple Silicon only), Linux glibc (x86_64 + aarch64) |

macOS Intel (x86_64) is not supported -- the CLI's release feed publishes no
`macos-x86_64` wheel. Linux musl/Alpine is not supported either -- the feed
publishes `manylinux` (glibc) wheels only.

## Updating

```sh
brew update && brew upgrade huitzo
```

**Keeping brew current:** this formula's `version` and `sha256` values are
bumped automatically by the launcher repo's release workflow whenever a new
launcher version ships -- no manual step is required. `brew update && brew
upgrade huitzo` is all you need to stay current.

## Troubleshooting

**Tap not found:**
```sh
brew tap Huitzo-Inc/tap
brew install huitzo
```

**Python-related install failure:**
You don't need Python preinstalled -- if the launcher finds no interpreter
at all, it provisions a managed CPython via `uv`. But if it finds an
interpreter that's too old, it refuses rather than provisioning a
replacement: the CLI's release feed only publishes `cp312`/`cp313` wheels,
so a host whose only Python is 3.11 or older fails with a clear error
regardless of network access. Install Python 3.12+ yourself (e.g. `brew
install python@3.13` on macOS) and re-run.

**Reset the managed environment:**
```sh
huitzo --launcher-bootstrap
```

## Links

- [Huitzo CLI Launcher](https://github.com/Huitzo-Inc/huitzo-launcher) -- Source code and releases
- [Huitzo Documentation](https://huitzo.ai) -- Platform documentation
- [Huitzo Launcher install script](https://github.com/Huitzo-Inc/huitzo-launcher#install) -- the equivalent `curl | sh` install path

## License

Source-available under the **Huitzo Source-Available License** — see
[LICENSE](LICENSE). "Huitzo" and the Huitzo logo are trademarks of
Huitzo Inc. — see [TRADEMARKS.md](TRADEMARKS.md).
