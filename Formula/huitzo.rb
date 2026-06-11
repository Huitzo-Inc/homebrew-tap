class Huitzo < Formula
  desc "Huitzo CLI for developing Intelligence Packs"
  homepage "https://huitzo.ai"
  version "0.2.9"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/Huitzo-Inc/huitzo-launcher/releases/download/v#{version}/huitzo-aarch64-apple-darwin"
      sha256 "54bb5ff4022d6b20a067f94adee19a21f9bbbe1bb292ab6e4bcff020b64a8108"
    end
    on_intel do
      url "https://github.com/Huitzo-Inc/huitzo-launcher/releases/download/v#{version}/huitzo-x86_64-apple-darwin"
      sha256 "e70331eac67ed531cc97dd58babe94154881957384a556ca38453e269e9ad839"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Huitzo-Inc/huitzo-launcher/releases/download/v#{version}/huitzo-aarch64-unknown-linux-musl"
      sha256 "9c56850405b405e24084b295eedb41bccc3cb74f2889e3662882b36abba6aaaf"
    end
    on_intel do
      url "https://github.com/Huitzo-Inc/huitzo-launcher/releases/download/v#{version}/huitzo-x86_64-unknown-linux-musl"
      sha256 "c6679389315396adea0785e0eda303f1ff83957d2f082e84deff0457dc174d2b"
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
