class Huitzo < Formula
  desc "Huitzo CLI for developing Intelligence Packs"
  homepage "https://huitzo.ai"
  version "0.3.0"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/Huitzo-Inc/huitzo-launcher/releases/download/v#{version}/huitzo-aarch64-apple-darwin"
      sha256 "1130f99e74ed688a42d4615dbcc1e1e66b25d5590f24a8c96e921c6d8808da2b"
    end
    on_intel do
      url "https://github.com/Huitzo-Inc/huitzo-launcher/releases/download/v#{version}/huitzo-x86_64-apple-darwin"
      sha256 "157476a23e63f54906c44b3d1166395074d5f0f3355a33071d722eb141878225"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Huitzo-Inc/huitzo-launcher/releases/download/v#{version}/huitzo-aarch64-unknown-linux-musl"
      sha256 "85b7d2add4cf343cb1b913717e60c33c08e490de09a6145f465053bdc7de2ddb"
    end
    on_intel do
      url "https://github.com/Huitzo-Inc/huitzo-launcher/releases/download/v#{version}/huitzo-x86_64-unknown-linux-musl"
      sha256 "0c514669dee276b8fc65f8a5a3b52704cd9bd716192241dabe5b00f0b8257274"
    end
  end

  def install
    binary = Dir["huitzo-*"].first || "huitzo"
    bin.install binary => "huitzo"
  end

  test do
    assert_match "huitzo-launcher", shell_output("#{bin}/huitzo --launcher-version")
  end
end
