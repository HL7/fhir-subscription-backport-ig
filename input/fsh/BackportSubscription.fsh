Instance:    BackportSubscriptionExampleAdmission
InstanceOf:  $xverSubProfile
Usage:       #example
Title:       "Backported Subscription: Admission"
Description: "R4/B Example of a topic-based 'admission' subscription."
* id       = "subscription-admission"
* status   = #active
* end      = "2020-12-31T12:00:00Z"
* reason   = "R4/B Example Topic-Based Subscription for Patient Admission"
* criteria = $admissionTopic
* extension[$xverSubTopic].valueCanonical                            = $admissionTopic
* extension[$xverSubFilterBy].extension[resourceType].valueUri       = "Encounter"
* extension[$xverSubFilterBy].extension[filterParameter].valueString = "patient"
* extension[$xverSubFilterBy].extension[value].valueString           = "Patient/123"
* extension[BackportPayloadContent].valueCode                 = #id-only
* extension[BackportHeartbeatPeriod].valueUnsignedInt        = 86400
* extension[BackportTimeout].valueUnsignedInt          = 60
* extension[BackportMaxCount].valuePositiveInt         = 20
* channel.type                                         = #rest-hook
* channel.endpoint                                     = $webHookEndpoint
* channel.payload                                      = #application/fhir+json
* extension[$xverSubIdentifier].valueIdentifier.system = "http://example.org"
* extension[$xverSubIdentifier].valueIdentifier.value  = "abc"

Instance:    BackportSubscriptionExampleMultiResource
InstanceOf:  $xverSubProfile
Usage:       #example
Title:       "Backported Subscription: Multi-Resource"
Description: "R4/B Example of a topic-based subscription with additional context resources."
* id       = "subscription-multi-resource"
* status   = #active
* end      = "2020-12-31T12:00:00Z"
* reason   = "R4/B Example Topic-Based Subscription for Multiple Resources"
* criteria = $admissionTopic
* extension[$xverSubTopic].valueCanonical                                = $admissionTopic
* extension[$xverSubFilterBy][0].extension[resourceType].valueUri     = "Patient"
* extension[$xverSubFilterBy][0].extension[filterParameter].valueString = "id"
* extension[$xverSubFilterBy][0].extension[value].valueString         = "Patient/123"
* extension[$xverSubFilterBy][1].extension[resourceType].valueUri     = "Encounter"
* extension[$xverSubFilterBy][1].extension[filterParameter].valueString = "patient"
* extension[$xverSubFilterBy][1].extension[value].valueString         = "Patient/123"
* extension[$xverSubFilterBy][2].extension[resourceType].valueUri     = "Observation"
* extension[$xverSubFilterBy][2].extension[filterParameter].valueString = "subject"
* extension[$xverSubFilterBy][2].extension[value].valueString         = "Patient/123"
* extension[BackportPayloadContent].valueCode                    = #id-only
* extension[BackportHeartbeatPeriod].valueUnsignedInt     = 86400
* extension[BackportTimeout].valueUnsignedInt             = 60
* extension[BackportMaxCount].valuePositiveInt            = 20
* channel.type                                    = #rest-hook
* channel.endpoint                                = $webHookEndpoint
* channel.payload                                 = #application/fhir+json

Instance:    BackportSubscriptionExampleCustomChannel
InstanceOf:  $xverSubProfile
Usage:       #example
Title:       "Backported Subscription: Custom Channel"
Description: "R4/B Example of a topic-based subscription using a custom channel."
* id       = "subscription-zulip"
* status   = #active
* end      = "2020-12-31T12:00:00Z"
* reason   = "R4/B Example Topic-Based Subscription for Patient Admission via Zulip"
* criteria = $admissionTopic
* extension[$xverSubTopic].valueCanonical                                = $admissionTopic
* extension[$xverSubFilterBy].extension[resourceType].valueUri     = "Encounter"
* extension[$xverSubFilterBy].extension[filterParameter].valueString = "patient"
* extension[$xverSubFilterBy].extension[value].valueString         = "Patient/123"
* extension[BackportPayloadContent].valueCode                    = #id-only
* extension[BackportHeartbeatPeriod].valueUnsignedInt     = 86400
* extension[BackportTimeout].valueUnsignedInt             = 60
* extension[BackportMaxCount].valuePositiveInt            = 20
* channel.type                                    = #rest-hook
* channel.type.extension[BackportChannelType].valueCoding = http://example.org/subscription-channel-type#zulip "Zulip Notification Channel"
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
* expression = "Subscription.channel.type.extension('http://hl7.org/fhir/uv/subscriptions-backport/StructureDefinition/backport-channel-type').value.ofType(Coding)"
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
* expression = "Subscription.extension('http://hl7.org/fhir/uv/subscriptions-backport/StructureDefinition/backport-payload-content').value.ofType(code)"
* xpathUsage = #normal
