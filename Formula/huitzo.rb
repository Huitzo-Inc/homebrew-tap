# Copyright (c) 2026 Huitzo Inc. All rights reserved.
# SPDX-License-Identifier: LicenseRef-Huitzo-Source-Available

class Huitzo < Formula
  desc "Launcher and CLI manager for Huitzo Intelligence Packs (macOS: Apple Silicon only)"
  homepage "https://huitzo.ai"
  version "0.3.3"
  license :cannot_represent # Huitzo Source-Available License — see LICENSE

  on_macos do
    on_arm do
      url "https://github.com/Huitzo-Inc/huitzo-launcher/releases/download/v#{version}/huitzo-aarch64-apple-darwin"
      sha256 "2e3fec38b3fe9bf5eb4a95fae602e561eb3b947170654bc4cc2b5f0b9caeff2e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Huitzo-Inc/huitzo-launcher/releases/download/v#{version}/huitzo-aarch64-unknown-linux-musl"
      sha256 "7f51335a930a51f150b4ebb665eb5e1cda6214eeace41a0fc3bca237625e839f"
    end
    on_intel do
      url "https://github.com/Huitzo-Inc/huitzo-launcher/releases/download/v#{version}/huitzo-x86_64-unknown-linux-musl"
      sha256 "db587c9862c4521ea87241880a966ee020fbc4df6715427c0dda69aec6434ee4"
    end
  end

  livecheck do
    url "https://github.com/Huitzo-Inc/huitzo-launcher"
    # The launcher repo also publishes cli-v* releases; match launcher tags
    # only (same invariant the launcher's update.rs enforces).
    strategy :github_releases
    regex(/^v(\d+(?:\.\d+)+)$/i)
  end

  def install
    binary = Dir["huitzo-*"].first || "huitzo"
    bin.install binary => "huitzo"
  end

  def caveats
    <<~EOS
      On first run, huitzo asks for install consent (recorded in
      ~/.huitzo/consent.jsonl) and then bootstraps the Huitzo CLI into
      ~/.huitzo. Check what is present on your system with:
        huitzo --launcher-detect --human

      The launcher defers its own updates to Homebrew — update with:
        brew upgrade huitzo
    EOS
  end

  test do
    assert_match "huitzo-launcher", shell_output("#{bin}/huitzo --launcher-version")
  end
end
