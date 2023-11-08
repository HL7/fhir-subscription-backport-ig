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
Description: "A notification bundle MUST have a Parameters as the first entry"
Expression:  "(entry.first().resource.is(Parameters))"
// Expression:  "(entry.first().resource.is(Parameters)) and (entry.first().resource.conformsTo(backport-subscription-status-r4))"
Severity:    #error
XPath:       "f:entry[1]/f:resource/f:Parameters"


Profile:      BackportSubscriptionStatusR4
Parent:       Parameters
Id:           backport-subscription-status-r4
Title:        "R4 Backported R5 SubscriptionStatus"
Description:  "Profile on Parameters for topic-based subscription notifications in R4."
* insert StructureCommonR4
* . ^short = "Parameter containing subscription status information"
* parameter ^short = "Slices containing subscription status information"
* parameter ^slicing.discriminator.type = #value
* parameter ^slicing.discriminator.path = "name"
* parameter ^slicing.rules = #open
* parameter ^slicing.ordered = false
* parameter ^slicing.description = "Slice on parameter name"
* parameter 
    contains subscription 1..1 MS
    and topic 0..1 MS
    and status 1..1 MS
    and type 1..1 MS
    and eventsSinceSubscriptionStart 0..1 MS
    and notificationEvent 0..* MS
    and error 0..* MS
* parameter[subscription] ^short = "Parameter containing the reference to a subscription"
* parameter[subscription].name = "subscription" (exactly)
* parameter[subscription].name ^short = "Slice discriminator: the reference to a subscription"
* parameter[subscription].value[x] 1..1 MS
* parameter[subscription].value[x] only Reference(Subscription)
* parameter[subscription].value[x] ^short      = "Reference to the Subscription responsible for this notification"
* parameter[subscription].value[x] ^definition = "The reference to the Subscription which generated this notification."
* parameter[topic] ^short = "Parameter containing the canonical reference to a subscription topic"
* parameter[topic].name = "topic" (exactly)
* parameter[topic].name ^short = "Slice discriminator: the canonical reference to a subscription topic"
* parameter[topic].value[x] 0..1 MS
* parameter[topic].value[x] only canonical
* parameter[topic].value[x] ^short      = "Canonical reference to the SubscriptionTopic this notification relates to"
* parameter[topic].value[x] ^definition = "Canonical reference to the SubscriptionTopic for the Subscription which generated this notification."
* parameter[topic].value[x] ^comment    = "This value SHOULD NOT be present when using `empty` payloads, MAY be present when using id-only payloads, and SHOULD be present when using `full-resource` payloads."
* parameter[status] ^short = "Parameter containing the subscription status"
* parameter[status].name = "status" (exactly)
* parameter[status].name ^short = "Slice discriminator: the subscription status"
* parameter[status].value[x] 1..1 MS
* parameter[status].value[x] only code
* parameter[status].value[x] from http://hl7.org/fhir/ValueSet/subscription-status
* parameter[status].value[x] ^short      = "Status of the subscription when this notification was generated"
* parameter[status].value[x] ^definition = "The status of the subscription, which marks the server state for managing the subscription."
* parameter[type] ^short = "Parameter containing the type of event for this notification"
* parameter[type].name = "type" (exactly)
* parameter[type].name ^short = "Slice discriminator: the type of event for this notification"
* parameter[type].value[x] 1..1 MS
* parameter[type].value[x] only code
* parameter[type].value[x] from http://hl7.org/fhir/ValueSet/subscription-notification-type
* parameter[type].value[x] ^short      = "The type of event being conveyed with this notificaiton."
* parameter[eventsSinceSubscriptionStart] ^short = "Parameter containing the number of events since this subscription started"
* parameter[eventsSinceSubscriptionStart].name = "events-since-subscription-start" (exactly)
* parameter[eventsSinceSubscriptionStart].name ^short = "Slice discriminator: the number of events since this subscription started"
* parameter[eventsSinceSubscriptionStart].value[x] 0..1 MS
* parameter[eventsSinceSubscriptionStart].value[x] only string
* parameter[eventsSinceSubscriptionStart].value[x] ^short      = "Events since the Subscription was created"
* parameter[eventsSinceSubscriptionStart].value[x] ^definition = "The total number of actual events which have been generated since the Subscription was created (inclusive of this notification) - regardless of how many have been successfully communicated. This number is NOT incremented for handshake and heartbeat notifications."
* parameter[notificationEvent] ^short = "Parameter containing the event notification details"
* parameter[notificationEvent].name = "notification-event" (exactly)
* parameter[notificationEvent].name ^short = "Slice discriminator: the event notification details"
* parameter[notificationEvent].part 0..* MS
* parameter[notificationEvent].name ^short = "Parameter containing notification event details"
* parameter[notificationEvent].part ^slicing.discriminator.type = #value
* parameter[notificationEvent].part ^slicing.discriminator.path = "name"
* parameter[notificationEvent].part ^slicing.rules = #open
* parameter[notificationEvent].part ^slicing.ordered = false
* parameter[notificationEvent].part ^slicing.description = "Slice on notification event parameter name"
* parameter[notificationEvent].part
    contains eventNumber 1..1 MS
    and eventTimestamp 0..1 MS
    and eventFocus 0..1 MS
    and eventAdditionalContext 0..* MS
    and authType 0..1 MS
    and authValue 0..1 MS
* parameter[notificationEvent].part[eventNumber] ^short = "Parameter containing the event number"
* parameter[notificationEvent].part[eventNumber].name = "event-number" (exactly)
* parameter[notificationEvent].part[eventNumber].name ^short = "Slice discriminator: the event number"
* parameter[notificationEvent].part[eventNumber].value[x] 1..1 MS
* parameter[notificationEvent].part[eventNumber].value[x] only string
* parameter[notificationEvent].part[eventNumber].value[x] ^short      = "Event number"
* parameter[notificationEvent].part[eventNumber].value[x] ^definition = "The sequential number of this event in this subscription context."
* parameter[notificationEvent].part[eventTimestamp] ^short = "Parameter containing the event timestamp"
* parameter[notificationEvent].part[eventTimestamp].name = "timestamp" (exactly)
* parameter[notificationEvent].part[eventTimestamp].name ^short = "Slice discriminator: the event timestamp"
* parameter[notificationEvent].part[eventTimestamp].value[x] 0..1 MS
* parameter[notificationEvent].part[eventTimestamp].value[x] only instant
* parameter[notificationEvent].part[eventTimestamp].value[x] ^short      = "The instant this event occurred"
* parameter[notificationEvent].part[eventTimestamp].value[x] ^definition = "The actual time this event occured on the server."
* parameter[notificationEvent].part[eventFocus] ^short = "Parameter containing the event focus"
* parameter[notificationEvent].part[eventFocus].name = "focus" (exactly)
* parameter[notificationEvent].part[eventFocus].name ^short = "Slice discriminator: the event focus"
* parameter[notificationEvent].part[eventFocus].value[x] 0..1 MS
* parameter[notificationEvent].part[eventFocus].value[x] only Reference
* parameter[notificationEvent].part[eventFocus].value[x] ^short      = "The focus of this event"
* parameter[notificationEvent].part[eventFocus].value[x] ^definition = "The focus of this event. While this will usually be a reference to the focus resource of the event, it MAY contain a reference to a non-FHIR object."
* parameter[notificationEvent].part[eventAdditionalContext] ^short = "Parameter containing additional context for this event"
* parameter[notificationEvent].part[eventAdditionalContext].name = "additional-context" (exactly)
* parameter[notificationEvent].part[eventAdditionalContext].name ^short = "Slice discriminator: additional context for this event"
* parameter[notificationEvent].part[eventAdditionalContext].value[x] 0..1 MS
* parameter[notificationEvent].part[eventAdditionalContext].value[x] only Reference
* parameter[notificationEvent].part[eventAdditionalContext].value[x] ^short      = "Additional context for this event"
* parameter[notificationEvent].part[eventAdditionalContext].value[x] ^definition = "Additional context information for this event. Generally, this will contain references to additional resources included with the event (e.g., the Patient relevant to an Encounter), however it MAY refer to non-FHIR objects."
* parameter[notificationEvent].part[authType] ^short = "Parameter containing the authorization hint type."
* parameter[notificationEvent].part[authType].name = "authorization-type" (exactly)
* parameter[notificationEvent].part[authType].name ^short = "Slice discriminator: the authorization hint type"
* parameter[notificationEvent].part[authType].value[x] 0..1 MS
* parameter[notificationEvent].part[authType].value[x] only Coding
* parameter[notificationEvent].part[authType].value[x] ^short      = "Authorization Hint Type"
* parameter[notificationEvent].part[authType].value[x] ^definition = "Used by clients to determine what kind of authorization is appropriate in this context."
* parameter[notificationEvent].part[authValue] ^short = "Parameter containing the authorization hint value."
* parameter[notificationEvent].part[authValue].name = "authorization-value" (exactly)
* parameter[notificationEvent].part[authValue].name ^short = "Slice discriminator: the authorization hint value"
* parameter[notificationEvent].part[authValue].value[x] 0..1 MS
* parameter[notificationEvent].part[authValue].value[x] only string
* parameter[notificationEvent].part[authValue].value[x] ^short      = "Authorization Hint Value"
* parameter[notificationEvent].part[authValue].value[x] ^definition = "A value related to the authorization (e.g., a token)."
* parameter[error] ^short = "Parameter containing errors on the subscription"
* parameter[error].name = "error" (exactly)
* parameter[error].name ^short = "Slice discriminator: errors on the subscription"
* parameter[error].value[x] 0..1 MS
* parameter[error].value[x] only CodeableConcept
* parameter[error].value[x] ^short      = "An error on the subscription"
* parameter[error].value[x] ^definition = "A record of errors that occurred when the server processed a notification."


// Instance:    BackportNotificationStatusShellR4
// InstanceOf:  BackportSubscriptionStatusR4
// Usage:       #inline
// * parameter[subscription].name = "subscription"
// * parameter[subscription].valueReference.reference = ""
// * parameter[status].name = "status"
// * parameter[status].valueCode = #active
// * parameter[type].name = "type"
// * parameter[type].valueCode = #query-status

Instance:    BackportNotificationStatusShellR4
InstanceOf:  Parameters
Usage:       #inline
* meta.profile[+] = "http://hl7.org/fhir/uv/subscriptions-backport/StructureDefinition/backport-subscription-status-r4"

RuleSet: AddParameterStatus(id, status, type, sinceStart)
// This rule set adds a status parameters, and must be called before other entries are added to a bundle
* entry[0].fullUrl  = "urn:uuid:{id}"
* entry[0].resource = BackportNotificationStatusShellR4
* entry[0].resource.id = "{id}"
* entry[0].resource.parameter[subscription].name = "subscription"
* entry[0].resource.parameter[subscription].valueReference.reference = $admissionSub
* entry[0].resource.parameter[topic].name = "topic"
* entry[0].resource.parameter[topic].valueCanonical = $admissionTopic
* entry[0].resource.parameter[status].name = "status"
* entry[0].resource.parameter[status].valueCode = {status}
* entry[0].resource.parameter[type].name = "type"
* entry[0].resource.parameter[type].valueCode = {type}
* entry[0].resource.parameter[eventsSinceSubscriptionStart].name = "events-since-subscription-start"
* entry[0].resource.parameter[eventsSinceSubscriptionStart].valueString = "{sinceStart}"
* entry[0].request.method = #GET
* entry[0].request.url = $admissionSubStatus
* entry[0].response.status = "200"

RuleSet: AddParameterStatusError(vs, code)
* entry[0].resource.parameter[error].name = "error"
* entry[0].resource.parameter[error].valueCodeableConcept = {vs}{code}

RuleSet: AddParameterStatusFirstEvent(eventNumber)
* entry[0].resource.parameter[notificationEvent].name = "notification-event"
* entry[0].resource.parameter[notificationEvent].part[eventNumber].name = "event-number"
* entry[0].resource.parameter[notificationEvent].part[eventNumber].valueString = "{eventNumber}"
* entry[0].resource.parameter[notificationEvent].part[eventTimestamp].name = "timestamp"
* entry[0].resource.parameter[notificationEvent].part[eventTimestamp].valueInstant = "2020-05-29T11:44:13.1882432-05:00"

RuleSet: AddParameterStatusEventFocus(focus)
* entry[0].resource.parameter[notificationEvent].part[eventFocus].name = "focus"
* entry[0].resource.parameter[notificationEvent].part[eventFocus].valueReference.reference = {focus}

RuleSet: AddParameterStatusEventContext(additionalContext)
* entry[0].resource.parameter[notificationEvent].part[eventAdditionalContext].name = "additional-context"
* entry[0].resource.parameter[notificationEvent].part[eventAdditionalContext].valueReference.reference = {additionalContext}


Instance:    BackportNotificationStatusExampleR4
InstanceOf:  BackportSubscriptionStatusR4
Usage:       #example
Title:       "R4 Notification: Status"
Description: "R4 Example of a topic-based subscription notification with status content."
* id       = "r4-notification-status"
* parameter[subscription].name = "subscription"
* parameter[subscription].valueReference.reference = $admissionSub
* parameter[topic].name = "topic"
* parameter[topic].valueCanonical = $admissionTopic
* parameter[status].name = "status"
* parameter[status].valueCode = #active
* parameter[type].name = "type"
* parameter[type].valueCode = #event-notification
* parameter[eventsSinceSubscriptionStart].name = "events-since-subscription-start"
* parameter[eventsSinceSubscriptionStart].valueString = "2"
* parameter[notificationEvent].name = "notification-event"
* parameter[notificationEvent].part[eventNumber].name = "event-number"
* parameter[notificationEvent].part[eventNumber].valueString = "2"
* parameter[notificationEvent].part[eventTimestamp].name = "timestamp"
* parameter[notificationEvent].part[eventTimestamp].valueInstant = "2020-05-29T11:44:13.1882432-05:00"


Instance:    BackportNotificationExampleHandshakeR4
InstanceOf:  BackportSubscriptionNotificationR4
Usage:       #example
Title:       "R4 Notification: Handshake"
Description: "R4 Example of a topic-based subscription `handshake` notification."
* id        = "r4-notification-handshake"
* timestamp = "2020-05-29T11:44:13.1882432-05:00"
* insert AddParameterStatus(63c28e8a-f402-43e4-beb2-75b1c0f6833f, #requested, #handshake, 0)


Instance:    BackportNotificationExampleHeartbeatR4
InstanceOf:  BackportSubscriptionNotificationR4
Usage:       #example
Title:       "R4 Notification: Heartbeat"
Description: "R4 Example of a topic-based subscription `heartbeat` notification."
* id        = "r4-notification-heartbeat"
* timestamp = "2020-05-29T11:44:13.1882432-05:00"
* insert AddParameterStatus(385b23bd-6d03-462e-894d-a0694045d65c, #active, #heartbeat, 2)


Instance:    BackportNotificationExampleEmptyR4
InstanceOf:  BackportSubscriptionNotificationR4
Usage:       #example
Title:       "R4 Notification: Empty"
Description: "R4 Example of a topic-based subscription event notification with `empty` content."
* id        = "r4-notification-empty"
* timestamp = "2020-05-29T11:44:13.1882432-05:00"
* insert AddParameterStatus(9e41ff6d-5be6-4e6a-8b85-abd4e7f58400, #active, #event-notification, 2)
* insert AddParameterStatusFirstEvent(2)

Instance:    BackportNotificationExampleEmptyWithAuthR4
InstanceOf:  BackportSubscriptionNotificationR4
Usage:       #example
Title:       "R4 Notification: Empty with Authoriztion"
Description: "R4 Example of a topic-based subscription event notification with `empty` content."
* id        = "r4-notification-empty-with-auth"
* timestamp = "2020-05-29T11:44:13.1882432-05:00"
* insert AddParameterStatus(7b8ccdfd-b799-480c-84a5-1d1381513edf, #active, #event-notification, 2)
* insert AddParameterStatusFirstEvent(2)
* entry[0].resource.parameter[notificationEvent].name = "notification-event"
* entry[0].resource.parameter[notificationEvent].part[authType].name = "authorization-type"
* entry[0].resource.parameter[notificationEvent].part[authType].valueCoding = http://example.org/auth#authorization_base "OAuth request token"
* entry[0].resource.parameter[notificationEvent].part[authValue].name = "authorization-value"
* entry[0].resource.parameter[notificationEvent].part[authValue].valueString = "ZGFhNDFjY2MtZGFmMi00YjZkLThiNDYtN2JlZDk1MWEyYzk2"


Instance:    BackportNotificationExampleIdOnlyR4
InstanceOf:  BackportSubscriptionNotificationR4
Usage:       #example
Title:       "R4 Notification: Id Only"
Description: "R4 Example of a topic-based subscription event notification with `id-only` content."
* id        = "r4-notification-id-only"
* timestamp = "2020-05-29T11:44:13.1882432-05:00"
* insert AddParameterStatus(292d3c72-edc1-4d8a-afaa-d85e19c7f563, #active, #event-notification, 2)
* insert AddParameterStatusFirstEvent(2)
* insert AddParameterStatusEventFocus($notificationEncounter1)
// * entry[1].fullUrl = $notificationEncounter1
// * entry[1].request.method = #POST
// * entry[1].request.url    = "Encounter"
// * entry[1].response.status = "201"

Instance:    BackportNotificationExampleIdOnlyWithAuthR4
InstanceOf:  BackportSubscriptionNotificationR4
Usage:       #example
Title:       "R4 Notification: Id Only with Authorization"
Description: "R4 Example of a topic-based subscription event notification with `id-only` content with authorization."
* id        = "r4-notification-id-only-with-auth"
* timestamp = "2020-05-29T11:44:13.1882432-05:00"
* insert AddParameterStatus(292d3c72-edc1-4d8a-afaa-d85e19c7f563, #active, #event-notification, 2)
* insert AddParameterStatusFirstEvent(2)
* insert AddParameterStatusEventFocus($notificationEncounter1)
* entry[0].resource.parameter[notificationEvent].name = "notification-event"
* entry[0].resource.parameter[notificationEvent].part[authType].name = "authorization-type"
* entry[0].resource.parameter[notificationEvent].part[authType].valueCoding = http://example.org/auth#authorization_base "OAuth request token"
* entry[0].resource.parameter[notificationEvent].part[authValue].name = "authorization-value"
* entry[0].resource.parameter[notificationEvent].part[authValue].valueString = "ZGFhNDFjY2MtZGFmMi00YjZkLThiNDYtN2JlZDk1MWEyYzk2"


Instance:    BackportNotificationExampleFullResourceR4
InstanceOf:  BackportSubscriptionNotificationR4
Usage:       #example
Title:       "R4 Notification: Full Resource"
Description: "R4 Example of a topic-based subscription event notification with `full-resource` content."
* id        = "r4-notification-full-resource"
* timestamp = "2020-05-29T11:44:13.1882432-05:00"
* insert AddParameterStatus(2d5afc69-6ef2-420f-a8d1-8500c99eb96c, #active, #event-notification, 2)
* insert AddParameterStatusFirstEvent(2)
* insert AddParameterStatusEventFocus($notificationEncounter1)
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
* insert AddParameterStatus(7bd91d26-c951-4520-9ac6-67f41bfbe897, #active, #event-notification, 2)
* insert AddParameterStatusFirstEvent(2)
* insert AddParameterStatusEventFocus($notificationEncounter1)
* insert AddParameterStatusEventContext($notificationPatient)
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
* insert AddParameterStatus(7bd91d26-c951-4520-9ac6-67f41bfbe897, #error, #query-status, 3)
* insert AddParameterStatusError(http://terminology.hl7.org/CodeSystem/subscription-error, #no-response)
