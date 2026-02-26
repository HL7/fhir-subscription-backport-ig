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
- **Defined `BackportSubscriptionStatusR4Extension`** (`backport-subscription-status-r4-extension`) complex extension on `Basic` with sub-extensions: `subscription` (Reference), `topic` (canonical), `status` (code), `type` (code), `eventsSinceSubscriptionStart` (string), `notificationEvent` (complex with eventNumber/timestamp/focus/additionalContext), `error` (CodeableConcept).
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

### `Authorization.fsh`
- Added `ExtensionContext(Basic.extension.extension)` to `NotificationAuthorizationHint` to allow use within the nested notificationEvent sub-extension on Basic resources.

### `Extensions.fsh`
- Added `ExtensionContext(Basic.extension.extension)` to `BackportRelatedQuery` for the same reason.

### `sushi-config.yaml`
- Commented out `r4-exclusion` and `r4b-exclusion` lists as a temporary workaround for an IG Publisher bug (`R4ToR4BAnalyser.markExempt` NPE in v2.0.6+).

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

## Build Status

- SUSHI: 0 errors, 0 warnings.
- IG Publisher: 25 errors, 55 warnings, 13 broken links. All remaining errors are pre-existing (version mismatches, broken links for local builds, R5 CodeSystem `fhir-types` not found in R4B context, IG dependency version/packageId clashes). No errors from the XVer alignment changes. The 27 cross-version extension validation errors on `Basic-r4-encounter-complete` were eliminated by Phase 4b.

## Known Issues

- **IG Publisher R4ToR4BAnalyser NPE**: The `r4-exclusion` and `r4b-exclusion` lists in `sushi-config.yaml` are commented out as a workaround for a bug in IG Publisher v2.0.6+ where `R4ToR4BAnalyser.markExempt()` is called before the analyser is initialized. These should be restored once the publisher is fixed.
