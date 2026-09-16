# Copyright (c) 2026 Huitzo Inc. All rights reserved.
# SPDX-License-Identifier: LicenseRef-Huitzo-Source-Available

class Huitzo < Formula
  desc "Launcher and CLI manager for Huitzo Intelligence Packs (macOS: Apple Silicon only)"
  homepage "https://huitzo.ai"
  version "0.3.4"
  license :cannot_represent # Huitzo Source-Available License — see LICENSE

  on_macos do
    on_arm do
      url "https://github.com/Huitzo-Inc/huitzo-launcher/releases/download/v#{version}/huitzo-aarch64-apple-darwin"
      sha256 "1b542c363f59ac194ece059ebd748ac4191b560377e114351275b3a78fbee4ad"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Huitzo-Inc/huitzo-launcher/releases/download/v#{version}/huitzo-aarch64-unknown-linux-musl"
      sha256 "8e6356c4fa781963cb22a3c64719838730e6aae7ca9fe068a54b3aa3db7184c5"
    end
    on_intel do
      url "https://github.com/Huitzo-Inc/huitzo-launcher/releases/download/v#{version}/huitzo-x86_64-unknown-linux-musl"
      sha256 "70011351905cc8ddd7a48b2d59b4a77962f1dd17cf01802060b2b7bf9b583c00"
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
