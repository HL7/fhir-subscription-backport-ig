Profile:     BackportSubscription
Parent:      Subscription
Id:          backport-subscription
Title:       "Backported R5 Subscription"
Description: "Profile on the R4 Subscription resource to enable R5-style topic-based subscriptions in FHIR R4."
* ^jurisdiction = http://unstats.un.org/unsd/methods/m49/m49.htm#001
* criteria 1..1
* criteria.extension 0..*
* criteria.extension contains BackportFilterCriteria named filterCriteria 0..*
* criteria.extension[BackportFilterCriteria] MS SU
* channel.payload 1..1
* channel.payload.extension contains BackportPayloadContent named content 1..1
* channel.payload.extension[BackportPayloadContent] MS SU
* channel.extension contains BackportHeartbeatPeriod named heartbeatPeriod 0..1
* channel.extension contains BackportTimeout named timeout 0..1
* channel.extension contains BackportMaxCount named maxCount 0..1

Extension:   BackportFilterCriteria
Id:          backport-filter-criteria
Title:       "Backported R5 FilterBy Criteria"
Description: "Criteria for topic-based filtering (filter-by)."
* ^jurisdiction = http://unstats.un.org/unsd/methods/m49/m49.htm#001
* ^context[0].type = #element
* ^context[0].expression = "Subscription.criteria"
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
* ^context[0].type = #element
* ^context[0].expression = "Subscription.channel.payload"
* value[x] only code
* valueCode from BackportContentValueSet

Extension:   BackportHeartbeatPeriod
Id:          backport-heartbeat-period
Title:       "Backport R5 Subscription Heartbeat Period"
Description: "Interval in seconds to send 'heartbeat' notifications."
* ^jurisdiction = http://unstats.un.org/unsd/methods/m49/m49.htm#001
* ^context[0].type = #element
* ^context[0].expression = "Subscription.channel"
* value[x] only unsignedInt

Extension:   BackportTimeout
Id:          backport-timeout
Title:       "Backport R5 Subscription Timeout"
Description: "Timeout in seconds to attempt notification delivery."
* ^jurisdiction = http://unstats.un.org/unsd/methods/m49/m49.htm#001
* ^context[0].type = #element
* ^context[0].expression = "Subscription.channel"
* value[x] only unsignedInt

Extension:   BackportMaxCount
Id:          backport-max-count
Title:       "Backported R5 Subscription MaxCount"
Description: "Maximum number of triggering resources included in notification bundles."
* ^jurisdiction = http://unstats.un.org/unsd/methods/m49/m49.htm#001
* ^context[0].type = #element
* ^context[0].expression = "Subscription.channel"
* value[x] only positiveInt

Instance:    BackportSubscriptionExampleAdmission
InstanceOf:  BackportSubscription
Usage:       #example
Title:       "Backported Subscription: Admission"
Description: "Example of a backported R5 admissions subscription in R4."
* id       = "subscription-admission"
* status   = #active
* end      = "2020-12-31T12:00:00Z"
* reason   = "Example Backported Subscription for Patient Admission"
* criteria = "http://hl7.org/SubscriptionTopic/admission"
* criteria.extension[filterCriteria].valueString       = "Encounter?patient=Patient/123"
* channel.type                                         = #rest-hook
* channel.endpoint                                     = "https://example.org/Endpoints/eae3806a-f7fb-4e3f-a14d-c4c58ca9c038"
* channel.extension[heartbeatPeriod].valueUnsignedInt  = 86400
* channel.extension[timeout].valueUnsignedInt          = 60
* channel.extension[maxCount].valuePositiveInt         = 20
* channel.payload                                      = #application/fhir+json
* channel.payload.extension[content].valueCode         = #id-only
* channel.header[0]                                    = "Authorization: Bearer secret-token-abc-123"

Instance:    BackportSubscriptionExampleMultiResource
InstanceOf:  BackportSubscription
Usage:       #example
Title:       "Backported Subscription: Multi-Resource"
Description: "Example of a backported R5 subscription in R4 with multiple resources."
* id       = "subscription-multi-resource"
* status   = #active
* end      = "2020-12-31T12:00:00Z"
* reason   = "Example Backported Subscription for Multiple Resources"
* criteria = "http://hl7.org/SubscriptionTopic/admission"
* criteria.extension[filterCriteria].valueString       = "Patient?id=Patient/123"
* criteria.extension[filterCriteria].valueString       = "Encounter?patient=Patient/123"
* criteria.extension[filterCriteria].valueString       = "Observation?subject=Patient/123"
* channel.type                                         = #rest-hook
* channel.endpoint                                     = "https://example.org/Endpoints/d7dcc004-808d-452b-8030-3a3a13cd871d"
* channel.extension[heartbeatPeriod].valueUnsignedInt  = 86400
* channel.extension[timeout].valueUnsignedInt          = 60
* channel.extension[maxCount].valuePositiveInt         = 20
* channel.payload                                      = #application/fhir+json
* channel.payload.extension[content].valueCode         = #id-only
* channel.header[0]                                    = "Authorization: Bearer secret-token-abc-123"