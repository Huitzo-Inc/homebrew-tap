# Copyright (c) 2026 Huitzo Inc. All rights reserved.
# SPDX-License-Identifier: LicenseRef-Huitzo-Source-Available

class Huitzo < Formula
  desc "Launcher and CLI manager for Huitzo Intelligence Packs"
  homepage "https://huitzo.ai"
  version "0.3.1"
  license :cannot_represent # Huitzo Source-Available License — see LICENSE

  on_macos do
    on_arm do
      url "https://github.com/Huitzo-Inc/huitzo-launcher/releases/download/v#{version}/huitzo-aarch64-apple-darwin"
      sha256 "8902ecb6906bed1432b31866778a9833706f09f00005484ecc04213b33422724"
    end
    on_intel do
      url "https://github.com/Huitzo-Inc/huitzo-launcher/releases/download/v#{version}/huitzo-x86_64-apple-darwin"
      sha256 "8044d0ce69dbec471dee83ca700199384bfc1ac743758e31963bca350ff5bfae"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Huitzo-Inc/huitzo-launcher/releases/download/v#{version}/huitzo-aarch64-unknown-linux-musl"
      sha256 "de50650eb9fbbdd4d284d8e1c0ea3021134a551c7154cd093903cf2783f79105"
    end
    on_intel do
      url "https://github.com/Huitzo-Inc/huitzo-launcher/releases/download/v#{version}/huitzo-x86_64-unknown-linux-musl"
      sha256 "6f378701dff57ba469eda268cc651a61d137453aece557d7c9b2c76f3ee4e091"
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
