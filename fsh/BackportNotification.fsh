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
Id:          backport-subscription-status
Title:       "Backported R5 Subscription Notification Status"
Description: "Profile on the Parameters resource to enable R5-style topic-based subscription notifications in FHIR R4."
* ^jurisdiction = http://unstats.un.org/unsd/methods/m49/m49.htm#001
* parameter  ^slicing.discriminator.type = #value
* parameter  ^slicing.discriminator.path = "name"
* parameter  ^slicing.rules = #open
* parameter  ^slicing.ordered = false
* parameter  ^slicing.description = "Slice on parameter name"
* parameter 
    contains subscriptionUrl 1..1 MS
    and subscriptionTopicUrl 0..1 MS
    and status 1..1 MS
    and type 1..1 MS
    and subscriptionEventCount 1..1 MS
    and bundleEventCount 1..1 MS
* parameter[subscriptionUrl].name = "subscription-url" (exactly)
* parameter[subscriptionUrl].value[x] 1..1 MS
* parameter[subscriptionUrl].value[x] only uri
* parameter[subscriptionTopicUrl].name = "subscription-topic-url" (exactly)
* parameter[subscriptionTopicUrl].value[x] 0..1 MS
* parameter[subscriptionTopicUrl].value[x] only uri
* parameter[status].name = "status" (exactly)
* parameter[status].value[x] 1..1 MS
* parameter[status].value[x] only code
* parameter[status].value[x] from http://hl7.org/fhir/ValueSet/subscription-status
* parameter[type].name = "type" (exactly)
* parameter[type].value[x] 1..1 MS
* parameter[type].value[x] only code
* parameter[type].value[x] from BackportNotificationTypeValueSet
* parameter[subscriptionEventCount].name = "subscription-event-count" (exactly)
* parameter[subscriptionEventCount].value[x] 1..1 MS
* parameter[subscriptionEventCount].value[x] only unsignedInt
* parameter[bundleEventCount].name = "bundle-event-count" (exactly)
* parameter[bundleEventCount].value[x] 0..1 MS
* parameter[bundleEventCount].value[x] only unsignedInt

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


Instance:    BackportStatusEventNotification
InstanceOf:  BackportSubscriptionStatus
Usage:       #inline
* id = "b21e4fae-ce73-45cb-8e37-1e203362b2ae"
* parameter[subscriptionUrl].valueUri                = "https://example.org/fhir/r4/Subscription/admission"
* parameter[subscriptionTopicUrl].valueUri           = "http://hl7.org/SubscriptionTopic/admission"
* parameter[status].valueCode                        = #active
* parameter[type].valueCode                          = #event-notification
* parameter[subscriptionEventCount].valueUnsignedInt = 310
* parameter[bundleEventCount].valueUnsignedInt       = 1


Instance:    BackportNotificationStatusExample
InstanceOf:  BackportSubscriptionStatus
Description: "Example Backported R5 Notification Status."
* parameter[subscriptionUrl].valueUri                = "https://example.org/fhir/r4/Subscription/admission"
* parameter[subscriptionTopicUrl].valueUri           = "http://hl7.org/SubscriptionTopic/admission"
* parameter[status].valueCode                        = #active
* parameter[type].valueCode                          = #event-notification
* parameter[subscriptionEventCount].valueUnsignedInt = 310
* parameter[bundleEventCount].valueUnsignedInt       = 1


Instance:    BackportNotificationExampleEmpty
InstanceOf:  BackportSubscriptionNotification
Usage:       #example
Title:       "Backported Notification: Empty"
Description: "Example of a backported notification with 'empty' content."
* id        = "9601c07a-e34f-4945-93ca-6efb5394c995"
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
* id        = "3945182f-d315-4dbf-9259-09d863c7e7da"
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


// Extension:   BackportNotificationType
// Id:          backport-notification-type
// Title:       "R5 Subscription Notification Type"
// Description: "The type of event being conveyed with this notificaiton."
// * value[x] only code
// * valueCode from BackportNotificationTypeValueSet

// Extension:   BackportSubscriptionEventCount
// Id:          backport-subscription-event-count
// Title:       "R5 Subscription Event Count"
// Description: "Indicates the number of unique events that have triggered notification attempts on this Subscription inclusive of the current notification being sent."
// * value[x] only unsignedInt

// Extension:   BackportBundleEventCount
// Id:          backport-bundle-event-count
// Title:       "R5 Subscription Bundle Event Count"
// Description: "Represents the number of event notifications conveyed by this Bundle."
// * value[x] only unsignedInt

// Extension:   BackportSubscriptionTopicUrl
// Id:          backport-subscription-topic-url
// Title:       "R5 Canonical SubscriptionTopic"
// Description: "The Canonical SubscriptionTopic resource relevant to this notification (e.g., the topic the triggering subscription relates to)."
// * value[x] only uri

// Extension:   BackportSubscriptionUrl
// Id:          backport-subscription-url
// Title:       "R5 Subscription Absolute URL"
// Description: "The Subscription resource that triggered this notification, as an absolute URL for the Subscription resource on the server that generated the notification."
// * value[x] only uri
