class Aka < Formula
  desc "Local-first security control plane for AI coding agents"
  homepage "https://github.com/akasecurity/ai-tc"
  version "0.9.18"
  license "Apache-2.0"

  livecheck do
    url "https://github.com/akasecurity/ai-tc/releases/download/bin-latest/VERSION"
    regex(/^(\d+(?:\.\d+)+)$/i)
    strategy :page_match
  end

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/akasecurity/ai-tc/releases/download/bin-v0.9.18/aka-0.9.18-darwin-arm64.tar.gz"
    sha256 "539d86959de9c8c3ae22a764c41ed585c982702389f416df6beee71e5a70e6a8"
  end

  on_linux do
    on_arm do
      depends_on arch: :arm64
      url "https://github.com/akasecurity/ai-tc/releases/download/bin-v0.9.18/aka-0.9.18-linux-arm64.tar.gz"
      sha256 "dc3b27117239ebe3ef014523d196ae508945f60249d6ad8a1df746cea8b6bb33"
    end
    on_intel do
      url "https://github.com/akasecurity/ai-tc/releases/download/bin-v0.9.18/aka-0.9.18-linux-x64.tar.gz"
      sha256 "ee592337104ef9d3e03faeb1700856ee887bb7c60dfc2e915c28c7d28ea4475e"
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
