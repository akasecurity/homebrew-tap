# AGENTS.md — homebrew-tap

Per-repo conventions for any coding/ops agent. Builds on `~/aka/AGENTS.md` (company layer) and the
global layer — never repeats them.

## What this repo is

The public Homebrew tap for AKA Security. It is the **standalone-CLI** install path, for people who
want a tool without running it inside a coding agent. The in-agent path is
`akasecurity/marketplace`; this is the alternative, not a mirror of it.

```bash
brew tap akasecurity/tap
brew install akasecurity/tap/aka-claude-tools
brew install akasecurity/tap/preflight
```

Public. Every commit is visible immediately, and a broken formula breaks installs for everyone.

## Formulae

- `Formula/aka-claude-tools.rb` — from `akasecurity/claude-tools`. Needs `jq` + `bun`.
- `Formula/preflight.rb` — from `akasecurity/preflight-skills`. Needs `node`.

Formula names are not always repo names, and that is deliberate: the repo is `claude-tools` while
the npm package, CLI binary, and this formula are all `aka-claude-tools`. Match the existing
spelling rather than inventing a fourth one.

Formulae install from each project's **tagged source tarball** — no npm required.

## Bumping a formula

1. Confirm the upstream tag exists: `gh release list -R akasecurity/<repo>`.
2. Update `url` to the new tag.
3. Recompute `sha256` against the tarball you are actually pinning — never carry the old one
   forward:
   ```bash
   curl -fsSL <url> | shasum -a 256
   ```
4. Verify locally before pushing: `brew install --build-from-source ./Formula/<name>.rb` then
   `brew test <name>`.

A wrong `sha256` fails every install with a checksum mismatch, so step 3 is the one that matters.

## Renames propagate here

A rename upstream lands in three places in this repo: the formula **filename**, the Ruby **class
name**, and the `url`. It also lands in `README.md` and in the repo's GitHub **description** — both
have gone stale before. After any upstream rename, grep:

```bash
rg -n '<old-name>' --hidden -g '!.git'
```

and check the description with `gh api repos/akasecurity/homebrew-tap --jq .description`.

## Workflow

No CI. Small commits straight to `main`, after a local `brew install`/`brew test` on the changed
formula.
