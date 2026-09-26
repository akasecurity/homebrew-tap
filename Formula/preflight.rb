class Preflight < Formula
  desc "Independent multi-model review crew for coding agents — report-only"
  homepage "https://akasecurity.io"
  url "https://github.com/akasecurity/preflight-skills/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "818ab2fc3b11aabf99c3258a3470754ceebd2583e3342e8427fa300c946cc040"
  license "MIT"

  depends_on "node"

  def install
    libexec.install Dir["*"]
    (bin/"preflight").write <<~BASH
      #!/usr/bin/env bash
      exec node "#{libexec}/scripts/crew.mjs" "$@"
    BASH
  end

  test do
    # With no arguments each script prints its usage on stderr and exits 2.
    assert_match "usage: crew.mjs", shell_output("#{bin}/preflight 2>&1", 2)
    assert_match "usage: research.mjs", shell_output("node #{libexec}/scripts/research.mjs 2>&1", 2)
  end
end
