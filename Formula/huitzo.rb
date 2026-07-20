# Copyright (c) 2026 Huitzo Inc. All rights reserved.
# SPDX-License-Identifier: LicenseRef-Huitzo-Source-Available

class Huitzo < Formula
  desc "Launcher and CLI manager for Huitzo Intelligence Packs"
  homepage "https://huitzo.ai"
  version "0.3.2"
  license :cannot_represent # Huitzo Source-Available License — see LICENSE

  on_macos do
    on_arm do
      url "https://github.com/Huitzo-Inc/huitzo-launcher/releases/download/v#{version}/huitzo-aarch64-apple-darwin"
      sha256 "97ff11197a7cf47a23adc13ecf6741fddd92a91775360ff4c65030bd1087cb73"
    end
    on_intel do
      url "https://github.com/Huitzo-Inc/huitzo-launcher/releases/download/v#{version}/huitzo-x86_64-apple-darwin"
      sha256 "40a001b882c417eb6ce386449989f7784a653a84058fa69c2eff9fb6e65e45f4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Huitzo-Inc/huitzo-launcher/releases/download/v#{version}/huitzo-aarch64-unknown-linux-musl"
      sha256 "dc4e96e1ce47c171bcdff898105975babe68823667272329d535e11f60933863"
    end
    on_intel do
      url "https://github.com/Huitzo-Inc/huitzo-launcher/releases/download/v#{version}/huitzo-x86_64-unknown-linux-musl"
      sha256 "eca612002d48fedf99bfd98d3717078cc71a7d2ff8dad7c853c450066098c2f7"
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
