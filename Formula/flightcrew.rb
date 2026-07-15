class Flightcrew < Formula
  desc "Independent multi-model review crew for coding agents — report-only"
  homepage "https://akasecurity.io"
  url "https://github.com/akasecurity/flightcrew-skills/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "d2a702c0a01f916257c239d4a7655eddf9df52e68b03a6d5e6b75824d123a0db"
  license "MIT"

  depends_on "node"

  def install
    libexec.install Dir["*"]
    (bin/"flightcrew").write <<~BASH
      #!/usr/bin/env bash
      exec node "#{libexec}/scripts/crew.mjs" "$@"
    BASH
  end

  test do
    assert_match "usage: crew.mjs", shell_output("#{bin}/flightcrew")
  end
end
