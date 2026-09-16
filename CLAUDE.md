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

- **3 platform binaries**: macOS ARM (Apple Silicon only -- Intel macOS is unsupported), Linux ARM (musl), Linux Intel (musl)
- **SHA256 hashes** for each binary — these are the integrity check; a mismatch blocks install
- **`livecheck` block** — tells `brew livecheck` how to find new versions. It matches launcher release tags (`v0.3.2`) and explicitly excludes CLI release tags (`cli-v*`) because the launcher's own `update.rs` enforces the same invariant.
- **`caveats` block** — post-install message shown to the user

## Release Process

The `version` and `sha256` bump is **automated** — do not hand-edit it.

1. The launcher repo publishes platform binaries to GitHub Releases.
2. The launcher's `release.yml` workflow runs an `update-tap` job that
   rewrites `version` and all `sha256` values in this formula from the
   just-published assets, opens a PR against this repo, and **auto-merges
   it** — it fails loudly rather than leaving brew serving a stale launcher.
3. Homebrew users get the update on their next `brew update && brew upgrade
   huitzo`.

**Do not hand-edit `version`, `sha256`, or the `url` lines.** A manual edit
races the automation and can reintroduce exactly the staleness this
mechanism exists to prevent (see launcher issue #16). The only edits that
should be made by hand are structural ones: adding or removing a platform
block, `desc`, `caveats`, or the `livecheck` block.

**Livecheck / update.rs must stay in step.** The `livecheck` regex here
(`^v(\d+(?:\.\d+)+)$`) and the launcher's own `update.rs` tag filter both
select `v*` tags and exclude `cli-v*` tags — the same invariant enforced on
both sides. The current regex matches release tags only; it would **not**
match a pre-release tag like `v0.3.4-rc1`. Do not publish a pre-release
launcher tag without revisiting both this regex and `update.rs` together.

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
- **Don't hand-edit `version` or `sha256`** — the launcher's `update-tap` job owns those lines; a manual edit races the automation (see Release Process above). If you must touch the formula structurally, update all three `sha256` values together — a partial update means some platforms get the new version and others get a checksum mismatch (install failure).
