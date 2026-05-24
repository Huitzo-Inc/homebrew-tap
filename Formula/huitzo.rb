class Huitzo < Formula
  desc "Huitzo CLI for developing Intelligence Packs"
  homepage "https://huitzo.ai"
  version "0.2.8"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/Huitzo-Inc/huitzo-launcher/releases/download/v#{version}/huitzo-aarch64-apple-darwin"
      sha256 "00fd885e4bf64353bb0086f7de0b64218a3e6553d188b60db0ea9a80e2bdd0b7"
    end
    on_intel do
      url "https://github.com/Huitzo-Inc/huitzo-launcher/releases/download/v#{version}/huitzo-x86_64-apple-darwin"
      sha256 "603627b0e3ee881da4a3121878f72f21ea86fc08374cd2d4f4858b88642dd841"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Huitzo-Inc/huitzo-launcher/releases/download/v#{version}/huitzo-aarch64-unknown-linux-musl"
      sha256 "f809047805cd1e0412f245b81d8796a7e0ef9a63aa42397f2297721de4539940"
    end
    on_intel do
      url "https://github.com/Huitzo-Inc/huitzo-launcher/releases/download/v#{version}/huitzo-x86_64-unknown-linux-musl"
      sha256 "3993fe20e5b4d6bb0de4f43017a84532434e07af88ca70c4c5bafa70f349fce5"
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
