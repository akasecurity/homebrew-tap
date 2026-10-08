# AKA Security Homebrew tap

Homebrew formulae for [AKA Security](https://akasecurity.io) tools.

```bash
brew tap akasecurity/tap
brew install akasecurity/tap/aka
brew install akasecurity/tap/aka-claude-tools
brew install akasecurity/tap/preflight
```

## Formulae

- **[aka](https://github.com/akasecurity/ai-tc)** — the `aka` CLI for AI Traffic Control, a
  local-first security control plane for AI coding agents. A self-contained binary with its own
  runtime, so no Node.js is needed. Apple-silicon macOS and Linux (x64, arm64); on an Intel Mac,
  use `npm install -g @akasecurity/cli` (Node.js 24+) instead. Run `aka init` after installing, and
  `brew upgrade aka` to update.
- **[aka-claude-tools](https://github.com/akasecurity/claude-tools)** — the security defaults Claude
  Code doesn't ship with: clean context, locked-down credentials, guarded egress, on an isolated
  profile. Needs `jq` + `bun`.
- **[preflight](https://github.com/akasecurity/preflight-skills)** — an independent multi-model
  review crew for coding agents: two blind cross-family reads plus an independent judge. Report-only.
  Needs `node`.

`aka-claude-tools` and `preflight` install from each project's tagged source tarball — no npm
required. `aka` installs the prebuilt archive its release publishes, and its formula is written by
that release: every `bin-v*` release of [ai-tc](https://github.com/akasecurity/ai-tc) renders
`Formula/aka.rb` from its own checksums and commits it here. For in-agent plugin installs, use the
[marketplace](https://github.com/akasecurity/marketplace) instead.

If Homebrew reports it cannot link `bin/aka`, an npm-installed copy is in the way: run
`npm uninstall -g @akasecurity/cli` and install again. `brew uninstall aka` removes the binary
only; [what stays behind](https://github.com/akasecurity/ai-tc/blob/main/tools/installer/README.md#uninstalling)
includes your local store under `~/.aka`.

Each formula installs its upstream project under that project's own license. <https://akasecurity.io>
