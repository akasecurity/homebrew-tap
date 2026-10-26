class AkaClaudeTools < Formula
  desc "Security defaults for Claude Code: locked credentials, guarded egress"
  homepage "https://akasecurity.io"
  url "https://github.com/akasecurity/aka-claude-tools/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "04df2401742d2c1d058c914e94ceded574c9466fe417bc118b94f00848ffcb5d"
  license "MIT"

  depends_on "bun"
  depends_on "jq"

  def install
    libexec.install Dir["*"]
    (bin/"aka-claude-tools").write <<~BASH
      #!/usr/bin/env bash
      exec "#{libexec}/install.sh" "$@"
    BASH
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aka-claude-tools --version")
  end
end
