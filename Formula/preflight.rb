class Preflight < Formula
  desc "Independent multi-model review crew for coding agents — report-only"
  homepage "https://akasecurity.io"
  url "https://github.com/akasecurity/preflight-skills/archive/refs/tags/v0.2.2.tar.gz"
  sha256 "435718a32958724040b418b02112be417e96170fec9045954a5a53d1f7e23f5d"
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
    assert_match "usage: crew.mjs", shell_output("#{bin}/preflight")
  end
end
