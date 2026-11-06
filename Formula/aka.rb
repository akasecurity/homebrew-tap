class Aka < Formula
  desc "Local-first security control plane for AI coding agents"
  homepage "https://github.com/akasecurity/ai-tc"
  version "0.9.24"
  license "Apache-2.0"

  livecheck do
    url "https://raw.githubusercontent.com/akasecurity/ai-tc/bin-latest/cli/package.json"
    regex(/"version":\s*"(\d+(?:\.\d+)+)"/i)
    strategy :page_match
  end

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/akasecurity/ai-tc/releases/download/bin-v0.9.24/aka-0.9.24-darwin-arm64.tar.gz"
    sha256 "50aef191ed4741d1d7d40f9722c84ba24c7dacff1b7278e651a9db21bc8994d1"
  end

  on_linux do
    on_arm do
      depends_on arch: :arm64
      url "https://github.com/akasecurity/ai-tc/releases/download/bin-v0.9.24/aka-0.9.24-linux-arm64.tar.gz"
      sha256 "5db1c437547c1582e7412ef431e2b9a628828e7f2e4bd9e389b8bf969cd20ab3"
    end
    on_intel do
      url "https://github.com/akasecurity/ai-tc/releases/download/bin-v0.9.24/aka-0.9.24-linux-x64.tar.gz"
      sha256 "c5dfc35c12857b6ba327ed7244a2a907d01563bed15b5c0bbcdb032b48645c58"
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
