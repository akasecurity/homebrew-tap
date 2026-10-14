class Aka < Formula
  desc "Local-first security control plane for AI coding agents"
  homepage "https://github.com/akasecurity/ai-tc"
  version "0.9.19"
  license "Apache-2.0"

  livecheck do
    url "https://github.com/akasecurity/ai-tc/releases/download/bin-latest/VERSION"
    regex(/^(\d+(?:\.\d+)+)$/i)
    strategy :page_match
  end

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/akasecurity/ai-tc/releases/download/bin-v0.9.19/aka-0.9.19-darwin-arm64.tar.gz"
    sha256 "c34acfe66de7096633a88f1f7b717f876b1291af75ff4afe01f8096c302b57c1"
  end

  on_linux do
    on_arm do
      depends_on arch: :arm64
      url "https://github.com/akasecurity/ai-tc/releases/download/bin-v0.9.19/aka-0.9.19-linux-arm64.tar.gz"
      sha256 "71314136d3a5d0de4be469ca6668c956d650490fc04d777310a2b7248e5d570e"
    end
    on_intel do
      url "https://github.com/akasecurity/ai-tc/releases/download/bin-v0.9.19/aka-0.9.19-linux-x64.tar.gz"
      sha256 "860fe3d172d4886799eb649f2ceb95f6301a07cca1509d4bdf89b377117c486c"
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
