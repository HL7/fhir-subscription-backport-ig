Profile:     BackportSubscriptionNotificationR4
Parent:      Bundle
Id:          backport-subscription-notification-r4
Title:       "R4 Topic-Based Subscription Notification Bundle"
Description: "Profile on the R4 Bundle resource to enable R5-style topic-based subscription notifications in FHIR R4."
* insert StructureCommonR4
* type = #history
* entry ^slicing.discriminator.type = #type
* entry ^slicing.discriminator.path = "resource"
* entry ^slicing.rules = #open
* entry ^slicing.ordered = false
* entry ^slicing.description = "Slice based on resource"
* entry contains subscriptionStatus 1..1 MS
* entry[subscriptionStatus].resource 1..1 MS
* entry[subscriptionStatus].resource only BackportSubscriptionStatusR4
* obeys backport-notification-bundle-r4-1

Invariant:   backport-notification-bundle-r4-1
Description: "A notification bundle MUST have a Basic as the first entry"
Expression:  "(entry.first().resource.is(Basic))"
Severity:    #error
XPath:       "f:entry[1]/f:resource/f:Basic"


Profile:      BackportSubscriptionStatusR4
Parent:       Basic
Id:           backport-subscription-status-r4
Title:        "R4 Backported R5 SubscriptionStatus"
Description:  "Profile on Basic for topic-based subscription notifications in R4."
* insert StructureCommonR4
* code = http://hl7.org/fhir/fhir-types#SubscriptionStatus
* modifierExtension contains $xverSubStatus named subscriptionStatus 1..1 MS


// --------------------------------------------------------------------------
// RuleSets for inline status instances (applied to BackportSubscriptionStatusR4 instances)
// --------------------------------------------------------------------------

RuleSet: StatusBase(subscriptionRef, topic, status, type, sinceStart)
* modifierExtension[subscriptionStatus].extension[subscription].valueReference.reference = {subscriptionRef}
* modifierExtension[subscriptionStatus].extension[topic].valueCanonical = {topic}
* modifierExtension[subscriptionStatus].extension[status].valueCode = {status}
* modifierExtension[subscriptionStatus].extension[type].valueCode = {type}
* modifierExtension[subscriptionStatus].extension[eventsSinceSubscriptionStart].valueString = "{sinceStart}"

RuleSet: StatusEvent(eventNumber)
* modifierExtension[subscriptionStatus].extension[notificationEvent].extension[eventNumber].valueString = "{eventNumber}"
* modifierExtension[subscriptionStatus].extension[notificationEvent].extension[timestamp].valueInstant = "2020-05-29T11:44:13.1882432-05:00"

RuleSet: StatusEventFocus(focus)
* modifierExtension[subscriptionStatus].extension[notificationEvent].extension[focus].valueReference.reference = {focus}

RuleSet: StatusEventContext(additionalContext)
* modifierExtension[subscriptionStatus].extension[notificationEvent].extension[additionalContext].valueReference.reference = {additionalContext}

RuleSet: StatusError(vs, code)
* modifierExtension[subscriptionStatus].extension[error].valueCodeableConcept = {vs}{code}

// RuleSet for bundle entry metadata (applied to Bundle instances)
RuleSet: BundleEntry0(id)
* entry[0].fullUrl  = "urn:uuid:{id}"
* entry[0].resource.id = "{id}"
* entry[0].request.method = #GET
* entry[0].request.url = $admissionSubStatus
* entry[0].response.status = "200"


// --------------------------------------------------------------------------
// Standalone Status Example
// --------------------------------------------------------------------------

Instance:    BackportNotificationStatusExampleR4
InstanceOf:  BackportSubscriptionStatusR4
Usage:       #example
Title:       "R4 Notification: Status"
Description: "R4 Example of a topic-based subscription notification with status content."
* id       = "r4-notification-status"
* insert StatusBase($admissionSub, $admissionTopic, #active, #event-notification, 2)
* insert StatusEvent(2)


// --------------------------------------------------------------------------
// Inline Status Instances (one per notification example)
// --------------------------------------------------------------------------

Instance:    StatusForHandshakeR4
InstanceOf:  BackportSubscriptionStatusR4
Usage:       #inline
* insert StatusBase($admissionSub, $admissionTopic, #requested, #handshake, 0)

Instance:    StatusForHeartbeatR4
InstanceOf:  BackportSubscriptionStatusR4
Usage:       #inline
* insert StatusBase($admissionSub, $admissionTopic, #active, #heartbeat, 2)

Instance:    StatusForEmptyR4
InstanceOf:  BackportSubscriptionStatusR4
Usage:       #inline
* insert StatusBase($admissionSub, $admissionTopic, #active, #event-notification, 2)
* insert StatusEvent(2)

Instance:    StatusForEmptyWithAuthR4
InstanceOf:  BackportSubscriptionStatusR4
Usage:       #inline
* insert StatusBase($admissionSub, $admissionTopic, #active, #event-notification, 2)
* insert StatusEvent(2)
* modifierExtension[subscriptionStatus].extension[notificationEvent].extension[2].url = $authorizationHintExt
* modifierExtension[subscriptionStatus].extension[notificationEvent].extension[2].extension[0].url = "type"
* modifierExtension[subscriptionStatus].extension[notificationEvent].extension[2].extension[0].valueCoding = http://example.org/auth#authorization_base "OAuth request token"
* modifierExtension[subscriptionStatus].extension[notificationEvent].extension[2].extension[1].url = "value"
* modifierExtension[subscriptionStatus].extension[notificationEvent].extension[2].extension[1].valueString = "ZGFhNDFjY2MtZGFmMi00YjZkLThiNDYtN2JlZDk1MWEyYzk2"

Instance:    StatusForIdOnlyR4
InstanceOf:  BackportSubscriptionStatusR4
Usage:       #inline
* insert StatusBase($admissionSub, $admissionTopic, #active, #event-notification, 2)
* insert StatusEvent(2)
* insert StatusEventFocus($notificationEncounter1)

Instance:    StatusForIdOnlyWithAuthR4
InstanceOf:  BackportSubscriptionStatusR4
Usage:       #inline
* insert StatusBase($admissionSub, $admissionTopic, #active, #event-notification, 2)
* insert StatusEvent(2)
* insert StatusEventFocus($notificationEncounter1)
* modifierExtension[subscriptionStatus].extension[notificationEvent].extension[3].url = $authorizationHintExt
* modifierExtension[subscriptionStatus].extension[notificationEvent].extension[3].extension[0].url = "type"
* modifierExtension[subscriptionStatus].extension[notificationEvent].extension[3].extension[0].valueCoding = http://example.org/auth#authorization_base "OAuth request token"
* modifierExtension[subscriptionStatus].extension[notificationEvent].extension[3].extension[1].url = "value"
* modifierExtension[subscriptionStatus].extension[notificationEvent].extension[3].extension[1].valueString = "ZGFhNDFjY2MtZGFmMi00YjZkLThiNDYtN2JlZDk1MWEyYzk2"

Instance:    StatusForIdOnlyWithQueryR4
InstanceOf:  BackportSubscriptionStatusR4
Usage:       #inline
* insert StatusBase($admissionSub, $admissionTopic, #active, #event-notification, 2)
* insert StatusEvent(2)
* insert StatusEventFocus($notificationEncounter1)
* modifierExtension[subscriptionStatus].extension[notificationEvent].extension[3].url = $relatedQueryExt
* modifierExtension[subscriptionStatus].extension[notificationEvent].extension[3].extension[0].url = "queryType"
* modifierExtension[subscriptionStatus].extension[notificationEvent].extension[3].extension[0].valueCoding = http://example.org/query-types#example "Example query"
* modifierExtension[subscriptionStatus].extension[notificationEvent].extension[3].extension[1].url = "query"
* modifierExtension[subscriptionStatus].extension[notificationEvent].extension[3].extension[1].valueString = "http://example.org/fhir/$example?patient=$notificationPatientId"

Instance:    StatusForFullResourceR4
InstanceOf:  BackportSubscriptionStatusR4
Usage:       #inline
* insert StatusBase($admissionSub, $admissionTopic, #active, #event-notification, 2)
* insert StatusEvent(2)
* insert StatusEventFocus($notificationEncounter1)

Instance:    StatusForFullResourceWithQueryR4
InstanceOf:  BackportSubscriptionStatusR4
Usage:       #inline
* insert StatusBase($admissionSub, $admissionTopic, #active, #event-notification, 2)
* insert StatusEvent(2)
* insert StatusEventFocus($notificationEncounter1)
* modifierExtension[subscriptionStatus].extension[notificationEvent].extension[3].url = $relatedQueryExt
* modifierExtension[subscriptionStatus].extension[notificationEvent].extension[3].extension[0].url = "queryType"
* modifierExtension[subscriptionStatus].extension[notificationEvent].extension[3].extension[0].valueCoding = http://example.org/query-types#example "Example query"
* modifierExtension[subscriptionStatus].extension[notificationEvent].extension[3].extension[1].url = "query"
* modifierExtension[subscriptionStatus].extension[notificationEvent].extension[3].extension[1].valueString = "http://example.org/fhir/$example?patient=$notificationPatientId"
* modifierExtension[subscriptionStatus].extension[notificationEvent].extension[4].url = $relatedQueryExt
* modifierExtension[subscriptionStatus].extension[notificationEvent].extension[4].extension[0].url = "queryType"
* modifierExtension[subscriptionStatus].extension[notificationEvent].extension[4].extension[0].valueCoding = http://example.org/query-types#prescribed "Prescribed medications"
* modifierExtension[subscriptionStatus].extension[notificationEvent].extension[4].extension[1].url = "query"
* modifierExtension[subscriptionStatus].extension[notificationEvent].extension[4].extension[1].valueString = "http://example.org/fhir/MedicationRequest?patient=$notificationPatientId&encounter=$notificationEncounter1Id"

Instance:    StatusForMultiResourceR4
InstanceOf:  BackportSubscriptionStatusR4
Usage:       #inline
* insert StatusBase($admissionSub, $admissionTopic, #active, #event-notification, 2)
* insert StatusEvent(2)
* insert StatusEventFocus($notificationEncounter1)
* insert StatusEventContext($notificationPatient)

Instance:    StatusForErrorR4
InstanceOf:  BackportSubscriptionStatusR4
Usage:       #inline
* insert StatusBase($admissionSub, $admissionTopic, #error, #query-status, 3)
* insert StatusError(http://terminology.hl7.org/CodeSystem/subscription-error, #no-response)


// --------------------------------------------------------------------------
// Notification Bundle Examples
// --------------------------------------------------------------------------

Instance:    BackportNotificationExampleHandshakeR4
InstanceOf:  BackportSubscriptionNotificationR4
Usage:       #example
Title:       "R4 Notification: Handshake"
Description: "R4 Example of a topic-based subscription `handshake` notification."
* id        = "r4-notification-handshake"
* timestamp = "2020-05-29T11:44:13.1882432-05:00"
* entry[0].fullUrl  = "urn:uuid:63c28e8a-f402-43e4-beb2-75b1c0f6833f"
* entry[0].resource = StatusForHandshakeR4
* entry[0].resource.id = "63c28e8a-f402-43e4-beb2-75b1c0f6833f"
* entry[0].request.method = #GET
* entry[0].request.url = $admissionSubStatus
* entry[0].response.status = "200"


Instance:    BackportNotificationExampleHeartbeatR4
InstanceOf:  BackportSubscriptionNotificationR4
Usage:       #example
Title:       "R4 Notification: Heartbeat"
Description: "R4 Example of a topic-based subscription `heartbeat` notification."
* id        = "r4-notification-heartbeat"
* timestamp = "2020-05-29T11:44:13.1882432-05:00"
* entry[0].fullUrl  = "urn:uuid:385b23bd-6d03-462e-894d-a0694045d65c"
* entry[0].resource = StatusForHeartbeatR4
* entry[0].resource.id = "385b23bd-6d03-462e-894d-a0694045d65c"
* entry[0].request.method = #GET
* entry[0].request.url = $admissionSubStatus
* entry[0].response.status = "200"


Instance:    BackportNotificationExampleEmptyR4
InstanceOf:  BackportSubscriptionNotificationR4
Usage:       #example
Title:       "R4 Notification: Empty"
Description: "R4 Example of a topic-based subscription event notification with `empty` content."
* id        = "r4-notification-empty"
* timestamp = "2020-05-29T11:44:13.1882432-05:00"
* entry[0].fullUrl  = "urn:uuid:9e41ff6d-5be6-4e6a-8b85-abd4e7f58400"
* entry[0].resource = StatusForEmptyR4
* entry[0].resource.id = "9e41ff6d-5be6-4e6a-8b85-abd4e7f58400"
* entry[0].request.method = #GET
* entry[0].request.url = $admissionSubStatus
* entry[0].response.status = "200"

Instance:    BackportNotificationExampleEmptyWithAuthR4
InstanceOf:  BackportSubscriptionNotificationR4
Usage:       #example
Title:       "R4 Notification: Empty with Authorization"
Description: "R4 Example of a topic-based subscription event notification with `empty` content and authorization."
* id        = "r4-notification-empty-with-auth"
* timestamp = "2020-05-29T11:44:13.1882432-05:00"
* entry[0].fullUrl  = "urn:uuid:7b8ccdfd-b799-480c-84a5-1d1381513edf"
* entry[0].resource = StatusForEmptyWithAuthR4
* entry[0].resource.id = "7b8ccdfd-b799-480c-84a5-1d1381513edf"
* entry[0].request.method = #GET
* entry[0].request.url = $admissionSubStatus
* entry[0].response.status = "200"


Instance:    BackportNotificationExampleIdOnlyR4
InstanceOf:  BackportSubscriptionNotificationR4
Usage:       #example
Title:       "R4 Notification: Id Only"
Description: "R4 Example of a topic-based subscription event notification with `id-only` content."
* id        = "r4-notification-id-only"
* timestamp = "2020-05-29T11:44:13.1882432-05:00"
* entry[0].fullUrl  = "urn:uuid:292d3c72-edc1-4d8a-afaa-d85e19c7f563"
* entry[0].resource = StatusForIdOnlyR4
* entry[0].resource.id = "292d3c72-edc1-4d8a-afaa-d85e19c7f563"
* entry[0].request.method = #GET
* entry[0].request.url = $admissionSubStatus
* entry[0].response.status = "200"

Instance:    BackportNotificationExampleIdOnlyWithAuthR4
InstanceOf:  BackportSubscriptionNotificationR4
Usage:       #example
Title:       "R4 Notification: Id Only with Authorization"
Description: "R4 Example of a topic-based subscription event notification with `id-only` content and authorization."
* id        = "r4-notification-id-only-with-auth"
* timestamp = "2020-05-29T11:44:13.1882432-05:00"
* entry[0].fullUrl  = "urn:uuid:d5359778-3cda-46f0-8193-54bd09ad8309"
* entry[0].resource = StatusForIdOnlyWithAuthR4
* entry[0].resource.id = "d5359778-3cda-46f0-8193-54bd09ad8309"
* entry[0].request.method = #GET
* entry[0].request.url = $admissionSubStatus
* entry[0].response.status = "200"

Instance:    BackportNotificationExampleIdOnlyWithQueryR4
InstanceOf:  BackportSubscriptionNotificationR4
Usage:       #example
Title:       "R4 Notification: Id Only with Related Query"
Description: "R4 Example of a topic-based subscription event notification with `id-only` content and related queries."
* id        = "r4-notification-id-only-with-query"
* timestamp = "2020-05-29T11:44:13.1882432-05:00"
* entry[0].fullUrl  = "urn:uuid:20f7e506-69ba-4895-b1f8-044dab538bc4"
* entry[0].resource = StatusForIdOnlyWithQueryR4
* entry[0].resource.id = "20f7e506-69ba-4895-b1f8-044dab538bc4"
* entry[0].request.method = #GET
* entry[0].request.url = $admissionSubStatus
* entry[0].response.status = "200"


Instance:    BackportNotificationExampleFullResourceR4
InstanceOf:  BackportSubscriptionNotificationR4
Usage:       #example
Title:       "R4 Notification: Full Resource"
Description: "R4 Example of a topic-based subscription event notification with `full-resource` content."
* id        = "r4-notification-full-resource"
* timestamp = "2020-05-29T11:44:13.1882432-05:00"
* entry[0].fullUrl  = "urn:uuid:2d5afc69-6ef2-420f-a8d1-8500c99eb96c"
* entry[0].resource = StatusForFullResourceR4
* entry[0].resource.id = "2d5afc69-6ef2-420f-a8d1-8500c99eb96c"
* entry[0].request.method = #GET
* entry[0].request.url = $admissionSubStatus
* entry[0].response.status = "200"
* entry[1].fullUrl  = $notificationEncounter1
* entry[1].resource = BackportNotificationEncounter
* entry[1].request.method = #POST
* entry[1].request.url    = "Encounter"
* entry[1].response.status = "201"

Instance:    BackportNotificationExampleFullResourceWithQueryR4
InstanceOf:  BackportSubscriptionNotificationR4
Usage:       #example
Title:       "R4 Notification: Full Resource with related query"
Description: "R4 Example of a topic-based subscription event notification with `full-resource` content and related queries."
* id        = "r4-notification-full-resource-with-query"
* timestamp = "2020-05-29T11:44:13.1882432-05:00"
* entry[0].fullUrl  = "urn:uuid:919ce5d0-d77c-44a7-a397-d8b2a05fd1bf"
* entry[0].resource = StatusForFullResourceWithQueryR4
* entry[0].resource.id = "919ce5d0-d77c-44a7-a397-d8b2a05fd1bf"
* entry[0].request.method = #GET
* entry[0].request.url = $admissionSubStatus
* entry[0].response.status = "200"
* entry[1].fullUrl  = $notificationEncounter1
* entry[1].resource = BackportNotificationEncounter
* entry[1].request.method = #POST
* entry[1].request.url    = "Encounter"
* entry[1].response.status = "201"



Instance:    BackportNotificationExampleMultiResourceR4
InstanceOf:  BackportSubscriptionNotificationR4
Usage:       #example
Title:       "R4 Notification: Multiple Resources"
Description: "R4 Example of a topic-based subscription event notification with `full-resource` content and a related resource."
* id        = "r4-notification-multi-resource"
* timestamp = "2020-05-29T11:44:13.1882432-05:00"
* entry[0].fullUrl  = "urn:uuid:7bd91d26-c951-4520-9ac6-67f41bfbe897"
* entry[0].resource = StatusForMultiResourceR4
* entry[0].resource.id = "7bd91d26-c951-4520-9ac6-67f41bfbe897"
* entry[0].request.method = #GET
* entry[0].request.url = $admissionSubStatus
* entry[0].response.status = "200"
* entry[1].fullUrl  = $notificationEncounter1
* entry[1].resource = BackportNotificationEncounter
* entry[1].request.method = #POST
* entry[1].request.url    = "Encounter"
* entry[1].response.status = "201"
* entry[2].fullUrl  = $notificationPatient
* entry[2].resource = BackportNotificationPatient
* entry[2].request.method = #GET
* entry[2].request.url    = "Patient/1599eb66-431a-447c-a3de-6897fe9ae9a1"
* entry[2].response.status = "200"


Instance:    BackportNotificationExampleErrorR4
InstanceOf:  BackportSubscriptionNotificationR4
Usage:       #example
Title:       "R4 Notification: Error"
Description: "R4 Example of a topic-based subscription query-status response with an error state."
* id        = "r4-notification-error"
* timestamp = "2020-05-29T11:44:13.1882432-05:00"
* entry[0].fullUrl  = "urn:uuid:7bd91d26-c951-4520-9ac6-67f41bfbe897"
* entry[0].resource = StatusForErrorR4
* entry[0].resource.id = "7bd91d26-c951-4520-9ac6-67f41bfbe897"
* entry[0].request.method = #GET
* entry[0].request.url = $admissionSubStatus
* entry[0].response.status = "200"
