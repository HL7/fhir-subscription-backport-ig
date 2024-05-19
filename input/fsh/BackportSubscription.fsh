Profile:     BackportSubscription
Parent:      Subscription
Id:          backport-subscription
Title:       "R4/B Topic-Based Subscription"
Description: "Profile on the Subscription resource to enable R5-style topic-based subscriptions in FHIR R4 or R4B."
* insert StructureJurisdiction
* criteria 1..1 MS 
* criteria ^short = "Canonical URL for the topic used to generate events"
* criteria ^definition = "When using topic-based subscriptions, the primary criteria is always the topic, indicated by its canonical URL."
* criteria.extension 0..*
* criteria.extension contains BackportFilterCriteria named filterCriteria 0..*
* criteria.extension[BackportFilterCriteria] MS SU
* criteria.extension[BackportFilterCriteria] ^short      = "Filtering critiera applied to events"
* criteria.extension[BackportFilterCriteria] ^definition = "Search-style filters to be applied to narrow the subscription topic stream. Keys can be either search parameters appropriate to the filtering resource or keys defined within the subscription topic."
* criteria.extension[BackportFilterCriteria] ^comment    = "When multiple filters are applied, evaluates to true if all the conditions are met; otherwise it returns false. (i.e., logical AND)."
* channel.payload 1..1
* channel.payload.extension contains BackportPayloadContent named content 1..1
* channel.payload.extension[BackportPayloadContent] MS SU
* channel.payload.extension[BackportPayloadContent] ^short      = "Notification content level"
* channel.payload.extension[BackportPayloadContent] ^definition = "How much of the resource content to deliver in the notification payload. The choices are an empty payload, only the resource id, or the full resource content."
* channel.payload.extension[BackportPayloadContent] ^comment    = "Sending the payload has obvious security implications. The server is responsible for ensuring that the content is appropriately secured."
* channel.extension contains BackportHeartbeatPeriod named heartbeatPeriod 0..1
* channel.extension[BackportHeartbeatPeriod] ^short      = "Interval in seconds to send 'heartbeat' notification"
* channel.extension[BackportHeartbeatPeriod] ^definition = "If present, a 'hearbeat' notification (keepalive) is sent via this channel with an the interval period equal to this elements integer value in seconds. If not present, a heartbeat notification is not sent."
* channel.extension contains BackportTimeout named timeout 0..1
* channel.extension[BackportTimeout] ^short      = "Timeout in seconds to attempt notification delivery"
* channel.extension[BackportTimeout] ^definition = "If present, the maximum amount of time a server will allow before failing a notification attempt."
* channel.extension contains BackportMaxCount named maxCount 0..1
* channel.extension[BackportMaxCount] ^short      = "Maximum number of triggering resources included in notification bundles"
* channel.extension[BackportMaxCount] ^definition = "If present, the maximum number of triggering resources that will be included in a notification bundle (e.g., a server will not include more than this number of trigger resources in a single notification). Note that this is not a strict limit on the number of entries in a bundle, as dependent resources can be included."
* channel.type.extension contains BackportChannelType named customChannelType 0..1
* channel.type.extension[BackportChannelType] MS SU
* channel.type.extension[BackportChannelType] ^short      = "Extended channel type for notifications"
* channel.type.extension[BackportChannelType] ^definition = "The type of channel to send notifications on."
* channel.type.extension[BackportChannelType] ^comment    = "This extension allows for the use of additional channel types that were not defined in the FHIR R4 subscription definition."
* extension contains ExtensionSubscriptionIdentifier named identifier 0..*

Extension:   ExtensionSubscriptionIdentifier
Id:          extension-Subscription.identifier
Title:       "Backported R5 Identifier"
* insert StructureJurisdiction
* ^url = "http://hl7.org/fhir/5.0/StructureDefinition/extension-Subscription.identifier"
* value[x] only Identifier
* value[x] ^short      = "Identifier for the Subscription"
* value[x] ^definition = "Identifier for the Subscription"
* value[x] ^comment    = "This extension allows for the use of Identifiers that were not defined in the FHIR R4 subscription definition."

Extension:   BackportChannelType
Id:          backport-channel-type
Title:       "Backported R5 Additional Channel Types"
Description: "Additional channel types not defined before FHIR R5."
* insert StructureJurisdiction
* ^context[0].type = #element
* ^context[0].expression = "Subscription.channel.type"
* value[x] only Coding
* value[x] ^short      = "Extended channel type for notifications"
* value[x] ^definition = "The type of channel to send notifications on."
* value[x] ^comment    = "This extension allows for the use of additional channel types that were not defined in the FHIR R4 subscription definition."

Extension:   BackportFilterCriteria
Id:          backport-filter-criteria
Title:       "Backported R5 FilterBy Criteria"
Description: "Criteria for topic-based filtering (filter-by)."
* insert StructureJurisdiction
* ^context[0].type = #element
* ^context[0].expression = "Subscription.criteria"
* value[x] only string
* value[x] ^short      = "Filtering critiera applied to events"
* value[x] ^definition = "Search-style filters to be applied to narrow the subscription topic stream. Keys can be either search parameters appropriate to the filtering resource or keys defined within the subscription topic."
* value[x] ^comment    = "When multiple filters are applied, evaluates to true if all the conditions are met; otherwise it returns false. (i.e., logical AND)."

CodeSystem:  BackportContentCodeSystem
Id:          backport-content-code-system
Title:       "Backported R5 Subscription Content Code System"
Description: "Codes to represent how much resource content to send in the notification payload."
* insert StructureJurisdiction
* ^caseSensitive  = true
* ^experimental   = false
* #empty         "Empty"         "No resource content is transacted in the notification payload."
* #id-only       "Id Only"       "Only the resource id is transacted in the notification payload."
* #full-resource "Full Resource" "The entire resource is transacted in the notification payload."

ValueSet:    BackportContentValueSet
Id:          backport-content-value-set
Title:       "Backported R5 Subscription Content Value Set"
Description: "Codes to represent how much resource content to send in the notification payload."
* insert StructureJurisdiction
* ^experimental   = false
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
* value[x] ^short      = "Notification content level"
* value[x] ^definition = "How much of the resource content to deliver in the notification payload. The choices are an empty payload, only the resource id, or the full resource content."
* value[x] ^comment    = "Sending the payload has obvious security implications. The server is responsible for ensuring that the content is appropriately secured."

Extension:   BackportHeartbeatPeriod
Id:          backport-heartbeat-period
Title:       "Backport R5 Subscription Heartbeat Period"
Description: "Interval in seconds to send 'heartbeat' notifications."
* insert StructureJurisdiction
* ^context[0].type = #element
* ^context[0].expression = "Subscription.channel"
* value[x] only unsignedInt
* value[x] ^short      = "Interval in seconds to send 'heartbeat' notification"
* value[x] ^definition = "If present, a 'hearbeat' notification (keepalive) is sent via this channel with an the interval period equal to this elements integer value in seconds. If not present, a heartbeat notification is not sent."

Extension:   BackportTimeout
Id:          backport-timeout
Title:       "Backport R5 Subscription Timeout"
Description: "Timeout in seconds to attempt notification delivery."
* insert StructureJurisdiction
* ^context[0].type = #element
* ^context[0].expression = "Subscription.channel"
* value[x] only unsignedInt
* value[x] ^short      = "Timeout in seconds to attempt notification delivery"
* value[x] ^definition = "If present, the maximum amount of time a server will allow before failing a notification attempt."

Extension:   BackportMaxCount
Id:          backport-max-count
Title:       "Backported R5 Subscription MaxCount"
Description: "Maximum number of triggering resources included in notification bundles."
* insert StructureJurisdiction
* ^context[0].type = #element
* ^context[0].expression = "Subscription.channel"
* value[x] only positiveInt
* value[x] ^short      = "Maximum number of triggering resources included in notification bundles"
* value[x] ^definition = "If present, the maximum number of triggering resources that will be included in a notification bundle (e.g., a server will not include more than this number of trigger resources in a single notification). Note that this is not a strict limit on the number of entries in a bundle, as dependent resources can be included."

Instance:    BackportSubscriptionExampleAdmission
InstanceOf:  BackportSubscription
Usage:       #example
Title:       "Backported Subscription: Admission"
Description: "R4/B Example of a topic-based 'admission' subscription."
* id       = "subscription-admission"
* status   = #active
* end      = "2020-12-31T12:00:00Z"
* reason   = "R4/B Example Topic-Based Subscription for Patient Admission"
* criteria = $admissionTopic
* criteria.extension[filterCriteria].valueString       = "Encounter?patient=Patient/123"
* channel.type                                         = #rest-hook
* channel.endpoint                                     = $webHookEndpoint
* channel.extension[heartbeatPeriod].valueUnsignedInt  = 86400
* channel.extension[timeout].valueUnsignedInt          = 60
* channel.extension[maxCount].valuePositiveInt         = 20
* channel.payload                                      = #application/fhir+json
* channel.payload.extension[content].valueCode         = #id-only
* extension[extension-Subscription.identifier].valueIdentifier[0].system = "http://example.org"
* extension[extension-Subscription.identifier].valueIdentifier[=].value = "abc"

Instance:    BackportSubscriptionExampleMultiResource
InstanceOf:  BackportSubscription
Usage:       #example
Title:       "Backported Subscription: Multi-Resource"
Description: "R4/B Example of a topic-based subscription with additional context resources."
* id       = "subscription-multi-resource"
* status   = #active
* end      = "2020-12-31T12:00:00Z"
* reason   = "R4/B Example Topic-Based Subscription for Multiple Resources"
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
Description: "R4/B Example of a topic-based subscription using a custom channel."
* id       = "subscription-zulip"
* status   = #active
* end      = "2020-12-31T12:00:00Z"
* reason   = "R4/B Example Topic-Based Subscription for Patient Admission via Zulip"
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
* description = "This SearchParameter enables query of subscriptions by canonical topic url."
* code = #topic
* base[0] = #Subscription
* type = #string
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
* expression = "extension('http://hl7.org/fhir/uv/subscriptions-backport/StructureDefinition/backport-filter-criteria').value.ofType(string)"
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
* type = #token
* expression = "extension('http://hl7.org/fhir/uv/subscriptions-backport/StructureDefinition/backport-channel-type').value.ofType(Coding)"
* xpathUsage = #normal

Instance: Subscription-identifier
InstanceOf: SearchParameter
Title: "Search by identifier on Subscription"
Usage: #definition
* insert ResourceJurisdiction
* url = "http://hl7.org/fhir/uv/subscriptions-backport/SearchParameter/Subscription-identifier"
* name = "SubscriptionIdentifierSearchParameter"
* status = #draft
* experimental = true
* description = "This SearchParameter enables query of subscriptions by identifier."
* code = #identifier
* base[0] = #Subscription
* type = #token
* expression = "extension('http://hl7.org/fhir/5.0/StructureDefinition/extension-Subscription.identifier').value.ofType(Identifier)"
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
* type = #token
* expression = "extension('http://hl7.org/fhir/uv/subscriptions-backport/StructureDefinition/backport-payload-content').value.ofType(code)"
* xpathUsage = #normal
