# Copyright (c) 2026 Huitzo Inc. All rights reserved.
# SPDX-License-Identifier: LicenseRef-Huitzo-Source-Available

class Huitzo < Formula
  desc "Launcher and CLI manager for Huitzo Intelligence Packs (macOS: Apple Silicon only)"
  homepage "https://huitzo.ai"
  version "0.3.5"
  license :cannot_represent # Huitzo Source-Available License — see LICENSE

  on_macos do
    on_arm do
      url "https://github.com/Huitzo-Inc/huitzo-launcher/releases/download/v#{version}/huitzo-aarch64-apple-darwin"
      sha256 "081a414b8f3c26a8373879020660f879a1d83916583f5c12ca6ddc759f4d18cc"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Huitzo-Inc/huitzo-launcher/releases/download/v#{version}/huitzo-aarch64-unknown-linux-musl"
      sha256 "324c1e92b1a3971486963b0ccd5d295868188d508f81f34709923a941c93c76d"
    end
    on_intel do
      url "https://github.com/Huitzo-Inc/huitzo-launcher/releases/download/v#{version}/huitzo-x86_64-unknown-linux-musl"
      sha256 "a9eec2dc785561927e1a8eac4fee5a36d060b475a5b0a58f3ca5a3f89fd72056"
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
