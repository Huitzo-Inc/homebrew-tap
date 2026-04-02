class Huitzo < Formula
  desc "Huitzo CLI for developing Intelligence Packs"
  homepage "https://huitzo.ai"
  version "0.1.0"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/Huitzo-Inc/huitzo-launcher/releases/download/v#{version}/huitzo-aarch64-apple-darwin"
      sha256 "a94b97ea7c326e2c773cd8e8076c48c0e1c886ea3622d1841cb5a710087693c4"
    end
    on_intel do
      url "https://github.com/Huitzo-Inc/huitzo-launcher/releases/download/v#{version}/huitzo-x86_64-apple-darwin"
      sha256 "0601244606fbb61abb5d43c6d1e153a97e5b1db5daa63c1f32919e5135529664"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Huitzo-Inc/huitzo-launcher/releases/download/v#{version}/huitzo-aarch64-unknown-linux-musl"
      sha256 "0d6d32329ec06ac2223a7ab4e2136cc7a38c75d8e3b199af586157211666bbe2"
    end
    on_intel do
      url "https://github.com/Huitzo-Inc/huitzo-launcher/releases/download/v#{version}/huitzo-x86_64-unknown-linux-musl"
      sha256 "9896dbfea9af388594476014af608ad6b95b9f2014bf5964b6caa63fc6573127"
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
