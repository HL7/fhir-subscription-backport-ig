# AGENTS.md

Canonical, machine-readable conventions for automated agents working in
**HL7/fhir-subscription-backport-ig** (the *Subscriptions R5 Backport*
Implementation Guide). This file is the single source of truth that the
`.github/skills/dev-*` skills read before naming any build, test, or lint
command.

**Precedence.** This file is authoritative for commands, conventions, and
invariants an agent must follow. [`README.md`](README.md) and
[`INSTALLATION.md`](INSTALLATION.md) are authoritative for rationale and
toolchain setup detail, and are the place to look for the "why". If this
file contradicts the repository itself, the repository wins — fix this file.

---

## What this repository is

This is a **HL7 FHIR Implementation Guide**, not an application. It is
authored in FHIR Shorthand (FSH) plus markdown pages, compiled by **SUSHI**
into FHIR resources, and rendered into a publishable website by the **HL7 IG
Publisher**. It is published at
`http://hl7.org/fhir/uv/subscriptions-backport`.

The framing fact that settles most arguments: **the deliverable is a
specification, and the specification is normative text plus conformance
resources.** The IG defines how a server running FHIR **R4 (4.0.1)** or
**R4B (4.3.0)** can implement a subset of **R5 (5.0.0)** topic-based
Subscriptions. So "what does R5 do?" is usually the deciding argument, and
anything the backport adds must be expressible as an extension or profile
over the older version rather than a new invention.

Because it is a spec, there is **no test suite** in the software sense. The
build *is* the verification — see [Test](#test).

---

## Repository layout

| Path | Contents |
|-|-|
| `input/fsh/` | FSH source: profiles, extensions, operations, capability statements, examples. The primary authoring surface. |
| `input/pagecontent/` | Markdown narrative pages (one per entry in `sushi-config.yaml` `pages:`). The other primary authoring surface. |
| `input/pagecontent/ig_changelog.md` | The IG change log. See [Commit conventions](#commit-conventions). |
| `input/resources/` | Hand-authored ("pre-defined") JSON resources that SUSHI copies through verbatim. |
| `input/images-source/` | PlantUML / SVG diagram sources. |
| `input/includes/` | XHTML fragments injected into generated pages. |
| `input/ignoreWarnings.txt` | Publisher QA messages that are reviewed and deliberately suppressed, each with a comment explaining why. |
| `sushi-config.yaml` | IG metadata, dependencies, `pages`, `menu`, and the `r4-inclusion` / `r4b-inclusion` artifact lists. The most important config file in the repo. |
| `ig.ini` | Points the IG Publisher at the SUSHI-generated ImplementationGuide resource and names the HL7 template. |
| `_genonce.bat` / `_genonce.sh`, `_build.bat`, `_gencontinuous.*`, `_updatePublisher.*` | Standard HL7 `ig-publisher-scripts`. **Maintained upstream** at `HL7/ig-publisher-scripts`; `_updatePublisher` overwrites them. Do not hand-edit. |
| `input-cache/` | Downloaded `publisher.jar` and package cache. **Ignored.** |
| `fsh-generated/` | SUSHI output. **Ignored, and never hand-edited.** |
| `output/`, `temp/`, `template/`, `translations/` | IG Publisher output and scratch. **Ignored, and never hand-edited.** |
| `scratch/` | `dev-*` skill slots. **Ignored.** |

Ignored paths are listed in `.gitignore`. Anything under `fsh-generated/`,
`output/`, `temp/`, `template/`, or `input-cache/` is a build artifact:
editing it is always wrong, and the edit is destroyed on the next build.

`SUSHI-GENERATED-FILES.md` records which top-level config files SUSHI
generates or copies; treat everything it lists as generated.

---

## Toolchain pins

- **SUSHI** — installed globally via `npm install -g fsh-sushi`. No pin is
  checked in; the repository tracks the current SUSHI release. Verified
  working with **SUSHI v3.20.1** (FSH spec v3.0.0). Requires Node.js.
- **Java** — required to run the IG Publisher. `INSTALLATION.md` states JRE 8
  is a floor and JDK 11+ is recommended (heap headroom). Verified working
  with **OpenJDK 25**. The build scripts set
  `JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF-8`; keep that, the publisher needs
  UTF-8.
- **IG Publisher** — `publisher.jar`, not checked in. Fetched by
  `_updatePublisher.bat` (latest release of `HL7/fhir-ig-publisher`) into
  `input-cache/`; the scripts also accept it in the **parent** directory
  (`..\publisher.jar`), which is where this clone currently resolves it.
  There is no version pin — the scripts always take *latest*.
- **IG template** — `hl7.fhir.template#current` in `ig.ini`. A floating pin;
  template changes can alter rendering without any repo change.
- **FHIR versions** — `fhirVersion: 5.0.0` in `sushi-config.yaml`, with
  `parameters.generate-version: [4.0.1, 4.3.0]`. The IG is authored against
  R5 and *generated* for R4 and R4B.
- **Package dependencies** — pinned exactly in `sushi-config.yaml`
  `dependencies:` (`hl7.fhir.uv.extensions`, `hl7.fhir.uv.tools`, and the
  three `hl7.fhir.uv.xver-*` cross-version packages, each carrying an
  `ig-dependency-for-version` extension). Changing any of these versions is
  a substantive change: it can move generated URLs and QA output.
- **Ruby + Jekyll** — only needed for the publisher's local page rendering;
  see `INSTALLATION.md`. Not needed to run SUSHI alone.

Warnings are **not** errors here, but they are not free either: the QA
report is a review artifact, and any warning that is knowingly accepted is
expected to be entered in `input/ignoreWarnings.txt` **with a comment
explaining why**.

---

## Build

There are two build tracks. They catch different things, and the fast one
does not subsume the slow one.

### Track 1 — SUSHI only (fast inner loop)

```powershell
sushi .
```

Compiles `input/fsh/**.fsh` plus `input/resources/` into
`fsh-generated/resources/` and regenerates the ImplementationGuide resource.
Seconds, not minutes. This is the right command after any `.fsh` edit.

The expected baseline is **0 errors**. SUSHI's exit code is the error count,
so a clean run exits `0`. Warnings are tolerated but should be understood.

Because SUSHI is fast and the publisher is slow, run this first and only
escalate to Track 2 once it is clean.

### Track 2 — full IG Publisher build

The publisher runs SUSHI itself and then validates, renders, and produces
the QA report. Minutes, and it needs network access for terminology and
package resolution.

The checked-in entry point is the VS Code default build task, which runs:

```powershell
.\_genonce.bat
```

**`_genonce.bat` and `_build.bat` end in `PAUSE` and `_build.bat` opens an
interactive menu.** Both will hang a non-interactive agent shell. For
automation, invoke the publisher directly the same way the script does:

```powershell
$env:JAVA_TOOL_OPTIONS = '-Dfile.encoding=UTF-8'
java -jar input-cache\publisher.jar -ig .
```

If `publisher.jar` is not in `input-cache/`, the scripts fall back to
`..\publisher.jar`; use whichever exists, and run `.\_updatePublisher.bat`
(interactive) to fetch it if neither does.

Offline, or when `tx.fhir.org` is unreachable, append `-tx n/a` — that is
exactly what the scripts do when their connectivity probe fails. Expect
terminology-dependent QA messages to change when you do.

`-no-sushi` skips the SUSHI stage (`_build.bat` option 3) when you have
already run Track 1 and only want the render.

The expected baseline is **the publisher completing and writing
`output/qa.html`**, with no new errors relative to `HEAD`. Do not treat the
absolute warning count as the bar — compare against a clean checkout before
calling anything a regression, because template and terminology drift can
move it without any change in this repo.

---

## Test

**There is no unit-test suite, and no test runner. Do not look for one, and
do not add one.** Verification for this repository is:

1. `sushi .` exits `0`.
2. The IG Publisher completes.
3. `output/qa.html` shows no **new** errors or warnings versus `HEAD`.
4. The rendered pages under `output/` say what the change intended, read in
   a browser.

### Full

Track 2 above, then open `output/qa.html`.

### Scoped

Track 1 above (`sushi .`). This is the smallest meaningful verification and
covers every FSH-only change up to the point of validation.

### Focused

There is no per-artifact or per-page build; SUSHI and the publisher both
operate on the whole IG. The focused equivalent is to inspect the single
generated artifact after Track 1, e.g.
`fsh-generated/resources/StructureDefinition-backport-payload-content.json`.

**Prefer the smallest command that covers the change.** A narrative-only
edit to `input/pagecontent/*.md` does not need Track 1 at all — it needs
Track 2 to be seen rendered.

### Known failure mode

`error Ignoring FSH definition for <url> since it duplicates existing
pre-defined resource` means the same artifact is defined **both** in
`input/fsh/` and as JSON in `input/resources/`. Exactly one of the two must
define it. This is the most common self-inflicted SUSHI error in this repo.

---

## Lint / format

There is no linter and no formatter. No `.editorconfig`, no `.prettierrc`,
no format check in the build. **Do not add one, and do not raise review
findings that amount to formatting preferences.**

---

## Run

There is nothing to run — the artifact is a website. After a Track 2 build,
open:

```powershell
Start-Process output\index.html
```

For an edit/refresh loop the publisher can watch the tree:

```powershell
.\_gencontinuous.bat
```

The continuous-integration render of the `master` branch is published at
`http://build.fhir.org/ig/HL7/fhir-subscription-backport-ig`.

---

## Code style

There is no enforced style configuration; **match the surrounding file**.
That instruction is the rule here, not a fallback.

- **FSH** (`input/fsh/*.fsh`) — follow the conventions already in
  `Extensions.fsh`, `Common.fsh`, and `Operations.fsh`: two-space indent for
  rule continuation, `//` comments, `^` caret rules for metadata, and
  `Title`/`Description` on every definition. Keep artifact ids
  `lower-kebab-case` and prefixed `backport-` where the existing artifacts
  are.
- **Markdown pages** (`input/pagecontent/*.md`) — these render into the
  spec. Conformance verbs (`SHALL`, `SHOULD`, `MAY`, `SHALL NOT`) are
  **normative and uppercase**; never soften, strengthen, or case-fold one
  without it being the point of the change. Cross-page links are to the
  generated `*.html` name, not the `.md` source.
- **YAML** (`sushi-config.yaml`) — two-space indent. The decorative
  box-drawing comment banners are SUSHI scaffolding; leave them alone.
- **JSON** (`input/resources/*.json`) — two-space indent.
- Files are UTF-8. The build forces UTF-8 for Java; do not introduce other
  encodings.

### Architectural invariants

These are decisions, not preferences. Violating one is a review Blocker.

- **R4 and R4B artifacts come in pairs.** Anything added for one version
  needs its counterpart, and both must be listed in the matching
  `r4-inclusion` / `r4b-inclusion` block in `sushi-config.yaml`. An artifact
  missing from those lists is silently absent from the generated version.
- **Cross-version content uses the `hl7.fhir.uv.xver-*` packages.** The IG
  deliberately migrated to cross-version extensions; do not reintroduce
  hand-rolled equivalents of an extension the xver packages already define.
- **Canonical URLs and artifact ids are public API.** Renaming an id or
  moving a canonical breaks every implementer and every inbound link. Treat
  it as a non-compatible change, and record it as such in the change log.
- **Terminology is anchored in THO** (`terminology.hl7.org`), not defined
  locally. This was the resolution of FHIR-44403 / FHIR-44404; do not add
  local CodeSystems or ValueSets that duplicate THO content.
- **Generated trees are never hand-edited** — `fsh-generated/`, `output/`,
  `temp/`, `template/`, `input-cache/`. Fix the FSH or the config instead.
- **The HL7 build scripts are upstream files.** `_build.bat`, `_genonce.*`,
  `_gencontinuous.*`, `_updatePublisher.*` come from
  `HL7/ig-publisher-scripts` and are overwritten by `_updatePublisher`.
  Changes belong upstream, not here.

---

## Commit conventions

- **This repository does not use conventional commits.** Do not introduce
  them. The established subject format is the HL7 Jira ticket followed by a
  description of what changed:

  ```
  FHIR-43920 - Updated the Handling Errors page to reference 'Client' instead of 'Subscriber'
  ```

  Tickets live in HL7 Jira (`https://jira.hl7.org/browse/FHIR-#####`), **not**
  in GitHub Issues. Work with no ticket uses a plain imperative subject
  (`Add oid`, `Build fixes...`, `Script updates`).
- Subject in the past or imperative tense, matching neighbours; there is no
  enforced length limit, and existing subjects routinely exceed 72
  characters when the ticket needs it. Clarity wins over brevity.
- **No trailers are required.** `Co-Authored-By` appears occasionally and is
  optional.
- One logical change per commit. A ticket that touches narrative, an
  artifact, and the change log is still one commit.
- **Substantive changes update `input/pagecontent/ig_changelog.md`** in the
  same commit, under the current version heading, in the existing shape:
  a `Non-compatible` / `Compatible, Substantive` / (etc.) grouping, then a
  linked ticket, then nested bullets naming each page and artifact touched.
  Existing entries are the template — copy their form.
- When the GitHub integration below is on **and** the slot carries an
  `Issue` binding, `dev-do` adds an `Issue: #N` trailer to each phase
  commit. The integration is off, so nothing is added.
- Agents **do not push** and **do not open pull requests** unless the user
  explicitly asks.

---

## GitHub Integration

**Off by default, in two independent ways.** A repository whose
`AGENTS.md` has **no** `## GitHub Integration` section is off. A section
whose `Enabled` row says **`no`** is equally off. In either case no skill
prompts about GitHub, and the `dev-*` loop behaves exactly as it did
before this feature existed.

This repository tracks work in **HL7 Jira**, not GitHub Issues, so the
integration is deliberately disabled. `no` / `n/a` below are **resolved
answers**, not gaps — do not re-prompt on them.

The block below is **machine-managed**. This section is the **normative
definition** of both sentinel strings: every skill that reads or writes
the block reproduces the opener and the closer byte-for-byte from here,
and no skill re-derives, paraphrases, or reformats them.

<!-- >>> dev-* github integration (managed by dev-* skills) >>> -->
| Setting | Value |
|-|-|
| Enabled | no |
| Repository | n/a |
| Label — feature request | n/a |
| Label — bug report | n/a |
| Label — docs-only (additive) | n/a |
| Changelog file | n/a |
| Changelog entry format | n/a |
| PR opens as draft | n/a |
<!-- <<< dev-* github integration (managed by dev-* skills) <<< -->

**These sentinels are not `dev-setup`'s ignore-file sentinels.** The
ignore-file block that `dev-setup` maintains in `.gitignore` or
`.git/info/exclude` is delimited by
`# >>> dev-* skills (managed by dev-setup) >>>` and
`# <<< dev-* skills (managed by dev-setup) <<<`. That is a **different
block in a different file**, with a `#` comment prefix rather than an
HTML comment. Do not conflate the two, and never substitute one pair for
the other.

Rules for the block:

- Only `dev-setup`, `dev-issue`, and `dev-pr-open` may rewrite it, and
  only **in place** — never a second copy, never appended to the end of
  the file.
- Hand-written text outside the sentinels is never touched. Everything a
  human writes in this section survives every rewrite.
- A recorded value of `no`, `none`, or `n/a` is a **resolved answer**, not
  a missing one. It must never re-trigger a prompt on a later run.
- When `Enabled` is `no`, every other row is `n/a`.

> Note: `input/pagecontent/ig_changelog.md` **is** this IG's change log and
> is maintained by hand per [Commit conventions](#commit-conventions). It is
> recorded as `n/a` above only because the automated changelog machinery
> belongs to the disabled GitHub integration.

---

## Scratch / slot convention

Local inner-loop work is organized into **slots** under `scratch/`:

```
scratch/<MMDD>-<##>/
  featurerequest.md    # authored by the dev-request skill
  bugreport.md         # authored by the dev-report skill
  approach-a.md        # authored by dev-approach (minimum change)
  approach-b.md        # authored by dev-approach (cleanest architecture)
  approach-c.md        # authored by dev-approach (unconstrained)
  approach.md          # authored by dev-approach (the judge's selection)
  plan.md              # authored by dev-plan, updated by dev-do
  analysis.md          # authored by dev-review
```

- `<MMDD>` is the local date (zero-padded month + day); `<##>` is a
  zero-padded two-digit slot number.
- `scratch/` is **ignored** (`/scratch` and `scratch/` in `.gitignore`).
  Nothing in it is ever committed.
- Because the slot is ignored, **no plan phase may declare a `scratch/` path
  as an owned path.** `plan.md` is a control file that `dev-do` edits
  continuously and never stages or commits.

---

## Agent guardrails

- Read this file before proposing any build, test, or lint command. **Never
  invent a command.** If something you need is not documented here, say so
  rather than guessing.
- **Never run `_genonce.bat`, `_build.bat`, or `_updatePublisher.bat` from a
  non-interactive shell.** They `PAUSE` and prompt, and they will hang.
  Use the direct `java -jar ... -ig .` invocation in [Build](#build).
- **Never hand-edit generated output** — `fsh-generated/`, `output/`,
  `temp/`, `template/`, `input-cache/`. Change the FSH, the markdown, or
  `sushi-config.yaml`.
- **Never edit the HL7 build scripts** (`_*.bat`, `_*.sh`); they are
  overwritten from `HL7/ig-publisher-scripts`.
- **Do not change `sushi-config.yaml` dependency versions, `fhirVersion`,
  `version`, `releaseLabel`, or `id`** without being asked. These drive
  publication and are release-manager decisions.
- Adding an artifact means updating **both** `r4-inclusion` and
  `r4b-inclusion` in `sushi-config.yaml`, and a new page means updating both
  `pages:` and `menu:`.
- Suppressing a QA message means adding it to `input/ignoreWarnings.txt`
  **with a comment saying why** — never silently.
- Substantive changes update `input/pagecontent/ig_changelog.md`.
- Conformance language (`SHALL`/`SHOULD`/`MAY`) is normative. Changing one
  is a substantive spec change, never a copy-edit.
- Subagents must use the same model configuration as the spawning agent.
- Do not add new linting, building, or testing tooling without being asked.
- Prefer the smallest targeted verification that covers the change; escalate
  to the full suite only when the targeted run indicates it is needed.
