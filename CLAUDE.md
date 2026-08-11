# Huitzo Homebrew Tap — AI Development Instructions

> **Single source of truth for AI tools working in this repository.**
> This is a submodule of the [Huitzo monorepo](https://github.com/Huitzo-Inc/huitzo).

## What This Repository Is

The official [Homebrew](https://brew.sh) tap for Huitzo. It contains the Ruby formula that tells Homebrew how to download, verify, and install the Huitzo Launcher binary.

This repository is **not** a build system — it distributes pre-built binaries from the [huitzo-launcher](https://github.com/Huitzo-Inc/huitzo-launcher) releases.

## Repository Structure

```
Formula/
├── huitzo.rb          # The Homebrew formula (the only file that matters)
scripts/               # Utility scripts
LICENSE
README.md
TRADEMARKS.md
```

## The Formula (`Formula/huitzo.rb`)

The formula defines:

- **4 platform binaries**: macOS ARM, macOS Intel, Linux ARM (musl), Linux Intel (musl)
- **SHA256 hashes** for each binary — these are the integrity check; a mismatch blocks install
- **`livecheck` block** — tells `brew livecheck` how to find new versions. It matches launcher release tags (`v0.3.2`) and explicitly excludes CLI release tags (`cli-v*`) because the launcher's own `update.rs` enforces the same invariant.
- **`caveats` block** — post-install message shown to the user

## Release Process

When a new launcher version is released:

1. The launcher repo publishes platform binaries to GitHub Releases
2. Update `version` in `huitzo.rb` to match the new tag
3. Update all four `sha256` hashes to match the new binaries
4. Update the `url` lines if the release artifact naming changed
5. Commit and push — Homebrew users get the update on their next `brew update`

**Why this is manual:** Homebrew requires SHA256 hashes in the formula. These cannot be computed from a CI pipeline without either (a) downloading the binaries in CI (which means the CI has the secret) or (b) having a human verify the hashes. The manual step is the integrity check.

## Testing

```bash
# Test the formula locally
brew test-bot --only-tap-syntax Formula/huitzo.rb

# Test a full install (requires macOS)
brew install --build-from-source ./Formula/huitzo.rb
brew test huitzo
```

## What NOT to Do

- **Don't add a `bottle` block** — this tap distributes pre-built binaries from GitHub Releases, not Homebrew bottles. Adding a bottle block would create a second distribution path that could drift from the launcher releases.
- **Don't change the `livecheck` regex without updating the launcher** — the launcher's `update.rs` also filters on `v*` tags. If the regex changes, `brew livecheck` and the launcher's self-update could disagree on what the latest version is.
- **Don't add formulas for other Huitzo tools** — this tap is for the launcher only. The CLI is managed by the launcher itself; other tools have their own distribution channels.
- **Don't commit without updating all four SHA256 hashes** — a partial update means some platforms get the new version and others get a checksum mismatch (install failure).
