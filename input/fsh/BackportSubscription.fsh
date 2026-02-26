Profile:     BackportSubscription
Parent:      Subscription
Id:          backport-subscription
Title:       "R4/B Topic-Based Subscription"
Description: "Profile on the Subscription resource to enable R5-style topic-based subscriptions in FHIR R4 or R4B."
* insert StructureJurisdiction
* extension contains
    BackportTopicCanonical named topic 1..1 MS and
    BackportFilterBy named filterBy 0..* MS and
    BackportContent named content 0..1 MS and
    BackportHeartbeatPeriod named heartbeatPeriod 0..1 and
    BackportTimeout named timeout 0..1 and
    BackportMaxCount named maxCount 0..1 and
    BackportSubscriptionIdentifier named identifier 0..* and
    BackportSubscriptionName named name 0..1 and
    BackportSubscriptionParameter named parameter 0..*
* extension[topic] ^short = "Canonical URL for the SubscriptionTopic driving this subscription"
* extension[topic] ^definition = "Canonical reference to the SubscriptionTopic that defines the events for this subscription."
* extension[filterBy] ^short = "Filtering criteria applied to events"
* extension[filterBy] ^definition = "Filtering criteria applied to narrow the subscription topic stream."
* extension[filterBy] ^comment = "When multiple filters are applied, evaluates to true if all the conditions are met; otherwise it returns false. (i.e., logical AND)."
* extension[content] ^short = "Notification content level"
* extension[content] ^definition = "How much of the resource content to deliver in the notification payload."
* extension[content] ^comment = "Sending the payload has obvious security implications. The server is responsible for ensuring that the content is appropriately secured."
* extension[heartbeatPeriod] ^short = "Interval in seconds to send 'heartbeat' notification"
* extension[heartbeatPeriod] ^definition = "If present, a 'heartbeat' notification (keepalive) is sent via this channel with an interval period equal to this element's integer value in seconds. If not present, a heartbeat notification is not sent."
* extension[timeout] ^short = "Timeout in seconds to attempt notification delivery"
* extension[timeout] ^definition = "If present, the maximum amount of time a server will allow before failing a notification attempt."
* extension[maxCount] ^short = "Maximum number of triggering resources included in notification bundles"
* extension[maxCount] ^definition = "If present, the maximum number of triggering resources that will be included in a notification bundle. Note that this is not a strict limit on the number of entries in a bundle, as dependent resources can be included."
* extension[identifier] ^short = "Subscription identifier"
* extension[identifier] ^definition = "A business identifier for this subscription."
* extension[name] ^short = "Subscription name"
* extension[name] ^definition = "A human-readable name for this subscription."
* extension[parameter] ^short = "Channel parameters"
* extension[parameter] ^definition = "Additional parameters for the channel, as name-value pairs."
* criteria ^short = "Criteria (may be empty for topic-based subscriptions)"
* criteria ^definition = "When using topic-based subscriptions, the topic is specified via the backport-topic-canonical extension. The criteria element is retained for compatibility."
* channel.payload 1..1
* channel.type.extension contains BackportChannelType named customChannelType 0..1
* channel.type.extension[BackportChannelType] MS
* channel.type.extension[BackportChannelType] ^short      = "Extended channel type for notifications"
* channel.type.extension[BackportChannelType] ^definition = "The type of channel to send notifications on."
* channel.type.extension[BackportChannelType] ^comment    = "This extension allows for the use of additional channel types that were not defined in the FHIR R4 subscription definition."

Extension:   BackportTopicCanonical
Id:          backport-topic-canonical
Title:       "Backport R5 Subscription Topic Canonical"
Description: "Canonical URL reference to the SubscriptionTopic driving this subscription."
* insert StructureJurisdiction
* insert ExtensionContext(Subscription)
* value[x] only uri
* value[x] ^short      = "Canonical URL for the SubscriptionTopic"
* value[x] ^definition = "Canonical reference to the SubscriptionTopic that defines the events for this subscription."

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

Extension:   BackportFilterBy
Id:          backport-filter-by
Title:       "Backported R5 Subscription FilterBy"
Description: "Defines structured criteria for filtering events in topic-based subscriptions."
* insert StructureJurisdiction
* insert ExtensionContext(Subscription)
* extension contains
    resourceType 0..1 and
    filterParameter 1..1 and
    comparator 0..1 and
    modifier 0..1 and
    value 1..1
* extension[resourceType] ^short = "Resource type to filter on"
* extension[resourceType] ^definition = "The resource type to apply the filter to, if applicable."
* extension[resourceType].value[x] only uri
* extension[filterParameter] ^short = "Filter parameter"
* extension[filterParameter] ^definition = "The filter parameter, as defined by the subscription topic or a search parameter."
* extension[filterParameter].value[x] only string
* extension[comparator] ^short = "Search comparator"
* extension[comparator] ^definition = "The comparator to use for the filter."
* extension[comparator].value[x] only code
* extension[comparator].valueCode from http://hl7.org/fhir/ValueSet/search-comparator
* extension[modifier] ^short = "Search modifier"
* extension[modifier] ^definition = "The modifier to use for the filter."
* extension[modifier].value[x] only code
* extension[modifier].valueCode from http://hl7.org/fhir/ValueSet/search-modifier-code
* extension[value] ^short = "Filter value"
* extension[value] ^definition = "The value to use for filtering."
* extension[value].value[x] only string

// Codes to represent how much resource content to send in the notification payload.
// Aligned with XVer R5-subscription-payload-content-for-R4.
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

Extension:   BackportContent
Id:          backport-content
Title:       "Backport R5 Subscription Payload Content Information"
Description: "How much of the resource content to deliver in the notification payload. The choices are an empty payload, only the resource id, or the full resource content."
* insert StructureJurisdiction
* insert ExtensionContext(Subscription)
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
* insert ExtensionContext(Subscription)
* value[x] only unsignedInt
* value[x] ^short      = "Interval in seconds to send 'heartbeat' notification"
* value[x] ^definition = "If present, a 'hearbeat' notification (keepalive) is sent via this channel with an the interval period equal to this elements integer value in seconds. If not present, a heartbeat notification is not sent."

Extension:   BackportTimeout
Id:          backport-timeout
Title:       "Backport R5 Subscription Timeout"
Description: "Timeout in seconds to attempt notification delivery."
* insert StructureJurisdiction
* insert ExtensionContext(Subscription)
* value[x] only unsignedInt
* value[x] ^short      = "Timeout in seconds to attempt notification delivery"
* value[x] ^definition = "If present, the maximum amount of time a server will allow before failing a notification attempt."

Extension:   BackportMaxCount
Id:          backport-max-count
Title:       "Backported R5 Subscription MaxCount"
Description: "Maximum number of triggering resources included in notification bundles."
* insert StructureJurisdiction
* insert ExtensionContext(Subscription)
* value[x] only positiveInt
* value[x] ^short      = "Maximum number of triggering resources included in notification bundles"
* value[x] ^definition = "If present, the maximum number of triggering resources that will be included in a notification bundle (e.g., a server will not include more than this number of trigger resources in a single notification). Note that this is not a strict limit on the number of entries in a bundle, as dependent resources can be included."

Extension:   BackportSubscriptionIdentifier
Id:          backport-subscription-identifier
Title:       "Backported R5 Subscription Identifier"
Description: "A business identifier for the subscription."
* insert StructureJurisdiction
* insert ExtensionContext(Subscription)
* value[x] only Identifier
* value[x] ^short      = "Subscription identifier"
* value[x] ^definition = "A business identifier for this subscription."

Extension:   BackportSubscriptionName
Id:          backport-subscription-name
Title:       "Backported R5 Subscription Name"
Description: "A human-readable name for the subscription."
* insert StructureJurisdiction
* insert ExtensionContext(Subscription)
* value[x] only string
* value[x] ^short      = "Subscription name"
* value[x] ^definition = "A human-readable name for this subscription."

Extension:   BackportSubscriptionParameter
Id:          backport-subscription-parameter
Title:       "Backported R5 Subscription Channel Parameter"
Description: "Additional parameters for the subscription channel, as name-value pairs."
* insert StructureJurisdiction
* insert ExtensionContext(Subscription)
* extension contains
    name 1..1 and
    value 1..1
* extension[name] ^short = "Parameter name"
* extension[name] ^definition = "The name of the parameter."
* extension[name].value[x] only string
* extension[value] ^short = "Parameter value"
* extension[value] ^definition = "The value of the parameter."
* extension[value].value[x] only string


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
* extension[topic].valueUri                        = $admissionTopic
* extension[filterBy].extension[resourceType].valueUri     = "Encounter"
* extension[filterBy].extension[filterParameter].valueString = "patient"
* extension[filterBy].extension[value].valueString         = "Patient/123"
* extension[content].valueCode                    = #id-only
* extension[heartbeatPeriod].valueUnsignedInt     = 86400
* extension[timeout].valueUnsignedInt             = 60
* extension[maxCount].valuePositiveInt            = 20
* channel.type                                    = #rest-hook
* channel.endpoint                                = $webHookEndpoint
* channel.payload                                 = #application/fhir+json

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
* extension[topic].valueUri                                = $admissionTopic
* extension[filterBy][0].extension[resourceType].valueUri     = "Patient"
* extension[filterBy][0].extension[filterParameter].valueString = "id"
* extension[filterBy][0].extension[value].valueString         = "Patient/123"
* extension[filterBy][1].extension[resourceType].valueUri     = "Encounter"
* extension[filterBy][1].extension[filterParameter].valueString = "patient"
* extension[filterBy][1].extension[value].valueString         = "Patient/123"
* extension[filterBy][2].extension[resourceType].valueUri     = "Observation"
* extension[filterBy][2].extension[filterParameter].valueString = "subject"
* extension[filterBy][2].extension[value].valueString         = "Patient/123"
* extension[content].valueCode                    = #id-only
* extension[heartbeatPeriod].valueUnsignedInt     = 86400
* extension[timeout].valueUnsignedInt             = 60
* extension[maxCount].valuePositiveInt            = 20
* channel.type                                    = #rest-hook
* channel.endpoint                                = $webHookEndpoint
* channel.payload                                 = #application/fhir+json

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
* extension[topic].valueUri                                = $admissionTopic
* extension[filterBy].extension[resourceType].valueUri     = "Encounter"
* extension[filterBy].extension[filterParameter].valueString = "patient"
* extension[filterBy].extension[value].valueString         = "Patient/123"
* extension[content].valueCode                    = #id-only
* extension[heartbeatPeriod].valueUnsignedInt     = 86400
* extension[timeout].valueUnsignedInt             = 60
* extension[maxCount].valuePositiveInt            = 20
* channel.type                                          = #rest-hook
* channel.type.extension[customChannelType].valueCoding = http://example.org/subscription-channel-type#zulip "Zulip Notification Channel"
* channel.endpoint                                      = $zulipEndpoint
* channel.payload                                       = #application/fhir+json

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
* type = #uri
* expression = "Subscription.extension('http://hl7.org/fhir/uv/subscriptions-backport/StructureDefinition/backport-topic-canonical').value"
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
* expression = "Subscription.extension('http://hl7.org/fhir/uv/subscriptions-backport/StructureDefinition/backport-filter-by').extension('value').value.ofType(string)"
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
* expression = "Subscription.extension('http://hl7.org/fhir/uv/subscriptions-backport/StructureDefinition/backport-content').value.ofType(code)"
* xpathUsage = #normal
