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
* entry[subscriptionStatus].resource only BackportSubscriptionStatus
* obeys backport-notification-bundle-1

Invariant:   backport-notification-bundle-1
Description: "A notification bundle MUST have the BackportSubscriptionStatus as the first entry"
Expression:  "entry.first().resource.is(Parameters)"
// Expression:  "(entry.first().resource.is(Parameters)) and (entry.first().resource.conformsTo(backport-subscription-status))"
Severity:    #error
XPath:       "f:entry[1]/f:resource/f:Parameters"

Profile:     BackportSubscriptionStatus
Parent:      Parameters
Id:          backport-subscriptionstatus
Title:       "Backported R5 Subscription Notification Status"
Description: "Profile on the Parameters resource to enable R5-style topic-based subscription notifications in FHIR R4."
* ^jurisdiction = http://unstats.un.org/unsd/methods/m49/m49.htm#001
* parameter  ^slicing.discriminator.type = #value
* parameter  ^slicing.discriminator.path = "name"
* parameter  ^slicing.rules = #open
* parameter  ^slicing.ordered = false
* parameter  ^slicing.description = "Slice on parameter name"
* parameter 
    contains subscription 1..1 MS
    and topic 1..1 MS
    and status 0..1 MS
    and type 1..1 MS
    and eventsSinceSubscriptionStart 0..1 MS
    and eventsInNotification 0..1 MS
    and error 0..1 MS
* parameter[subscription].name = "subscription" (exactly)
* parameter[subscription].value[x] 1..1 MS
* parameter[subscription].value[x] only Reference(Subscription)
* parameter[topic].name = "topic" (exactly)
* parameter[topic].value[x] 0..1 MS
* parameter[topic].value[x] only canonical
* parameter[status].name = "status" (exactly)
* parameter[status].value[x] 1..1 MS
* parameter[status].value[x] only code
* parameter[status].value[x] from http://hl7.org/fhir/ValueSet/subscription-status
* parameter[type].name = "type" (exactly)
* parameter[type].value[x] 1..1 MS
* parameter[type].value[x] only code
* parameter[type].value[x] from BackportNotificationTypeValueSet
* parameter[eventsSinceSubscriptionStart].name = "events-since-subscription-start" (exactly)
* parameter[eventsSinceSubscriptionStart].value[x] 1..1 MS
* parameter[eventsSinceSubscriptionStart].value[x] only unsignedInt
* parameter[eventsInNotification].name = "events-in-notification" (exactly)
* parameter[eventsInNotification].value[x] 0..1 MS
* parameter[eventsInNotification].value[x] only unsignedInt
* parameter[error].name = "error" (exactly)
* parameter[error].value[x] 1..1 MS
* parameter[error].value[x] only CodeableConcept

CodeSystem:  BackportNotificationTypeCodeSystem
Id:          backport-notification-type-code-system
Title:       "R5 Subscription Notification Type Code System"
Description: "Codes to represent types of notification bundles."
* ^jurisdiction = http://unstats.un.org/unsd/methods/m49/m49.htm#001
* #handshake          "Handshake"           "The notification is being sent as part of the setup or verification of a communications channel."
* #heartbeat          "Heartbeat"           "The notification is being sent because there has not been a notification generated over an extended period of time."
* #event-notification "Event Notification"  "The notification is being sent due to an event for the subscriber."
* #query-status       "Query Status"        "The notification is being sent due to a client request or query for Subscription status."

ValueSet:    BackportNotificationTypeValueSet
Id:          backport-notification-type-value-set
Title:       "R5 Subscription Notification Type Value Set"
Description: "Codes to represent types of notification bundles."
* ^jurisdiction = http://unstats.un.org/unsd/methods/m49/m49.htm#001
* codes from system BackportNotificationTypeCodeSystem


CodeSystem:  BackportNotificationErrorCodeSystem
Id:          backport-notification-error-code-system
Title:       "R5 Subscription Error Code System"
Description: "Codes to represent error states on subscriptions."
* ^jurisdiction = http://unstats.un.org/unsd/methods/m49/m49.htm#001
* #unreachable          "Unreachable"       "The subscription endpoint is currently unreachable."
* #certificate-error    "Certificate Error" "The subscription endpoint has an invalid certificate."
* #timeout              "Timeout"           "An attempt to send a notification has timed out."
* #processing           "Processing Error"  "An error occurred while processing the event or notification."
* #unathorized          "Unauthorized"      "The server has determined the endpoint is not authorized to receive notifications."

ValueSet:    BackportNotificationErrorValueSet
Id:          backport-notification-error-value-set
Title:       "R5 Subscription Error Codes Value Set"
Description: "Codes to represent error states on subscriptions."
* ^jurisdiction = http://unstats.un.org/unsd/methods/m49/m49.htm#001
* codes from system BackportNotificationErrorCodeSystem


Instance:    BackportStatusEventNotification
InstanceOf:  BackportSubscriptionStatus
Usage:       #inline
* id = "b21e4fae-ce73-45cb-8e37-1e203362b2ae"
* parameter[subscription].valueReference.reference         = "https://example.org/fhir/r4/Subscription/admission"
* parameter[topic].valueCanonical                          = "http://hl7.org/SubscriptionTopic/admission"
* parameter[status].valueCode                              = #active
* parameter[type].valueCode                                = #event-notification
* parameter[eventsSinceSubscriptionStart].valueUnsignedInt = 310
* parameter[eventsInNotification].valueUnsignedInt         = 1


Instance:    BackportStatusErrorNotification
InstanceOf:  BackportSubscriptionStatus
Usage:       #inline
* id = "2efd9e8b-e894-4460-97f1-1d0c09daeb10"
* parameter[subscription].valueReference.reference         = "https://example.org/fhir/r4/Subscription/admission"
* parameter[topic].valueCanonical                          = "http://hl7.org/SubscriptionTopic/admission"
* parameter[status].valueCode                              = #error
* parameter[type].valueCode                                = #query-status
* parameter[eventsSinceSubscriptionStart].valueUnsignedInt = 315
* parameter[error].valueCodeableConcept                    = BackportNotificationErrorCodeSystem#unreachable


Instance:    BackportNotificationStatusExample
InstanceOf:  BackportSubscriptionStatus
Title:       "Backported Notification: Status"
Description: "Example of a backported notification with status content."
* id       = "notification-status"
* parameter[subscription].valueReference.reference         = "https://example.org/fhir/r4/Subscription/admission"
* parameter[topic].valueCanonical                          = "http://hl7.org/SubscriptionTopic/admission"
* parameter[status].valueCode                              = #active
* parameter[type].valueCode                                = #event-notification
* parameter[eventsSinceSubscriptionStart].valueUnsignedInt = 310
* parameter[eventsInNotification].valueUnsignedInt         = 1


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
* entry[1].fullUrl = "https://example.org/fhir/r4/Encounter/551683b3-1477-41d1-b58e-32fe8b0047b0"
* entry[1].request.method = #POST
* entry[1].request.url    = "Encounter"
* entry[1].response.status = "201"

Instance:    BackportNotificationPatient
InstanceOf:  Patient
Usage:       #inline
* id               = "46db3334-dbf5-43f3-868f-93ae0883cce1"
* active           = true
* name[0].use      = #usual
* name[0].text     = "Example Patient"
* name[0].family   = "Patient"
* name[0].given[0] = "Example"

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
* entry[1].fullUrl  = "https://example.org/fhir/r4/Encounter/551683b3-1477-41d1-b58e-32fe8b0047b0"
* entry[1].resource = BackportNotificationEncounter
* entry[1].request.method = #POST
* entry[1].request.url    = "Encounter"
* entry[1].response.status = "201"
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
