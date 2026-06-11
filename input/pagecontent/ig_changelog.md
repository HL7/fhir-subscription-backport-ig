### STU 2.0.0

* Non-compatible
  * Updated to use Cross-Version extension packages.

* Compatible, Substantive
  * [FHIR-43505](https://jira.hl7.org/browse/FHIR-43505): Consider describing administratively created subscriptions
    * Added note to the `Server` section of the [Actors](actors.html) page.
    * Added the `Managing Subscriptions` section to the [Components](components.html) page.
    * Categorized the existing FHIR R4 and FHIR R4B subscription-creation sequence diagrams as the `Dynamic` mechanism on the [Workflow](workflow.html) page.
    * Added a new `Administrative Workflow` section to the [Workflow](workflow.html) page describing server-admin-configured subscriptions.
    * Updated the [Conformance](conformance.html) page to include qualifications for `Administrative` conformance.
  * [FHIR-43275](https://jira.hl7.org/browse/FHIR-43275): Add 'notified pull' option to notifications
    * Added `Notified Pull` section to the [Notifications](notifications.html) page
    * Added `related-query` to [Backport R5 SubscriptionStatus](StructureDefinition-backport-subscription-status-r4.html) profile
    * Added extension [backport-related-query](StructureDefinition-backport-related-query.html)
    * Updated example [Backported SubscriptionTopic: R4 Encounter Complete](Basic-r4-encounter-complete.html)
    * Updated example [Backported SubscriptionTopic: R4B Encounter Complete](SubscriptionTopic-r4b-encounter-complete.html)
    * Added example [r4-notification-id-only-with-query](Bundle-r4-notification-id-only-with-query.html)
    * Added example [r4-notification-full-resource-with-query](Bundle-r4-notification-full-resource-with-query.html)
    * Added example [r4b-notification-id-only-with-query](Bundle-r4b-notification-id-only-with-query.html)
    * Added example [r4b-notification-full-resource-with-query](Bundle-r4b-notification-full-resource-with-query.html)
  * [FHIR-43082](https://jira.hl7.org/browse/FHIR-43082): Add operation to resend events
    * Added [Backport Subscription Resend Operation](OperationDefinition-backport-subscription-resend.html)
  * [FHIR-43081](https://jira.hl7.org/browse/FHIR-43081): Add authorization information to notifications
    * Added [notification-authorization-hint](StructureDefinition-notification-authorization-hint.html) extension
    * Added content to the [Safety and Security page](safety_security.html) regarding authorization in notifications.
    * Updated to use Extensions-Pack common extension: `http://hl7.org/fhir/StructureDefinition/authorization-hint`.

* Non-substantive
  * [FHIR-43612](https://jira.hl7.org/browse/FHIR-43612): Discuss related-queries in the ID Only section
    * Expanded the [Notifications](notifications.html#notified-pull) page `Notified Pull` section with a new `Comparison with Payload Types` subsection.
  * [FHIR-43608](https://jira.hl7.org/browse/FHIR-43608): The query for notify pull wouldn't be in the Topic, only the query "name" would
    * Relaxed `query` sub-extension cardinality from `1..1` to `0..1` on the [backport-related-query](StructureDefinition-backport-related-query.html) extension
    * Clarified [Adding Queries to Notifications](notifications.html#adding-queries-to-notifications) so the topic definition MAY contain the runtime query string and the notification SHALL contain it
  * [FHIR-43607](https://jira.hl7.org/browse/FHIR-43607): Don't imply that standardized queries are the norm
    * Changed the `Unstandardized Queries` section to `Query Standardization` on the [Notifications](notifications.html) page to describe both standardized and unstandardized queries from a neutral stance.
  * [FHIR-43605](https://jira.hl7.org/browse/FHIR-43605): "history" bundle type requirement seems inconsistent with Messaging channel
    * Added clarifying text and a 'Dragon' note to the [Channels](channels.html) page regarding messaging and 'double bundles'.
  * [FHIR-43564](https://jira.hl7.org/browse/FHIR-43564): Subscription.status with handshake
    * Added clarifying text to the [Workflow](workflow.html) page about handshakes and state transitions.
  * [FHIR-43563](https://jira.hl7.org/browse/FHIR-43563): Subscription lifecycle doesn't account for governance
    * Loosened the REST-Hook lifecycle wording on the [Channels](channels.html) page.
  * [FHIR-43515](https://jira.hl7.org/browse/FHIR-43515): Application vs. Server for subscription authorization
    * Updated the [Safety and Security page](safety_security.html) to align with defined actors.
  * [FHIR-43514](https://jira.hl7.org/browse/FHIR-43514): Should SubscriptionTopic.read and search be required?
    * Updated 'administrative' capability statements for topic discovery from 'SHOULD' to 'MAY'.
    * Updated the [Conformance](conformance.html) page to match.
  * [FHIR-43513](https://jira.hl7.org/browse/FHIR-43513): Should conformance require Subscription write?
    * Added 'administrative' capability statements.
    * Further clarified language on the [Conformance](conformance.html) page.
  * [FHIR-41917](https://jira.hl7.org/browse/FHIR-41917): Clarify where the id is in the id-only Notification Profile
    * Added clarifying text to the [Payloads Page](payloads.html)
    * Added reference to payloads from then [Notifications Page](notifications.html)
  * [FHIR-43072](https://jira.hl7.org/browse/FHIR-43072): Incorrect search parameter type
    * `http://hl7.org/fhir/uv/subscriptions-backport/SearchParameter/Subscription-custom-channel` : `string` to `token`
    * `http://hl7.org/fhir/uv/subscriptions-backport/SearchParameter/Subscription-payload-type` : `string` to `token`
  * [FHIR-38803](https://jira.hl7.org/browse/FHIR-38803): the subscriptions backport should describe how to do notifications in R4 as well as or instead of R4B
    * Added `Basic` representation as *recommended* R4 representation of `SubscriptionTopic` resources.
  * Added change log.

* Technical Corrections
  * [FHIR-41024](https://jira.hl7.org/browse/FHIR-41024): 2.3.3 Workflow for R4 includes a subsection referencing R4B
  * Fixes to `CapabilityStatement` resources for correctness.
  * Fixes to FHIRPath expressions in `SearchParameter` resources for correctness.
  * [FHIR-44549](https://jira.hl7.org/browse/FHIR-44549): Various TCs (ballot)
  * [FHIR-44045](https://jira.hl7.org/browse/FHIR-44045): Conformance language TCs (ballot)
  * [FHIR-43916](https://jira.hl7.org/browse/FHIR-43916): Typo (ballot)
  * [FHIR-43859](https://jira.hl7.org/browse/FHIR-43859): Review R5 "in progress" wordage (ballot)
  * [FHIR-43918](https://jira.hl7.org/browse/FHIR-43918): Review R5 "in progress" wordage (ballot)
  * [FHIR-43504](https://jira.hl7.org/browse/FHIR-43504): Review R5 "in progress" wordage (ballot)
  * [FHIR-43706](https://jira.hl7.org/browse/FHIR-43706): Typos (ballot)
  * [FHIR-43611](https://jira.hl7.org/browse/FHIR-43611): Typo (ballot)
  * [FHIR-43606](https://jira.hl7.org/browse/FHIR-43606): Typo (ballot)
  * [FHIR-43726](https://jira.hl7.org/browse/FHIR-43726): Link for Direct (ballot)
  * [FHIR-44040](https://jira.hl7.org/browse/FHIR-44040): Update URLs to be explicit to R4/R4B (ballot)
  * [FHIR-43504](https://jira.hl7.org/browse/FHIR-43504): R5 is no longer in the future (ballot)

### STU 1.1.0

* Updated to support both FHIR R4 and R4B.
* Artifacts ported between versions.

### STU 1.0.0

* Initial publication based on FHIR R4B

### Development 0.1.0

* Initial design and porting to FHIR R4.