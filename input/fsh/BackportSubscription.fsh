Profile:     BackportSubscription
Parent:      Subscription
Id:          backport-subscription
Title:       "Backported R5 Subscription"
Description: "Profile on the R4 Subscription resource to enable R5-style topic-based subscriptions in FHIR R4."
* ^jurisdiction = http://unstats.un.org/unsd/methods/m49/m49.htm#001
* extension contains BackportTopicCanonical named subscriptionTopic 1..1
* extension[BackportTopicCanonical] SU MS
* criteria.extension contains BackportAdditionalCriteria named additionalCriteria 0..*
* channel.payload 1..1
* channel.payload.extension contains BackportPayloadContent named content 1..1
* channel.payload.extension[BackportPayloadContent] MS SU
* channel.extension contains BackportHeartbeatPeriod named heartbeatPeriod 0..1
* channel.extension contains BackportTimeout named timeout 0..1
* channel.extension contains BackportNotificationUrlLocation named notificationUrlLocation 0..1
* channel.extension contains BackportMaxCount named maxCount 0..1

Extension:   BackportTopicCanonical
Id:          backport-topic-canonical
Title:       "Backport R5 Subscription Topic Canonical"
Description: "Canonical reference to the subscription topic being subscribed to."
* ^jurisdiction = http://unstats.un.org/unsd/methods/m49/m49.htm#001
* value[x] only uri
* valueUri 1..1 MS

Extension:   BackportAdditionalCriteria
Id:          backport-additional-criteria
Title:       "Backported R5 Additional Criteria"
Description: "Criteria for additional resource types."
* ^jurisdiction = http://unstats.un.org/unsd/methods/m49/m49.htm#001
* value[x] only string

CodeSystem:  BackportContentCodeSystem
Id:          backport-content-code-system
Title:       "Backported R5 Subscription Content Code System"
Description: "Codes to represent how much resource content to send in the notification payload."
* ^jurisdiction = http://unstats.un.org/unsd/methods/m49/m49.htm#001
* #empty         "Empty"         "No resource content is transacted in the notification payload."
* #id-only       "Id Only"       "Only the resource id is transacted in the notification payload."
* #full-resource "Full Resource" "The entire resource is transacted in the notification payload."

ValueSet:    BackportContentValueSet
Id:          backport-content-value-set
Title:       "Backported R5 Subscription Content Value Set"
Description: "Codes to represent how much resource content to send in the notification payload."
* ^jurisdiction = http://unstats.un.org/unsd/methods/m49/m49.htm#001
* codes from system BackportContentCodeSystem

Extension:   BackportPayloadContent
Id:          backport-payload-content
Title:       "Backport R5 Subscription Payload Content Information"
Description: "How much of the resource content to deliver in the notification payload. The choices are an empty payload, only the resource id, or the full resource content."
* ^jurisdiction = http://unstats.un.org/unsd/methods/m49/m49.htm#001
* value[x] only code
* valueCode from BackportContentValueSet

Extension:   BackportHeartbeatPeriod
Id:          backport-heartbeat-period
Title:       "Backport R5 Subscription Heartbeat Period"
Description: "Interval in seconds to send 'heartbeat' notifications."
* ^jurisdiction = http://unstats.un.org/unsd/methods/m49/m49.htm#001
* value[x] only unsignedInt

Extension:   BackportTimeout
Id:          backport-timeout
Title:       "Backport R5 Subscription Timeout"
Description: "Timeout in seconds to attempt notification delivery."
* ^jurisdiction = http://unstats.un.org/unsd/methods/m49/m49.htm#001
* value[x] only unsignedInt

CodeSystem:  BackportNotificationUrlLocationCodeSystem
Id:          backport-notification-url-location-code-system
Title:       "Backported R5 Subscription Notification URL Location Code System"
Description: "Codes to represent the location in Bundle.entry where URLs for resources should be located."
* ^jurisdiction = http://unstats.un.org/unsd/methods/m49/m49.htm#001
* #none              "none"              "URLs should NOT be included in notifications."
* #full-url          "full-url"          "URLs should be placed in Bundle.entry.fullUrl."
* #request-response  "request-response"  "URLs should be placed in Bundle.entry.request and/or Bundle.entry.response."
* #all               "all"               "URLs should be placed in all available locations." 

ValueSet:    BackportNotificationUrlLocationValueSet
Id:          backport-notification-url-location-value-set
Title:       "Backported R5 Subscription Notification URL Location Value Set"
Description: "Codes to represent the location in Bundle.entry where URLs for resources should be located."
* ^jurisdiction = http://unstats.un.org/unsd/methods/m49/m49.htm#001
* codes from system BackportNotificationUrlLocationCodeSystem

Extension:   BackportNotificationUrlLocation
Id:          backport-notification-url-location
Title:       "Backport R5 Subscription Notification URL Location"
Description: "If present, where to place URLs of resources in notifications."
* ^jurisdiction = http://unstats.un.org/unsd/methods/m49/m49.htm#001
* value[x] only code
* valueCode from BackportNotificationUrlLocationValueSet

Extension:   BackportMaxCount
Id:          backport-max-count
Title:       "Backported R5 Subscription MaxCount"
Description: "Maximum number of triggering resources included in notification bundles."
* ^jurisdiction = http://unstats.un.org/unsd/methods/m49/m49.htm#001
* value[x] only positiveInt

Instance:    BackportSubscriptionExampleAdmission
InstanceOf:  BackportSubscription
Usage:       #example
Title:       "Backported Subscription: Admission"
Description: "Example of a backported R5 admissions subscription in R4."
* id       = "admission"
* extension[subscriptionTopic].valueUri                = "http://hl7.org/SubscriptionTopic/admission"
* status   = #active
* end      = "2020-12-31T12:00:00Z"
* reason   = "Example Backported Subscription for Patient Admission"
* criteria = "Encounter?patient=Patient/123"
* channel.type                                         = #rest-hook
* channel.endpoint                                     = "https://example.org/Endpoints/eae3806a-f7fb-4e3f-a14d-c4c58ca9c038"
* channel.extension[heartbeatPeriod].valueUnsignedInt  = 86400
* channel.extension[timeout].valueUnsignedInt          = 60
* channel.extension[notificationUrlLocation].valueCode = #all
* channel.extension[maxCount].valuePositiveInt         = 20
* channel.payload                                      = #application/fhir+json
* channel.payload.extension[content].valueCode         = #id-only
* channel.header[0]                                    = "Authorization: Bearer secret-token-abc-123"

Instance:    BackportSubscriptionExampleMultiResource
InstanceOf:  BackportSubscription
Usage:       #example
Title:       "Backported Subscription: Multi-Resource"
Description: "Example of a backported R5 subscription in R4 with multiple resources."
* id       = "multiResource"
* extension[subscriptionTopic].valueUri                = "http://example.org/fhir/SubscriptionTopic/PatientEncounterObservation"
* status   = #active
* end      = "2020-12-31T12:00:00Z"
* reason   = "Example Backported Subscription for Multiple Resources"
* criteria = "Patient?id=Patient/123"
* criteria.extension[additionalCriteria].valueString   = "Encounter?patient=Patient/123"
* criteria.extension[additionalCriteria].valueString   = "Observation?subject=Patient/123"
* channel.type                                         = #rest-hook
* channel.endpoint                                     = "https://example.org/Endpoints/d7dcc004-808d-452b-8030-3a3a13cd871d"
* channel.extension[heartbeatPeriod].valueUnsignedInt  = 86400
* channel.extension[timeout].valueUnsignedInt          = 60
* channel.extension[notificationUrlLocation].valueCode = #all
* channel.extension[maxCount].valuePositiveInt         = 20
* channel.payload                                      = #application/fhir+json
* channel.payload.extension[content].valueCode         = #id-only
* channel.header[0]                                    = "Authorization: Bearer secret-token-abc-123"