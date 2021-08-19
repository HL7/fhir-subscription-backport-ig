Profile:     BackportSubscriptionNotification
Parent:      Bundle
Id:          backport-subscription-notification
Title:       "Backported R5 Subscription Notification Bundle"
Description: "Profile on the R4 Bundle resource to enable R5-style topic-based subscription notifications in FHIR R4."
* ^jurisdiction = http://unstats.un.org/unsd/methods/m49/m49.htm#001
* type = #history
* entry ^slicing.discriminator.type = #type
* entry ^slicing.discriminator.path = "resource"
* entry ^slicing.rules = #open
* entry ^slicing.ordered = false 
* entry ^slicing.description = "Slice based on resource"
* entry contains subscriptionStatus 1..1 MS
* entry[subscriptionStatus].resource 1..1 MS
* entry[subscriptionStatus].resource only SubscriptionStatus
// * entry.extension contains BackportNotificationFocusResource named focusResource 0..*
// * entry.extension[BackportNotificationFocusResource] MS SU
// * entry.extension contains BackportNotificationIncludedResource named includedResource 0..*
// * entry.extension[BackportNotificationIncludedResource] MS SU
* obeys backport-notification-bundle-1

Invariant:   backport-notification-bundle-1
Description: "A notification bundle MUST have a SubscriptionStatus as the first entry"
Expression:  "entry.first().resource.is(SubscriptionStatus)"
// Expression:  "(entry.first().resource.is(Parameters)) and (entry.first().resource.conformsTo(backport-subscription-status))"
Severity:    #error
XPath:       "f:entry[1]/f:resource/f:SubscriptionStatus"

// 2021.08.17 - removed for now - comparing to changes for SubscriptionStatus
// Extension:   BackportNotificationFocusResource
// Id:          subscription-notification-focus-resource
// Title:       "Subscription Notification Focus Resource"
// Description: "Tagging for Bundle entries to indicate a resource is the focus of a specific notification."
// * ^jurisdiction = http://unstats.un.org/unsd/methods/m49/m49.htm#001
// // * ^context[0].type = #element
// // * ^context[0].expression = "Bundle.entry"
// * value[x] only string

// 2021.08.17 - removed for now - comparing to changes for SubscriptionStatus
// Extension:   BackportNotificationIncludedResource
// Id:          subscription-notification-included-resource
// Title:       "Subscription Notification Included Resource"
// Description: "Tagging for Bundle entries to indicate a resource is included because of a specific notification."
// * ^jurisdiction = http://unstats.un.org/unsd/methods/m49/m49.htm#001
// // * ^context[0].type = #element
// // * ^context[0].expression = "Bundle.entry"
// * value[x] only string

CodeSystem:  BackportNotificationTypeCodeSystem
Id:          backport-notification-type-code-system
Title:       "R5 Subscription Notification Type Code System"
Description: "!!NOTE!! This has been added to R4B and will be removed when CI builds are available."
* ^jurisdiction = http://unstats.un.org/unsd/methods/m49/m49.htm#001
* #handshake          "Handshake"           "The notification is being sent as part of the setup or verification of a communications channel."
* #heartbeat          "Heartbeat"           "The notification is being sent because there has not been a notification generated over an extended period of time."
* #event-notification "Event Notification"  "The notification is being sent due to an event for the subscriber."
* #query-status       "Query Status"        "The notification is being sent due to a client request or query for Subscription status."
* #query-event        "Query Event"         "The notification is being sent due to a client request or query for Subscription events."

ValueSet:    BackportNotificationTypeValueSet
Id:          backport-notification-type-value-set
Title:       "R5 Subscription Notification Type Value Set"
Description: "!!NOTE!! This has been added to R4B and will be removed when CI builds are available."
* ^jurisdiction = http://unstats.un.org/unsd/methods/m49/m49.htm#001
* codes from system BackportNotificationTypeCodeSystem

CodeSystem:  BackportNotificationErrorCodeSystem
Id:          backport-notification-error-code-system
Title:       "R5 Subscription Error Code System"
Description: "!!NOTE!! This has been added to R4B and will be removed when CI builds are available."
* ^jurisdiction = http://unstats.un.org/unsd/methods/m49/m49.htm#001
* #unreachable          "Unreachable"       "The subscription endpoint is currently unreachable."
* #certificate-error    "Certificate Error" "The subscription endpoint has an invalid certificate."
* #timeout              "Timeout"           "An attempt to send a notification has timed out."
* #processing           "Processing Error"  "An error occurred while processing the event or notification."
* #unathorized          "Unauthorized"      "The server has determined the endpoint is not authorized to receive notifications."

ValueSet:    BackportNotificationErrorValueSet
Id:          backport-notification-error-value-set
Title:       "R5 Subscription Error Codes Value Set"
Description: "!!NOTE!! This has been added to R4B and will be removed when CI builds are available."
* ^jurisdiction = http://unstats.un.org/unsd/methods/m49/m49.htm#001
* codes from system BackportNotificationErrorCodeSystem


Instance:    BackportStatusHandshakeNotification
InstanceOf:  SubscriptionStatus
Usage:       #inline
* id = "b0bf7154-6967-4f32-b0b5-d994dff0e4d2"
* subscription.reference       = "https://example.org/fhir/r4/Subscription/admission"
* topic                        = "http://hl7.org/SubscriptionTopic/admission"
* status                       = #active
* type                         = #handshake
* eventsSinceSubscriptionStart = "0"
* eventsInNotification         = 0


Instance:    BackportStatusHeartbeatNotification
InstanceOf:  SubscriptionStatus
Usage:       #inline
* id = "2ec7c86b-421a-462d-a1a8-64bdb289c965"
* subscription.reference       = "https://example.org/fhir/r4/Subscription/admission"
* topic                        = "http://hl7.org/SubscriptionTopic/admission"
* status                       = #active
* type                         = #heartbeat
* eventsSinceSubscriptionStart = "2"
* eventsInNotification         = 0


Instance:    BackportStatusEventNotification
InstanceOf:  SubscriptionStatus
Usage:       #inline
* id = "b21e4fae-ce73-45cb-8e37-1e203362b2ae"
* subscription.reference       = "https://example.org/fhir/r4/Subscription/admission"
* topic                        = "http://hl7.org/SubscriptionTopic/admission"
* status                       = #active
* type                         = #event-notification
* eventsSinceSubscriptionStart = "2"
* eventsInNotification         = 1

Instance:    BackportStatusErrorNotification
InstanceOf:  SubscriptionStatus
Usage:       #inline
* id = "2efd9e8b-e894-4460-97f1-1d0c09daeb10"
* subscription.reference       = "https://example.org/fhir/r4/Subscription/admission"
* topic                        = "http://hl7.org/SubscriptionTopic/admission"
* status                       = #error
* type                         = #query-status
* eventsSinceSubscriptionStart = "10"
* error                        = BackportNotificationErrorCodeSystem#unreachable


Instance:    BackportNotificationStatusExample
InstanceOf:  SubscriptionStatus
Title:       "Backported Notification: Status"
Description: "Example of a backported notification with status content."
* id       = "notification-status"
* subscription.reference       = "https://example.org/fhir/r4/Subscription/admission"
* topic                        = "http://hl7.org/SubscriptionTopic/admission"
* status                       = #active
* type                         = #event-notification
* eventsSinceSubscriptionStart = "2"
* eventsInNotification         = 1


Instance:    BackportNotificationExampleHandshake
InstanceOf:  BackportSubscriptionNotification
Usage:       #example
Title:       "Backported Notification: Handshake"
Description: "Example of a backported notification of type: 'handshake'."
* id        = "notification-handshake"
* type      = #history
* timestamp = "2020-05-29T11:44:13.1882432-05:00"
* entry[subscriptionStatus].fullUrl  = "urn:uuid:b0bf7154-6967-4f32-b0b5-d994dff0e4d2"
* entry[subscriptionStatus].resource = BackportStatusHandshakeNotification
* entry[subscriptionStatus].request.method = #GET
* entry[subscriptionStatus].request.url = "https://example.org/fhir/r4/Subscription/admission/$status"
* entry[subscriptionStatus].response.status = "200"


Instance:    BackportNotificationExampleHeartbeat
InstanceOf:  BackportSubscriptionNotification
Usage:       #example
Title:       "Backported Notification: Heartbeat"
Description: "Example of a backported notification of type: 'heartbeat'."
* id        = "notification-heartbeat"
* type      = #history
* timestamp = "2020-05-29T11:44:13.1882432-05:00"
* entry[subscriptionStatus].fullUrl  = "urn:uuid:2ec7c86b-421a-462d-a1a8-64bdb289c965"
* entry[subscriptionStatus].resource = BackportStatusHeartbeatNotification
* entry[subscriptionStatus].request.method = #GET
* entry[subscriptionStatus].request.url = "https://example.org/fhir/r4/Subscription/admission/$status"
* entry[subscriptionStatus].response.status = "200"


Instance:    BackportNotificationExampleEmpty
InstanceOf:  BackportSubscriptionNotification
Usage:       #example
Title:       "Backported Notification: Empty"
Description: "Example of a backported notification with 'empty' content."
* id        = "notification-empty"
* type      = #history
* timestamp = "2020-05-29T11:44:13.1882432-05:00"
* entry[subscriptionStatus].fullUrl  = "urn:uuid:b21e4fae-ce73-45cb-8e37-1e203362b2ae"
* entry[subscriptionStatus].resource = BackportStatusEventNotification
* entry[subscriptionStatus].request.method = #GET
* entry[subscriptionStatus].request.url = "https://example.org/fhir/r4/Subscription/admission/$status"
* entry[subscriptionStatus].response.status = "200"


Instance:    BackportNotificationExampleIdOnly
InstanceOf:  BackportSubscriptionNotification
Usage:       #example
Title:       "Backported Notification: Id Only"
Description: "Example of a backported notification with 'id-only' content."
* id        = "notification-id-only"
* type      = #history
* timestamp = "2020-05-29T11:44:13.1882432-05:00"
* entry[subscriptionStatus].fullUrl  = "urn:uuid:b21e4fae-ce73-45cb-8e37-1e203362b2ae"
* entry[subscriptionStatus].resource = BackportStatusEventNotification
* entry[subscriptionStatus].request.method = #GET
* entry[subscriptionStatus].request.url = "https://example.org/fhir/r4/Subscription/admission/$status"
* entry[subscriptionStatus].response.status = "200"
* entry[subscriptionStatus].resource.notificationEvent[+].eventNumber = "2"
* entry[subscriptionStatus].resource.notificationEvent[=].timestamp   = "2020-05-29T11:44:13.1882432-05:00"
* entry[subscriptionStatus].resource.notificationEvent[=].focus.reference = "https://example.org/fhir/r4/Encounter/551683b3-1477-41d1-b58e-32fe8b0047b0"
* entry[1].fullUrl = "https://example.org/fhir/r4/Encounter/551683b3-1477-41d1-b58e-32fe8b0047b0"
* entry[1].request.method = #POST
* entry[1].request.url    = "Encounter"
* entry[1].response.status = "201"

Instance:    BackportNotificationPatient
InstanceOf:  Patient
Usage:       #inline
* id               = "46db3334-dbf5-43f3-868f-93ae0883cce1"
* active           = true
* name[+].use      = #usual
* name[=].text     = "Example Patient"
* name[=].family   = "Patient"
* name[=].given[0] = "Example"

Instance:    BackportNotificationEncounter
InstanceOf:  Encounter
Usage:       #inline
* id       = "551683b3-1477-41d1-b58e-32fe8b0047b0"
* status   = #in-progress
* class    = http://terminology.hl7.org/CodeSystem/v3-ActCode#VR
* subject.reference = "https://example.org/fhir/r4/Patient/46db3334-dbf5-43f3-868f-93ae0883cce1"
* subject.display   = "Example Patient"

Instance:    BackportNotificationExampleFullResource
InstanceOf:  BackportSubscriptionNotification
Usage:       #example
Title:       "Backported Notification: Full Resource"
Description: "Example of a backported notification with 'full-resource' content."
* id        = "notification-full-resource"
* type      = #history
* timestamp = "2020-05-29T11:44:13.1882432-05:00"
* entry[subscriptionStatus].fullUrl  = "urn:uuid:b21e4fae-ce73-45cb-8e37-1e203362b2ae"
* entry[subscriptionStatus].resource = BackportStatusEventNotification
* entry[subscriptionStatus].request.method = #GET
* entry[subscriptionStatus].request.url = "https://example.org/fhir/r4/Subscription/admission/$status"
* entry[subscriptionStatus].response.status = "200"
* entry[subscriptionStatus].resource.notificationEvent[+].eventNumber = "2"
* entry[subscriptionStatus].resource.notificationEvent[=].timestamp   = "2020-05-29T11:44:13.1882432-05:00"
* entry[subscriptionStatus].resource.notificationEvent[=].focus.reference  = "https://example.org/fhir/r4/Encounter/551683b3-1477-41d1-b58e-32fe8b0047b0"
// * entry[1].extension[focusResource].valueString = "310"
* entry[1].fullUrl  = "https://example.org/fhir/r4/Encounter/551683b3-1477-41d1-b58e-32fe8b0047b0"
* entry[1].resource = BackportNotificationEncounter
* entry[1].request.method = #POST
* entry[1].request.url    = "Encounter"
* entry[1].response.status = "201"

Instance:    BackportNotificationExampleMultiResource
InstanceOf:  BackportSubscriptionNotification
Usage:       #example
Title:       "Backported Notification: Multiple Resources"
Description: "Example of a backported notification with 'full-resource' content and a related resource."
* id        = "notification-multi-resource"
* type      = #history
* timestamp = "2020-05-29T11:44:13.1882432-05:00"
* entry[subscriptionStatus].fullUrl  = "urn:uuid:babce097-c165-4b54-b7d1-0301b8a095d3"
* entry[subscriptionStatus].resource = BackportStatusEventNotification
* entry[subscriptionStatus].request.method = #GET
* entry[subscriptionStatus].request.url = "https://example.org/fhir/r4/Subscription/admission/$status"
* entry[subscriptionStatus].response.status = "200"
* entry[subscriptionStatus].resource.notificationEvent[+].eventNumber = "2"
* entry[subscriptionStatus].resource.notificationEvent[=].timestamp   = "2020-05-29T11:44:13.1882432-05:00"
* entry[subscriptionStatus].resource.notificationEvent[=].focus.reference = "https://example.org/fhir/r4/Encounter/551683b3-1477-41d1-b58e-32fe8b0047b0"
* entry[subscriptionStatus].resource.notificationEvent[=].additionalContext[+].reference = "https://example.org/fhir/r4/Patient/46db3334-dbf5-43f3-868f-93ae0883cce1"
// * entry[1].extension[focusResource].valueString = "310"
* entry[1].fullUrl  = "https://example.org/fhir/r4/Encounter/551683b3-1477-41d1-b58e-32fe8b0047b0"
* entry[1].resource = BackportNotificationEncounter
* entry[1].request.method = #POST
* entry[1].request.url    = "Encounter"
* entry[1].response.status = "201"
// * entry[2].extension[includedResource].valueString = "310"
* entry[2].fullUrl  = "https://example.org/fhir/r4/Patient/46db3334-dbf5-43f3-868f-93ae0883cce1"
* entry[2].resource = BackportNotificationPatient
* entry[2].request.method = #GET
* entry[2].request.url    = "Patient/46db3334-dbf5-43f3-868f-93ae0883cce1"
* entry[2].response.status = "200"


Instance:    BackportNotificationExampleError
InstanceOf:  BackportSubscriptionNotification
Usage:       #example
Title:       "Backported Notification: Error"
Description: "Example of a backported notification with an error state."
* id         = "notification-error"
* type       = #history
* timestamp = "2020-05-29T11:44:13.1882432-05:00"
* entry[subscriptionStatus].fullUrl  = "urn:uuid:2efd9e8b-e894-4460-97f1-1d0c09daeb10"
* entry[subscriptionStatus].resource = BackportStatusErrorNotification
* entry[subscriptionStatus].request.method = #GET
* entry[subscriptionStatus].request.url = "https://example.org/fhir/r4/Subscription/admission/$status"
* entry[subscriptionStatus].response.status = "200"
