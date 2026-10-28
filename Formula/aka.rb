class Aka < Formula
  desc "Local-first security control plane for AI coding agents"
  homepage "https://github.com/akasecurity/ai-tc"
  version "0.9.21"
  license "Apache-2.0"

  livecheck do
    url "https://github.com/akasecurity/ai-tc/releases/download/bin-latest/VERSION"
    regex(/^(\d+(?:\.\d+)+)$/i)
    strategy :page_match
  end

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/akasecurity/ai-tc/releases/download/bin-v0.9.21/aka-0.9.21-darwin-arm64.tar.gz"
    sha256 "b6faa6075efb238043741731543afa5544a18e54e6f63e9befc9df1af52d7231"
  end

  on_linux do
    on_arm do
      depends_on arch: :arm64
      url "https://github.com/akasecurity/ai-tc/releases/download/bin-v0.9.21/aka-0.9.21-linux-arm64.tar.gz"
      sha256 "7e05f62ed355f85ad7f2c3e8c371dfdce068c5f725cc3baa07ee5ce747dc7a1a"
    end
    on_intel do
      url "https://github.com/akasecurity/ai-tc/releases/download/bin-v0.9.21/aka-0.9.21-linux-x64.tar.gz"
      sha256 "b1f590d3a1dc4b9ca12cc86d0694efaa2bfab895a21f7c1c5092a8518c001f2b"
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
