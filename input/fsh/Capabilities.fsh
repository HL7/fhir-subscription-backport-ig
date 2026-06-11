Alias: $exp = http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation

RuleSet: CapabilityCommon
* status              = #active
* date                = "2020-11-30"
* publisher           = "HL7 International - FHIR Infrastructure Work Group"
// * contact[0].telecom[0].system = #url
// * contact[0].telecom[0].value  = "https://hl7.org/Special/committees/fiwg/index.cfm"
* kind                = #requirements
* format[0]           = #xml
* format[1]           = #json
* implementationGuide[+] = "http://hl7.org/fhir/uv/subscriptions-backport/ImplementationGuide/hl7.fhir.uv.subscriptions-backport"

RuleSet: SupportResourceNoExp (resource)
* rest.resource[+].type = #{resource}

RuleSet: SupportResource (resource, expectation)
* rest.resource[+].type = #{resource}
* rest.resource[=].extension[0].url = $exp
* rest.resource[=].extension[0].valueCode = {expectation}

RuleSet: SupportProfileNoExp (profile)
// This rule set must follow a SupportResource rule set, and applies to that resource.
* rest.resource[=].supportedProfile[+] = "{profile}"

RuleSet: SupportProfile (profile, expectation)
// This rule set must follow a SupportResource rule set, and applies to that resource.
* rest.resource[=].supportedProfile[+] = "{profile}"
* rest.resource[=].supportedProfile[=].extension[0].url = $exp
* rest.resource[=].supportedProfile[=].extension[0].valueCode = {expectation}

RuleSet: SupportInteractionNoExp (interaction)
// This rule set must follow a SupportResource rule set, and applies to that resource.
* rest.resource[=].interaction[+].code = {interaction}

RuleSet: SupportInteraction (interaction, expectation)
// This rule set must follow a SupportResource rule set, and applies to that resource.
* rest.resource[=].interaction[+].code = {interaction}
* rest.resource[=].interaction[=].extension[0].url = $exp
* rest.resource[=].interaction[=].extension[0].valueCode = {expectation}

RuleSet: SupportSearchParamNoExp (name, canonical, type)
// This rule set must follow a SupportResource rule set, and applies to that resource.
* rest.resource[=].searchParam[+].name = "{name}"
* rest.resource[=].searchParam[=].definition = "{canonical}"
* rest.resource[=].searchParam[=].type = {type}

RuleSet: SupportSearchParam (name, canonical, type, expectation)
// This rule set must follow a SupportResource rule set, and applies to that resource.
* rest.resource[=].searchParam[+].name = "{name}"
* rest.resource[=].searchParam[=].definition = "{canonical}"
* rest.resource[=].searchParam[=].type = {type}
* rest.resource[=].searchParam[=].extension[0].url = $exp
* rest.resource[=].searchParam[=].extension[0].valueCode = {expectation}

RuleSet: SupportOperationNoExp (name, canonical)
// This rule set must follow a SupportResource rule set, and applies to that resource.
* rest.resource[=].operation[+].name = "{name}"
* rest.resource[=].operation[=].definition = "{canonical}"

RuleSet: SupportOperation (name, canonical, expectation)
// This rule set must follow a SupportResource rule set, and applies to that resource.
* rest.resource[=].operation[+].name = "{name}"
* rest.resource[=].operation[=].definition = "{canonical}"
* rest.resource[=].operation[=].extension[0].url = $exp
* rest.resource[=].operation[=].extension[0].valueCode = {expectation}

// R4B CapabilityStatement moved to input/fsh-r4b/ (not processed in R4 builds)

Instance:      CapabilitySubscriptionServerR4
InstanceOf:    CapabilityStatement
Usage:         #definition
Title:         "R4 Topic-Based Subscription Server Capability Statement"
Description:   "CapabilityStatement describing the minimal required capabilities of a FHIR Server supporting backported R5 Subscriptions in R4."
* insert ResourceCommonR4
* id            = "backport-subscription-server-r4"
* name          = "BackportSubscriptionCapabilityStatementR4"
* url           = "http://hl7.org/fhir/uv/subscriptions-backport/CapabilityStatement/backport-subscription-server-r4"
* description   = "CapabilityStatement describing the required and optional capabilities of a FHIR Server supporting backported R5 Subscriptions in R4."
// * text.div      = "<div xmlns=\"http://www.w3.org/1999/xhtml\"><h3 id=\"resource-details\">FHIR RESTful Capabilities by Resource/Profile:</h3><h4>Summary</h4><table class=\"grid\"><thead><tr><th>Resource Type</th><th>Supported Profiles</th><th>Supported Searches</th><th>Supported <code>_includes</code></th><th>Supported <code>_revincludes</code></th><th>Supported Operations</th></tr></thead><tbody><tr><td><a href=\"#subscription\">Subscription</a></td><td><a href=\"StructureDefinition-backport-subscription.html\">Backported R5 Subscription</a></td><td>url, status</td><td>-</td><td>-</td><td>$status, $events, $get-ws-binding-token</td></tr></tbody></table><h4 class=\"no_toc\" id=\"subscription\">Subscription</h4><p>Conformance Expectation: <strong>SHALL</strong></p><p>Supported Profiles:</p><ul><li><strong>SHALL</strong> support: <a href=\"StructureDefinition-backport-subscription.html\">Backported R5 Subscription</a></li></ul><p>Operation Summary:</p><ul><li><strong>SHALL</strong> support the <a href=\"OperationDefinition-backport-subscription-status.html\">$status</a> operation</li><li><strong>MAY</strong> support the <a href=\"OperationDefinition-backport-subscription-events.html\">$events</a> operation , <a href=\"OperationDefinition-backport-subscription-get-ws-binding-token.html\">$get-ws-binding-token</a> operation</li></ul><p>Fetch and Search Criteria:</p><ul><li>A Server <strong>SHALL</strong> be capable of returning a Subscription resource using: <code class=\"highlighter-rouge\">GET [base]/Subscription/[id]</code></li><li>A Server <strong>SHOULD</strong> be capable of creating a Subscription resource using either: <code class=\"highlighter-rouge\">POST [base]/Subscription</code> or <code class=\"highlighter-rouge\">PUT [base]/Subscription/[id]</code></li><li>A Server <strong>SHOULD</strong> be capable of modifying a Subscription resource using either: <code class=\"highlighter-rouge\">PUT [base]/Subscription/[id]</code> or <code class=\"highlighter-rouge\">PATCH [base]/Subscription/[id]</code></li><li>A Server <strong>SHOULD</strong> be capable of deleting a Subscription resource using: <code class=\"highlighter-rouge\">DELETE [base]/Subscription/[id]</code></li><li>A Server <strong>SHOULD</strong> be capable of searching for Subscription resources using: <code class=\"highlighter-rouge\">GET [base]/Subscription/?[parameters]</code></li></ul><p>Search Parameter Summary:</p><table class=\"grid\"><thead><tr><th>Conformance</th><th>Parameter</th><th>Type</th></tr></thead><tbody><tr><td><strong>SHOULD</strong></td><td><a href=\"http://hl7.org/fhir/subscription.html#search\">url</a></td><td>uri</td></tr><tr><td><strong>SHOULD</strong></td><td><a href=\"http://hl7.org/fhir/subscription.html#search\">status</a></td><td>token</td></tr></tbody></table><hr/></div>"
// * text.status   = #generated
// * implementationGuide[+] = "http://hl7.org/fhir/uv/subscriptions-backport/ImplementationGuide/hl7.fhir.uv.subscriptions-backport"
* insert CapabilityCommon
* rest[+].mode  = #server
* rest[=].mode.extension[http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation].valueCode = #SHALL

* insert SupportResource(Subscription, #SHALL)
* insert SupportProfile(http://hl7.org/fhir/uv/subscriptions-backport/StructureDefinition/backport-subscription, #SHOULD)
* insert SupportInteraction(#read, #SHALL)
* insert SupportInteraction(#create, #SHALL)
* insert SupportInteraction(#update, #SHALL)
* insert SupportInteraction(#delete, #SHALL)
* insert SupportSearchParam(url, http://hl7.org/fhir/SearchParameter/Subscription-url, #uri, #SHALL)
* insert SupportSearchParam(status, http://hl7.org/fhir/SearchParameter/Subscription-status, #token, #SHOULD)
* insert SupportOperation(status, http://hl7.org/fhir/uv/subscriptions-backport/OperationDefinition/backport-subscription-status, #SHALL)
* insert SupportOperation(events, http://hl7.org/fhir/uv/subscriptions-backport/OperationDefinition/backport-subscription-events, #MAY)
* insert SupportOperation(get-ws-binding-token, http://hl7.org/fhir/uv/subscriptions-backport/OperationDefinition/backport-subscription-get-ws-binding-token, #MAY)

* insert SupportResource(Basic, #SHOULD)
* insert SupportInteraction(#read, #SHOULD)
* insert SupportInteraction(#create, #MAY)
* insert SupportInteraction(#update, #MAY)
* insert SupportInteraction(#delete, #MAY)
* insert SupportSearchParam(code, http://hl7.org/fhir/SearchParameter/clinical-code, #token, #SHOULD)


Instance:      CapabilitySubscriptionServerR4Administrative
InstanceOf:    CapabilityStatement
Usage:         #definition
Title:         "R4 Topic-Based Administrative Subscription Server Capability Statement"
Description:   "CapabilityStatement describing the minimal required capabilities of a FHIR Server supporting backported R5 Subscriptions in R4 that uses administrative subscription management."
* insert ResourceCommonR4
* id            = "backport-subscription-server-r4-administrative"
* name          = "BackportSubscriptionCapabilityStatementR4Administrative"
* url           = "http://hl7.org/fhir/uv/subscriptions-backport/CapabilityStatement/backport-subscription-server-r4-administrative"
* description   = "CapabilityStatement describing the required and optional capabilities of a FHIR Server supporting backported R5 Subscriptions in R4 that uses administrative subscription management."
* insert CapabilityCommon
* rest[+].mode  = #server
* rest[=].mode.extension[http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation].valueCode = #SHALL

* insert SupportResource(Subscription, #SHALL)
* insert SupportProfile(http://hl7.org/fhir/uv/subscriptions-backport/StructureDefinition/backport-subscription, #SHOULD)
* insert SupportInteraction(#read, #SHALL)
* insert SupportInteraction(#create, #MAY)
* insert SupportInteraction(#update, #MAY)
* insert SupportInteraction(#delete, #MAY)
* insert SupportSearchParam(url, http://hl7.org/fhir/SearchParameter/Subscription-url, #uri, #SHALL)
* insert SupportSearchParam(status, http://hl7.org/fhir/SearchParameter/Subscription-status, #token, #SHOULD)
* insert SupportOperation(status, http://hl7.org/fhir/uv/subscriptions-backport/OperationDefinition/backport-subscription-status, #SHALL)
* insert SupportOperation(events, http://hl7.org/fhir/uv/subscriptions-backport/OperationDefinition/backport-subscription-events, #MAY)
* insert SupportOperation(get-ws-binding-token, http://hl7.org/fhir/uv/subscriptions-backport/OperationDefinition/backport-subscription-get-ws-binding-token, #MAY)

* insert SupportResource(Basic, #MAY)
* insert SupportInteraction(#read, #MAY)
* insert SupportInteraction(#create, #MAY)
* insert SupportInteraction(#update, #MAY)
* insert SupportInteraction(#delete, #MAY)
* insert SupportSearchParam(code, http://hl7.org/fhir/SearchParameter/clinical-code, #token, #MAY)

Extension:   CapabilityStatementSubscriptionTopic
Id:          capabilitystatement-subscriptiontopic-canonical
Title:       "CapabilityStatement SubscriptionTopic Canonical"
Description: "Extension used to advertise supported SubscriptionTopic canonical URLs in a CapabilityStatement."
* insert StructureJurisdiction
* ^context[0].type = #element
* ^context[0].expression = "CapabilityStatement.rest.resource"
* value[x] only canonical

Instance:     CapabilityStatement-example-r4
InstanceOf:   CapabilityStatement
Usage:        #example
Title:        "R4 CapabilityStatement: Server Example"
Description:  "R4 example of a CapabilityStatement advertising support for topic-based subscriptions and a few topics."
* insert ResourceCommonR4
* id            = "r4-capabilitystatement-example-server"
* description   = "R4 example of a CapabilityStatement advertising support for topic-based subscriptions and a few topics."
* instantiates  = "http://hl7.org/fhir/uv/subscriptions-backport/CapabilityStatement/backport-subscription-server-r4"
// * implementationGuide[+] = "http://hl7.org/fhir/uv/subscriptions-backport/ImplementationGuide/hl7.fhir.uv.subscriptions-backport"
* insert CapabilityCommon
* rest[+].mode  = #server

* insert SupportResourceNoExp(Subscription)
* rest.resource[=].extension[+].url = "http://hl7.org/fhir/uv/subscriptions-backport/StructureDefinition/capabilitystatement-subscriptiontopic-canonical"
* rest.resource[=].extension[=].valueCanonical = "http://example.org/topics/patient-admission"
* rest.resource[=].extension[+].url = "http://hl7.org/fhir/uv/subscriptions-backport/StructureDefinition/capabilitystatement-subscriptiontopic-canonical"
* rest.resource[=].extension[=].valueCanonical = "http://example.org/topics/patient-discharge"

* insert SupportProfileNoExp(http://hl7.org/fhir/uv/subscriptions-backport/StructureDefinition/backport-subscription)
* insert SupportInteractionNoExp(#read)
* insert SupportInteractionNoExp(#create)
* insert SupportInteractionNoExp(#update)
* insert SupportInteractionNoExp(#delete)
* insert SupportSearchParamNoExp(url, http://hl7.org/fhir/SearchParameter/Subscription-url, #uri)
* insert SupportSearchParamNoExp(status, http://hl7.org/fhir/SearchParameter/Subscription-status, #token)
* insert SupportOperationNoExp(status, http://hl7.org/fhir/uv/subscriptions-backport/OperationDefinition/backport-subscription-status)
* insert SupportOperationNoExp(events, http://hl7.org/fhir/uv/subscriptions-backport/OperationDefinition/backport-subscription-events)
* insert SupportOperationNoExp(get-ws-binding-token, http://hl7.org/fhir/uv/subscriptions-backport/OperationDefinition/backport-subscription-get-ws-binding-token)

* insert SupportResourceNoExp(Patient)
* insert SupportInteractionNoExp(#read)
* insert SupportInteractionNoExp(#create)
* insert SupportInteractionNoExp(#update)
* insert SupportInteractionNoExp(#delete)

* insert SupportResourceNoExp(Encounter)
* insert SupportInteractionNoExp(#read)
* insert SupportInteractionNoExp(#create)
* insert SupportInteractionNoExp(#update)
* insert SupportInteractionNoExp(#delete)

* insert SupportResourceNoExp(Observation)
* insert SupportInteractionNoExp(#read)
* insert SupportInteractionNoExp(#create)
* insert SupportInteractionNoExp(#update)
* insert SupportInteractionNoExp(#delete)

* insert SupportResourceNoExp(Basic)
* insert SupportInteractionNoExp(#read)
* insert SupportInteractionNoExp(#create)
* insert SupportInteractionNoExp(#update)
* insert SupportInteractionNoExp(#delete)
* insert SupportSearchParam(code, http://hl7.org/fhir/SearchParameter/clinical-code, #token, #SHOULD)
