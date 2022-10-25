Profile:     BackportSubscription
Parent:      Subscription
Id:          backport-subscription
Title:       "Backported R5 Subscription"
Description: "Profile on the R4 Subscription resource to enable R5-style topic-based subscriptions in FHIR R4 or R4B."
* insert StructureJurisdiction
* criteria 1..1 MS
* criteria.extension 0..*
* criteria.extension contains BackportFilterCriteria named filterCriteria 0..*
* criteria.extension[BackportFilterCriteria] MS SU
* channel.payload 1..1
* channel.payload.extension contains BackportPayloadContent named content 1..1
* channel.payload.extension[BackportPayloadContent] MS SU
* channel.extension contains BackportHeartbeatPeriod named heartbeatPeriod 0..1
* channel.extension contains BackportTimeout named timeout 0..1
* channel.extension contains BackportMaxCount named maxCount 0..1
* channel.type.extension contains BackportChannelType named customChannelType 0..1
* channel.type.extension[BackportChannelType] MS SU

Extension:   BackportChannelType
Id:          backport-channel-type
Title:       "Backported R5 Additional Channel Types"
Description: "Additional channel types not defined before FHIR R5."
* insert StructureJurisdiction
* ^context[0].type = #element
* ^context[0].expression = "Subscription.channel.type"
* value[x] only Coding

Extension:   BackportFilterCriteria
Id:          backport-filter-criteria
Title:       "Backported R5 FilterBy Criteria"
Description: "Criteria for topic-based filtering (filter-by)."
* insert StructureJurisdiction
* ^context[0].type = #element
* ^context[0].expression = "Subscription.criteria"
* value[x] only string

CodeSystem:  BackportContentCodeSystem
Id:          backport-content-code-system
Title:       "Backported R5 Subscription Content Code System"
Description: "Codes to represent how much resource content to send in the notification payload."
* insert StructureJurisdiction
* ^caseSensitive = true
* #empty         "Empty"         "No resource content is transacted in the notification payload."
* #id-only       "Id Only"       "Only the resource id is transacted in the notification payload."
* #full-resource "Full Resource" "The entire resource is transacted in the notification payload."

ValueSet:    BackportContentValueSet
Id:          backport-content-value-set
Title:       "Backported R5 Subscription Content Value Set"
Description: "Codes to represent how much resource content to send in the notification payload."
* insert StructureJurisdiction
* codes from system BackportContentCodeSystem

Extension:   BackportPayloadContent
Id:          backport-payload-content
Title:       "Backport R5 Subscription Payload Content Information"
Description: "How much of the resource content to deliver in the notification payload. The choices are an empty payload, only the resource id, or the full resource content."
* insert StructureJurisdiction
* ^context[0].type = #element
* ^context[0].expression = "Subscription.channel.payload"
* value[x] only code
* valueCode from BackportContentValueSet

Extension:   BackportHeartbeatPeriod
Id:          backport-heartbeat-period
Title:       "Backport R5 Subscription Heartbeat Period"
Description: "Interval in seconds to send 'heartbeat' notifications."
* insert StructureJurisdiction
* ^context[0].type = #element
* ^context[0].expression = "Subscription.channel"
* value[x] only unsignedInt

Extension:   BackportTimeout
Id:          backport-timeout
Title:       "Backport R5 Subscription Timeout"
Description: "Timeout in seconds to attempt notification delivery."
* insert StructureJurisdiction
* ^context[0].type = #element
* ^context[0].expression = "Subscription.channel"
* value[x] only unsignedInt

Extension:   BackportMaxCount
Id:          backport-max-count
Title:       "Backported R5 Subscription MaxCount"
Description: "Maximum number of triggering resources included in notification bundles."
* insert StructureJurisdiction
* ^context[0].type = #element
* ^context[0].expression = "Subscription.channel"
* value[x] only positiveInt

Instance:    BackportSubscriptionExampleAdmission
InstanceOf:  BackportSubscription
Usage:       #example
Title:       "Backported Subscription: Admission"
Description: "Example of a backported R5 admissions subscription."
* id       = "subscription-admission"
* status   = #active
* end      = "2020-12-31T12:00:00Z"
* reason   = "Example Backported Subscription for Patient Admission"
* criteria = $admissionTopic
* criteria.extension[filterCriteria].valueString       = "Encounter?patient=Patient/123"
* channel.type                                         = #rest-hook
* channel.endpoint                                     = $webHookEndpoint
* channel.extension[heartbeatPeriod].valueUnsignedInt  = 86400
* channel.extension[timeout].valueUnsignedInt          = 60
* channel.extension[maxCount].valuePositiveInt         = 20
* channel.payload                                      = #application/fhir+json
* channel.payload.extension[content].valueCode         = #id-only

Instance:    BackportSubscriptionExampleMultiResource
InstanceOf:  BackportSubscription
Usage:       #example
Title:       "Backported Subscription: Multi-Resource"
Description: "Example of a backported R5 subscription with multiple resources."
* id       = "subscription-multi-resource"
* status   = #active
* end      = "2020-12-31T12:00:00Z"
* reason   = "Example Backported Subscription for Multiple Resources"
* criteria = $admissionTopic
* criteria.extension[filterCriteria].valueString       = "Patient?id=Patient/123"
* criteria.extension[filterCriteria].valueString       = "Encounter?patient=Patient/123"
* criteria.extension[filterCriteria].valueString       = "Observation?subject=Patient/123"
* channel.type                                         = #rest-hook
* channel.endpoint                                     = $webHookEndpoint
* channel.extension[heartbeatPeriod].valueUnsignedInt  = 86400
* channel.extension[timeout].valueUnsignedInt          = 60
* channel.extension[maxCount].valuePositiveInt         = 20
* channel.payload                                      = #application/fhir+json
* channel.payload.extension[content].valueCode         = #id-only

Instance:    BackportSubscriptionExampleCustomChannel
InstanceOf:  BackportSubscription
Usage:       #example
Title:       "Backported Subscription: Custom Channel"
Description: "Example of a backported R5 subscription in R4 with a custom channel."
* id       = "subscription-zulip"
* status   = #active
* end      = "2020-12-31T12:00:00Z"
* reason   = "Example Backported Subscription for Patient Admission via Zulip"
* criteria = $admissionTopic
* criteria.extension[filterCriteria].valueString        = "Encounter?patient=Patient/123"
* channel.type                                          = #rest-hook
* channel.type.extension[customChannelType].valueCoding = http://example.org/subscription-channel-type#zulip "Zulip Notification Channel"
* channel.endpoint                                      = $zulipEndpoint
* channel.extension[heartbeatPeriod].valueUnsignedInt   = 86400
* channel.extension[timeout].valueUnsignedInt           = 60
* channel.extension[maxCount].valuePositiveInt          = 20
* channel.payload                                       = #application/fhir+json
* channel.payload.extension[content].valueCode          = #id-only

Instance: Subscription-topic
InstanceOf: SearchParameter
Title: "Search by Canonical URL used in a topic-based subscription"
Usage: #definition
* insert ResourceJurisdiction
* url = "http://hl7.org/fhir/uv/subscriptions-backport/SearchParameter/Subscription-topic"
* name = "SubscriptionTopicSearchParameter"
* status = #draft
* experimental = true
* description = "This SearchParameter enables query of subscriptions by canonical topic-url."
* code = #topic
* base[0] = #Subscription
* type = #uri
* expression = "Subscription.criteria"
* xpath = "f:Subscription/f:criteria"
* xpathUsage = #normal

Instance: Subscription-filter-criteria
InstanceOf: SearchParameter
Title: "Search by the filtering criteria used to narrow a topic-based subscription topic"
Usage: #definition
* insert ResourceJurisdiction
* url = "http://hl7.org/fhir/uv/subscriptions-backport/SearchParameter/Subscription-filter-criteria"
* name = "SubscriptionFilterCriteriaSearchParameter"
* status = #draft
* experimental = true
* description = "This SearchParameter enables query of subscriptions by filter criteria."
* code = #filter-criteria
* base[0] = #Subscription
* type = #string
* expression = "(extension('http://hl7.org/fhir/uv/subscriptions-backport/StructureDefinition/backport-filter-criteria').value as string)"
* xpathUsage = #normal

Instance: Subscription-custom-channel
InstanceOf: SearchParameter
Title: "Search by custom channel types used for notifications"
Usage: #definition
* insert ResourceJurisdiction
* url = "http://hl7.org/fhir/uv/subscriptions-backport/SearchParameter/Subscription-custom-channel"
* name = "SubscriptionCustomChannelSearchParameter"
* status = #draft
* experimental = true
* description = "This SearchParameter enables query of subscriptions by additional channel type."
* code = #custom-channel
* base[0] = #Subscription
* type = #string
* expression = "(extension('http://hl7.org/fhir/uv/subscriptions-backport/StructureDefinition/backport-channel-type').value as Coding)"
* xpathUsage = #normal

Instance: Subscription-payload-type
InstanceOf: SearchParameter
Title: "Search by payload types used for notifications"
Usage: #definition
* insert ResourceJurisdiction
* url = "http://hl7.org/fhir/uv/subscriptions-backport/SearchParameter/Subscription-payload-type"
* name = "SubscriptionPayloadTypeSearchParameter"
* status = #draft
* experimental = true
* description = "This SearchParameter enables query of subscriptions by payload type."
* code = #payload-type
* base[0] = #Subscription
* type = #string
* expression = "(extension('http://hl7.org/fhir/uv/subscriptions-backport/StructureDefinition/backport-payload-content').value as Code)"
* xpathUsage = #normal
