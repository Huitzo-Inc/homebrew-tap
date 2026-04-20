class Huitzo < Formula
  desc "Huitzo CLI for developing Intelligence Packs"
  homepage "https://huitzo.ai"
  version "0.2.4"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/Huitzo-Inc/huitzo-launcher/releases/download/v#{version}/huitzo-aarch64-apple-darwin"
      sha256 "1f99d6c07f11c78e7a231ee5be1ec812f002569a803f946a64db0348e9a58d7a"
    end
    on_intel do
      url "https://github.com/Huitzo-Inc/huitzo-launcher/releases/download/v#{version}/huitzo-x86_64-apple-darwin"
      sha256 "04d72f747c87a03bf74cd0dd938511057ad6d8c360d3da3492251cb6cc7d2b2a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Huitzo-Inc/huitzo-launcher/releases/download/v#{version}/huitzo-aarch64-unknown-linux-musl"
      sha256 "c810980d7ba089df08cbfd0f6349cdcd4c8c1760bd6cf0415ee214791f577f9a"
    end
    on_intel do
      url "https://github.com/Huitzo-Inc/huitzo-launcher/releases/download/v#{version}/huitzo-x86_64-unknown-linux-musl"
      sha256 "dc9324658b32f3e4609782d5336c3ee445c8a054943277c10745e270e7cfbfdd"
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
