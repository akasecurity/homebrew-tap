class Aka < Formula
  desc "Local-first security control plane for AI coding agents"
  homepage "https://github.com/akasecurity/ai-tc"
  version "0.9.20"
  license "Apache-2.0"

  livecheck do
    url "https://github.com/akasecurity/ai-tc/releases/download/bin-latest/VERSION"
    regex(/^(\d+(?:\.\d+)+)$/i)
    strategy :page_match
  end

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/akasecurity/ai-tc/releases/download/bin-v0.9.20/aka-0.9.20-darwin-arm64.tar.gz"
    sha256 "55e7965b62fccc977257cb5c99a4b69ef98264e4689c71a9a40a290eb7e83a9b"
  end

  on_linux do
    on_arm do
      depends_on arch: :arm64
      url "https://github.com/akasecurity/ai-tc/releases/download/bin-v0.9.20/aka-0.9.20-linux-arm64.tar.gz"
      sha256 "70cc79c38459eb69706d74285e745493a2c9e9b788201264fc0e82f7582fed26"
    end
    on_intel do
      url "https://github.com/akasecurity/ai-tc/releases/download/bin-v0.9.20/aka-0.9.20-linux-x64.tar.gz"
      sha256 "c3236813763fdbe49b72802af056dd027b96e0e9dbb9fb335d9b4363b705e385"
    end
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"aka"
  end

  def caveats
    <<~EOS
      Run `aka init` to create the local store under ~/.aka.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aka --version")
  end
end
