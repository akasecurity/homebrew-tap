class Flightcrew < Formula
  desc "Independent multi-model review crew for coding agents — report-only"
  homepage "https://akasecurity.io"
  url "https://github.com/akasecurity/flightcrew-skills/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "3e7d92ac9dc09d91d77076f8f25ea7660c26cf1f78a36fec6b214a5f5221378b"
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
