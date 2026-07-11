# AKA Security Homebrew tap

Homebrew formulae for [AKA Security](https://akasecurity.io) tools.

```bash
brew tap akasecurity/tap
brew install akasecurity/tap/aka-claude-tools
brew install akasecurity/tap/flightcrew
```

## Formulae

- **[aka-claude-tools](https://github.com/akasecurity/claude-tools)** — the security defaults Claude
  Code doesn't ship with: clean context, locked-down credentials, guarded egress, on an isolated
  profile. Needs `jq` + `bun`.
- **[flightcrew](https://github.com/akasecurity/flightcrew-skills)** — an independent multi-model
  review crew for coding agents: two blind cross-family reads plus an independent judge. Report-only.
  Needs `node`.

Formulae install from each project's tagged source tarball — no npm required. For in-agent plugin
installs, use the [marketplace](https://github.com/akasecurity/marketplace) instead.

Each formula installs its upstream project under that project's own license. <https://akasecurity.io>
