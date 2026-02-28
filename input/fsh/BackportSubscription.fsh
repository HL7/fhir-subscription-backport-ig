Profile:     BackportSubscription
Parent:      Subscription
Id:          backport-subscription
Title:       "R4/B Topic-Based Subscription"
Description: "Profile on the Subscription resource to enable R5-style topic-based subscriptions in FHIR R4 or R4B."
* insert StructureJurisdiction
* extension contains
    $xverSubTopic named topic 1..1 MS and
    $xverSubFilterBy named filterBy 0..* MS and
    $xverSubContent named content 0..1 MS and
    $xverSubHeartbeat named heartbeatPeriod 0..1 and
    $xverSubTimeout named timeout 0..1 and
    $xverSubMaxCount named maxCount 0..1 and
    $xverSubIdentifier named identifier 0..* and
    $xverSubName named name 0..1 and
    $xverSubParameter named parameter 0..*
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
* criteria ^definition = "When using topic-based subscriptions, the topic is specified via the topic extension. The criteria element is retained for compatibility."
* channel.payload 1..1
* channel.type.extension contains $xverSubChannelType named channelType 0..1 MS
* channel.type.extension[channelType] ^short = "Extended channel type for notifications"
* channel.type.extension[channelType] ^definition = "The type of channel to send notifications on."
* channel.type.extension[channelType] ^comment = "This extension allows for the use of additional channel types that were not defined in the FHIR R4 subscription definition."


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
* extension[topic].valueCanonical                        = $admissionTopic
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
* extension[identifier].valueIdentifier.system   = "http://example.org"
* extension[identifier].valueIdentifier.value    = "abc"

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
* extension[topic].valueCanonical                                = $admissionTopic
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
* extension[topic].valueCanonical                                = $admissionTopic
* extension[filterBy].extension[resourceType].valueUri     = "Encounter"
* extension[filterBy].extension[filterParameter].valueString = "patient"
* extension[filterBy].extension[value].valueString         = "Patient/123"
* extension[content].valueCode                    = #id-only
* extension[heartbeatPeriod].valueUnsignedInt     = 86400
* extension[timeout].valueUnsignedInt             = 60
* extension[maxCount].valuePositiveInt            = 20
* channel.type                                    = #rest-hook
* channel.type.extension[channelType].valueCoding = http://example.org/subscription-channel-type#zulip "Zulip Notification Channel"
* channel.endpoint                                = $zulipEndpoint
* channel.payload                                 = #application/fhir+json

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
* expression = "Subscription.extension('http://hl7.org/fhir/5.0/StructureDefinition/extension-Subscription.topic').value"
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
* expression = "Subscription.extension('http://hl7.org/fhir/5.0/StructureDefinition/extension-Subscription.filterBy').extension('value').value.ofType(string)"
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
* expression = "Subscription.channel.type.extension('http://hl7.org/fhir/5.0/StructureDefinition/extension-Subscription.channelType').value.ofType(Coding)"
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
* expression = "Subscription.extension('http://hl7.org/fhir/5.0/StructureDefinition/extension-Subscription.identifier').value.ofType(Identifier)"
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
* expression = "Subscription.extension('http://hl7.org/fhir/5.0/StructureDefinition/extension-Subscription.content').value.ofType(code)"
* xpathUsage = #normal
