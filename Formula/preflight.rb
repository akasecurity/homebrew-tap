class Preflight < Formula
  desc "Independent multi-model review crew for coding agents — report-only"
  homepage "https://akasecurity.io"
  url "https://github.com/akasecurity/preflight-skills/archive/refs/tags/v0.4.1.tar.gz"
  sha256 "b67bb7e4c6d46e6d219af7885ad5bc3a748d4ea938604ddd25ebbe335978ffe8"
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
