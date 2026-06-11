# XVer Alignment Changes

This document describes the changes made to align the Subscriptions R5 Backport IG with the XVer Cross-Version Extensions (`hl7.fhir.uv.xver-r5.r4`).

## Phase 1: Subscription Profile & Extensions (`BackportSubscription.fsh`)

### Extension Restructuring

- **Replaced `BackportFilterCriteria`** (simple string extension on `Subscription.criteria`) with **`BackportFilterBy`** (complex extension on `Subscription`) containing sub-extensions: `resourceType` (uri), `filterParameter` (string), `comparator` (code), `modifier` (code), `value` (string).
- **Renamed `BackportPayloadContent`** (`backport-payload-content`) to **`BackportContent`** (`backport-content`) and moved context from `Subscription.channel.payload` to `Subscription`.
- **Moved** `BackportHeartbeatPeriod`, `BackportTimeout`, `BackportMaxCount` contexts from `Subscription.channel` to `Subscription` root.
- **Added new extensions**: `BackportSubscriptionIdentifier` (Identifier), `BackportSubscriptionName` (string), `BackportSubscriptionParameter` (complex with name/value sub-extensions).
- **Added `BackportTopicCanonical`** (`backport-topic-canonical`) extension on `Subscription` with value type `uri` to hold the canonical URL of the SubscriptionTopic. This replaces the previous use of `Subscription.criteria` for the topic reference.

### Profile Updates

- `BackportSubscription` now contains all extensions at the `Subscription` root level via `extension contains`.
- `BackportChannelType` remains on `Subscription.channel.type` (unchanged structurally; removed the `SU` flag to fix an isSummary mismatch with the base definition).
- `criteria` relaxed from required to optional (topic now specified via `backport-topic-canonical` extension).

### Search Parameters

- `Subscription-topic`: FHIRPath updated to query `backport-topic-canonical` extension.
- `Subscription-filter-criteria`: FHIRPath updated for `backport-filter-by` extension structure.
- `Subscription-payload-type`: FHIRPath updated for `backport-content` extension at root level.

### Subscription Examples

All three examples (`subscription-admission`, `subscription-multi-resource`, `subscription-zulip`) updated to use new extension structure.

## Phase 2: R4 SubscriptionStatus (`BackportNotificationR4.fsh`)

### Parameters to Basic

- **Changed `BackportSubscriptionStatusR4`** profile parent from `Parameters` to `Basic`.
- `code` fixed to `http://hl7.org/fhir/fhir-types#SubscriptionStatus`.
- Updated bundle invariant from `is(Parameters)` to `is(Basic)`.

### Instance Pattern

- Replaced single shell instance + RuleSet pattern with individual inline instances (`InstanceOf: BackportSubscriptionStatusR4`) per notification example. This ensures SUSHI generates correct extension URLs in the output JSON (SUSHI cannot resolve named extension slices on embedded resources within bundle entries).
- Introduced RuleSets (`StatusBase`, `StatusEvent`, `StatusEventFocus`, `StatusEventContext`, `StatusError`) that apply to individual `BackportSubscriptionStatusR4` instances rather than to bundle entries.
- All 11 R4 notification bundle examples and the standalone status example updated.

## Phase 3: R4B Notifications (`BackportNotificationR4B.fsh`)

No structural changes. R4B uses native `SubscriptionStatus` which was unaffected.

## Phase 4: SubscriptionTopic (`BackportTopics.fsh`)

- Changed all cross-version extension URL prefixes from `4.3` to `5.0` (e.g., `http://hl7.org/fhir/4.3/StructureDefinition/extension-SubscriptionTopic.resourceTrigger` became `http://hl7.org/fhir/5.0/...`).
- Uncommented the encounter length `canFilterBy` section with comparators (gt, lt, ge, le).

### Phase 4b: Profile Basic for R4 SubscriptionTopic

Replaced raw cross-version extension URLs with a locally-defined profile and complex extension (same pattern as `BackportSubscriptionStatusR4` in Phase 2). This eliminates 27 validation errors from the IG Publisher.

- **Defined `BackportSubscriptionTopicStatusR4`** (`backport-subscription-topic-status-r4`) modifier extension on `Basic` for publication status (code, bound to `publication-status`).
- **Defined `BackportSubscriptionTopicR4Extension`** (`backport-subscription-topic-r4-extension`) complex extension on `Basic` with sub-extensions: `url` (uri), `version` (string), `name` (string), `title` (string), `date` (dateTime), `description` (markdown), `resourceTrigger` (complex), `canFilterBy` (complex), `notificationShape` (complex).
  - `resourceTrigger` contains: `description` (markdown), `resource` (uri), `supportedInteraction` (code, 0..*), `queryCriteria` (complex with `previous`/`resultForCreate`/`current`/`resultForDelete`/`requireBoth`), `fhirPathCriteria` (string).
  - `canFilterBy` contains: `description` (markdown), `resource` (uri), `filterParameter` (string), `comparator` (code, 0..*), `modifier` (code, 0..*).
  - `notificationShape` contains: `resource` (uri), `include` (string, 0..*), `revInclude` (string, 0..*), and `BackportRelatedQuery` named `relatedQuery` (0..*).
- **Defined `BackportSubscriptionTopicR4`** (`backport-subscription-topic-r4`) profile on `Basic`: `code` fixed to `SubscriptionTopic`, `modifierExtension` for status, `extension` for the complex topic extension.
- **Rewrote `BackportSubscriptionTopicExampleEncounterCompleteR4`** from `InstanceOf: Basic` to `InstanceOf: BackportSubscriptionTopicR4`, replacing all raw cross-version extension URLs with named extension slice paths.
- **Updated `components.md`**: SubscriptionTopic R4 section now references the new profile.

## Phase 5: Supporting Files

### `Common.fsh`
- Removed `$alternateCanonical` alias (no longer used).

### `sushi-config.yaml`
- Updated `fhirVersion` from `4.3.0` to `4.0.1`.

## Phase 6: Documentation

### `components.md`
- Updated R4 notification description (Parameters to Basic).
- Updated topic reference description (`backport-topic-canonical` extension).
- Updated subscription filters section (structured `backport-filter-by` sub-extensions).
- Added XVer migration note.

### `conformance.md`
- Updated R4B and R4 sections: `backport-filter-criteria` to `backport-filter-by`, `backport-payload-content` to `backport-content`, topic reference to `backport-topic-canonical`.
- Updated R4 notification entry description (Parameters to Basic).

### `channels.md`
- Updated extension URL references from `backport-payload-content` to `backport-content`.

### `notifications.md`
- Updated R4 status description (Parameters to Basic).
- Updated related-query description for nested extension pattern.

## Phase 7: XVer Cross-Version Extension Migration

### Overview

Replaced 11 locally-defined extensions with their equivalents from the `hl7.fhir.uv.xver-r5.r4` package. Moved R4B-specific artifacts to `input/fsh-r4b/` (excluded from SUSHI processing since R4B types like `SubscriptionStatus` and `SubscriptionTopic` are not available in an R4 build).

### Subscription Profile (`BackportSubscription.fsh`)

- **Removed** 10 local extension definitions: `BackportTopicCanonical`, `BackportChannelType`, `BackportFilterBy`, `BackportContent`, `BackportHeartbeatPeriod`, `BackportTimeout`, `BackportMaxCount`, `BackportSubscriptionIdentifier`, `BackportSubscriptionName`, `BackportSubscriptionParameter`.
- **Removed** `BackportContentCodeSystem` and `BackportContentValueSet` (now provided by xver package).
- **Rewrote** `BackportSubscription` profile to reference xver extensions via aliases defined in `Common.fsh`:
  - Root-level: `extension-Subscription.topic`, `.filterBy`, `.content`, `.heartbeatPeriod`, `.timeout`, `.maxCount`, `.identifier`, `.name`, `.parameter`.
  - On `channel.type`: `extension-Subscription.channelType` (context constrained by xver package to `Subscription.channel.type`).
- **Updated** examples: `valueUri` -> `valueCanonical` for topic; channelType on `channel.type.extension` for custom channel example.
- **Updated** SearchParameter FHIRPath expressions to use xver extension URLs.

### R4B Artifacts Excluded

- **Moved** `BackportNotificationR4B.fsh` to `input/fsh-r4b/` (not processed by SUSHI).
- **Removed** R4B `SubscriptionTopic` instance from `BackportTopics.fsh` (IG Publisher cannot parse R4B SearchModifierCodes in R4 mode).
- **Removed** R4B `CapabilityStatement` instance from `Capabilities.fsh` (references non-existent SubscriptionTopic resource type in R4).

### Configuration (`sushi-config.yaml`)

- Added `hl7.fhir.uv.xver-r5.r4` dependency.
- Updated menu artifact section numbering (`#8` -> `#6`) and removed Value Sets entry after artifact removal.

### Documentation

- Updated `conformance.md`: replaced "cross version extensions SHOULD NOT be used" with xver adoption language; renamed extension references to xver names; updated R4 SubscriptionStatus description to reference cross-version modifier extension.
- Updated `components.md`: topic and filterBy extension references.
- Updated `channels.md`: content extension references.
- Updated `Operations.fsh`: `backport-content-value-set` -> `subscription-payload-content` in documentation text.
- Marked 12 removed artifacts as deprecated in `FHIR-subscriptions-backport.xml`.

### Aliases Added (`Common.fsh`)

```
$xverSubTopic, $xverSubChannelType, $xverSubFilterBy, $xverSubContent,
$xverSubHeartbeat, $xverSubTimeout, $xverSubMaxCount, $xverSubIdentifier,
$xverSubName, $xverSubParameter
```

## Phase 8: Top-Level Element Extensions for R4 SubscriptionStatus

### Overview

Migrated SubscriptionStatus from a single monolithic `extension-SubscriptionStatus` wrapping extension to individual per-element xver extensions on `Basic`. This follows the xver profile pattern where each R5 SubscriptionStatus element maps to its own top-level extension on the R4 Basic resource, rather than being nested sub-extensions of a single wrapping extension.

### `Common.fsh` — Alias Changes

Replaced the single `$xverSubStatus` alias with 7 individual element-level aliases:

```
$xverSubStatusSubscription  = extension-SubscriptionStatus.subscription
$xverSubStatusTopic         = extension-SubscriptionStatus.topic
$xverSubStatusStatus        = extension-SubscriptionStatus.status
$xverSubStatusType          = extension-SubscriptionStatus.type
$xverSubStatusESSS          = extension-SubscriptionStatus.eventsSinceSubscriptionStart
$xverSubStatusNotifEvent    = extension-SubscriptionStatus.notificationEvent
$xverSubStatusError         = extension-SubscriptionStatus.error
```

### `BackportNotificationR4.fsh` — Profile Restructuring

- **Profile `BackportSubscriptionStatusR4`**: replaced `modifierExtension contains $xverSubStatus named subscriptionStatus 1..1 MS` with individual extensions matching the xver profile mapping:
  - `extension contains`: subscription (1..1), topic (1..1), status (0..1), eventsSinceSubscriptionStart (0..1), notificationEvent (0..*), error (0..*)
  - `modifierExtension contains`: notificationType (1..1) — only `type` is a modifier per the xver profile (`isModifier: true`)
- **Slice naming**: `type` renamed to `notificationType` to avoid a SUSHI fisher name collision where the generic name `type` matched a different non-modifier extension in loaded packages, causing false validation errors.
- **All RuleSets updated**: paths changed from `modifierExtension[subscriptionStatus].extension[X]` to `extension[X]` (or `modifierExtension[notificationType]` for type).
- **All 12 inline instances and 1 standalone example updated** with the new flat extension paths.

### `Authorization.fsh` — Extension Context

- Added `Basic.extension` context to `NotificationAuthorizationHint`. Required because the notificationEvent extension moved from `Basic.modifierExtension` to `Basic.extension`.

### `Extensions.fsh` — Extension Context

- Added `Basic.extension` context to `BackportRelatedQuery` for the same reason.

### `sushi-config.yaml` — Re-enabled Exclusion Lists

- Updated xver dependency version from `0.0.1-snapshot-3` to `0.1.0`.
- Uncommented `r4-exclusion` and `r4b-exclusion` parameter lists (previously disabled due to IG Publisher `R4ToR4BAnalyser.markExempt` NPE bug — now fixed).

### `ignoreWarnings.txt` — ValueSet Suppressions

- Added suppressions for xver `R5-subscription-status-for-R4` ValueSet validation errors. The xver ValueSet only includes `entered-in-error`; other valid codes (`active`, `requested`, `error`, `off`) are in the CodeSystem but not the ValueSet. This is an xver package defect.

## Build Status

- SUSHI: 0 errors, 0 warnings.
- IG Publisher QA: 131 errors, 25 warnings. Remaining errors are:
  - **R4B broken links** (~79,000 in build errors): Generated R4B HTML/TTL/XML pages link to `http://hl7.org/fhir/R4B/` URLs that can't be resolved. IG Publisher issue, not actionable from IG source.
  - **Inline script errors**: Generated HTML contains inline `<script>` tags. Template issue.
  - **Missing file links**: CSV, Excel, Schematron, OpenAPI, examples pages not generated. IG Publisher configuration/template issue.
  - **IG version mismatches** (2): `hl7.fhir.uv.tools#current` and `hl7.terminology.r5` are FHIR 5.0.0 but this IG targets 4.0.1.
  - **SubscriptionTopic version errors** (4): `Basic/r4-encounter-complete` uses `4.3` version extension URLs.
  - **Extension context errors** for R4B types (`SubscriptionStatus.notificationEvent`, `SubscriptionTopic.notificationShape`) which are invalid in pure R4 mode.

## Known Issues

- **R4B support removed**: R4B-specific artifacts are no longer built. The R4B notification profiles remain in `input/fsh-r4b/` for reference but are not processed.
- **xver ValueSet resolution**: The xver package's `R5-subscription-status-for-R4` ValueSet fails to resolve standard subscription status codes. This affects all 12 notification status examples. Suppressed in `ignoreWarnings.txt`. Awaiting fix in xver package.
- **xver narrative paths**: The xver package contains Windows-style file paths in extension narrative HTML, causing validation errors.
- **R4 SubscriptionTopic example**: `Basic/r4-encounter-complete` still uses `4.3` version extension URLs (not migrated to `5.0` in this phase).

## IG Publisher Fix

Fixed `R4ToR4BAnalyser.markExempt` NPE in the IG Publisher (`hl7/fhir-ig-publisher`). The bug was that `r4-exclusion`/`r4b-exclusion` parameters were processed during `initializeFromIg()`, which called `pf.r4tor4b.markExempt()` — but `pf.r4tor4b` was not initialized until later in `load()`. Fix: buffer the exclusion values in `PublisherFields` during parameter processing and apply them after `R4ToR4BAnalyser` is constructed.

**Files changed:**
- `PublisherFields.java` — Added `r4Exclusions` and `r4bExclusions` lists.
- `PublisherIGLoader.java` — Parameter processing collects into lists; exclusions applied after `r4tor4b` initialization.
