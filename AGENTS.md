# AGENTS.md — homebrew-tap

Per-repo conventions for any coding/ops agent. Builds on `~/aka/AGENTS.md` (company layer) and the
global layer — never repeats them.

## What this repo is

The public Homebrew tap for AKA Security. It is the **standalone-CLI** install path, for people who
want a tool without running it inside a coding agent. The in-agent path is
`akasecurity/marketplace`; this is the alternative, not a mirror of it.

```bash
brew tap akasecurity/tap
brew install akasecurity/tap/aka
brew install akasecurity/tap/aka-claude-tools
brew install akasecurity/tap/preflight
```

Public. Every commit is visible immediately, and a broken formula breaks installs for everyone.

## Formulae

- `Formula/aka.rb` — from `akasecurity/ai-tc`. A prebuilt binary with no runtime dependency.
  **Generated** by that repository's release workflow; see "`Formula/aka.rb` is generated" below.
- `Formula/aka-claude-tools.rb` — from `akasecurity/claude-tools`. Needs `jq` + `bun`.
- `Formula/preflight.rb` — from `akasecurity/preflight-skills`. Needs `node`.

Formula names are not always repo names, and that is deliberate: the repo is `claude-tools` while
the npm package, CLI binary, and this formula are all `aka-claude-tools`. Match the existing
spelling rather than inventing a fourth one.

Every formula except `aka` installs from the project's **tagged source tarball** — no npm required.

## `Formula/aka.rb` is generated

Every `bin-v*` release of `akasecurity/ai-tc` renders this file from that release's own
`SHA256SUMS` and commits it here as `aka <version>`, through the contents API with a token scoped to
this repository alone (the `HOMEBREW_TAP_TOKEN` secret on `akasecurity/ai-tc`). It installs the
release's prebuilt archive rather than a source tarball: the archive goes into `libexec` whole,
because the binary finds its sidecar files beside its own real path, and `bin/aka` links to it.

- **Change it upstream.** The renderer is `renderFormula` in `tools/package-manifests/src/lib.ts`
  in `akasecurity/ai-tc`. The next release overwrites this file, so an edit made here lasts until
  then.
- **A failed push** appears as a red `Publish the Homebrew formula` job on that repository's
  release run. Fix the cause, then re-run the job: it adds nothing when this repo already carries
  that version, and it never replaces a newer version with an older one.
- **A bad formula that already landed:** revert its commit here so installs work now, then fix the
  renderer before the next release writes it again.
- **Token problems** (missing, expired, scoped to the wrong repository): `CONTRIBUTING.md` in
  `akasecurity/ai-tc`, section "Homebrew, Scoop and the one-click links".
- **Verify by installing from the tap**, on Apple-silicon macOS and on Linux:
  `brew install akasecurity/tap/aka`, then `brew test aka`. Run it for the first formula that
  lands and after any renderer change. Intel macOS is refused by design (there is no darwin-x64
  build), so that refusal is not a defect.

## Bumping a formula

Source-tarball formulae only; `aka` is generated (above).

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
have gone stale before, and adding or removing a formula touches both too. After any upstream
rename, grep:

```bash
rg -n '<old-name>' --hidden -g '!.git'
```

and check the description with `gh api repos/akasecurity/homebrew-tap --jq .description`.

The `akasecurity/ai-tc` release workflow names this repository and `Formula/aka.rb` as literals, so
renaming either one also means changing `.github/workflows/release-binaries.yml` there.

## Workflow

No CI. Small commits straight to `main`, after a local `brew install`/`brew test` on the changed
formula. `Formula/aka.rb` is the exception: it arrives as the release workflow's own commit.
