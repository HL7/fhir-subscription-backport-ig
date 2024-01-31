### STU 1.2.0

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
* [FHIR-41917](https://jira.hl7.org/browse/FHIR-41917): Clarify where the id is in the id-only Notification Profile
  * Added clarifying text to the [Payloads Page](payloads.html)
  * Added reference to payloads from then [Notifications Page](notifications.html)
* [FHIR-43081](https://jira.hl7.org/browse/FHIR-43081): Add authorization information to notifications
  * Added [notification-authorization-hint](StructureDefinition-notification-authorization-hint.html) extension
  * Added content to the [Safety and Security page](safety_security.html) regarding authorization in notifications.
* [FHIR-43072](https://jira.hl7.org/browse/FHIR-43072): Incorrect search parameter type
  * `http://hl7.org/fhir/uv/subscriptions-backport/SearchParameter/Subscription-custom-channel` : `string` to `token`
  * `http://hl7.org/fhir/uv/subscriptions-backport/SearchParameter/Subscription-payload-type` : `string` to `token`
* [FHIR-38803](https://jira.hl7.org/browse/FHIR-38803): the subscriptions backport should describe how to do notifications in R4 as well as or instead of R4B
  * Added `Basic` representation as *recommended* R4 representation of `SubscriptionTopic` resources.
* Various TCs (e.g., typos)
  * [FHIR-41024](https://jira.hl7.org/browse/FHIR-41024): 2.3.3 Workflow for R4 includes a subsection referencing R4B
  * Fixes to `CapabilityStatement` resources for correctness.
  * Fixes to FHIRPath expressions in `SearchParameter` resources for correctness.
  * [FHIR-44549](https://jira.hl7.org/browse/FHIR-44549): Various TCs (ballot)
  * [FHIR-44045](https://jira.hl7.org/browse/FHIR-44045): Conformance language TCs (ballot)
  * [FHIR-43916](https://jira.hl7.org/browse/FHIR-43916): Typo (ballot)
* Added change log.

### STU 1.1.0

* Updated to support both FHIR R4 and R4B.
* Artifacts ported between versions.

### STU 1.0.0

* Initial publication based on FHIR R4B

### Development 0.1.0

* Initial design and porting to FHIR R4.