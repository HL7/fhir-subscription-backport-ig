RuleSet:       CapabilityCommon
* jurisdiction        = http://unstats.un.org/unsd/methods/m49/m49.htm#001
* status              = #active
* date                = "2020-11-30"
* publisher           = "HL7 International - FHIR Infrastructure Work Group"
* contact[0].telecom[0].system = #url
* contact[0].telecom[0].value  = "https://hl7.org/Special/committees/fiwg/index.cfm"
* kind                = #requirements
* fhirVersion         = #4.1.0
* format[0]           = #xml
* format[1]           = #json

Instance:      CapabilitySubscriptionServer
InstanceOf:    CapabilityStatement
Usage:         #definition
Title:         "Minimal Backport Subscription Server Capability Statement"
Description:   "CapabilityStatement describing the minimal required capabilities of a FHIR Server supporting backported R5 Subscriptions."
* id            = "backport-subscription-server"
* name          = "BackportSubscriptionCapabilityStatement"
* description   = "CapabilityStatement describing the minimal required capabilities of a FHIR Server supporting backported R5 Subscriptions."
* text.div      = "<div xmlns=\"http://www.w3.org/1999/xhtml\"><h3 id=\"resource-details\">FHIR RESTful Capabilities by Resource/Profile:</h3><h4>Summary</h4><table class=\"grid\"><thead><tr><th>Resource Type</th><th>Supported Profiles</th><th>Supported Searches</th><th>Supported <code>_includes</code></th><th>Supported <code>_revincludes</code></th><th>Supported Operations</th></tr></thead><tbody><tr><td><a href=\"#subscriptiontopic\">SubscriptionTopic</a></td><td>-</td><td>url, derived-or-self, resource, title, trigger-description</td><td>-</td><td>-</td><td>-</td></tr><tr><td><a href=\"#subscription\">Subscription</a></td><td><a href=\"StructureDefinition-backport-subscription.html\">Backported R5 Subscription</a></td><td>url, status</td><td>-</td><td>-</td><td>$status, $events, $get-ws-binding-token</td></tr></tbody></table><h4 class=\"no_toc\" id=\"subscriptiontopic\">SubscriptionTopic</h4><p>Conformance Expectation: <strong>SHALL</strong></p><p>Interactions:</p><ul><li>A Server <strong>SHALL</strong> be capable of returning a SubscriptionTopic resource using: <code class=\"highlighter-rouge\">GET [base]/SubscriptionTopic/[id]</code></li><li>A Server <strong>SHALL</strong> be capable of searching for SubscriptionTopic resources using: <code class=\"highlighter-rouge\">GET [base]/SubscriptionTopic/?[parameters]</code></li></ul><p>Search Parameter Summary:</p><table class=\"grid\"><thead><tr><th>Conformance</th><th>Parameter</th><th>Type</th></tr></thead><tbody><tr><td><strong>SHALL</strong></td><td><a href=\"http://hl7.org/fhir/subscriptiontopic.html#search\">url</a></td><td>uri</td></tr><tr><td><strong>SHALL</strong></td><td><a href=\"http://hl7.org/fhir/subscriptiontopic.html#search\">derived-or-self</a></td><td>uri</td></tr><tr><td><strong>SHOULD</strong></td><td><a href=\"http://hl7.org/fhir/subscriptiontopic.html#search\">resource</a></td><td>uri</td></tr><tr><td><strong>SHOULD</strong></td><td><a href=\"http://hl7.org/fhir/subscriptiontopic.html#search\">title</a></td><td>string</td></tr><tr><td><strong>SHOULD</strong></td><td><a href=\"http://hl7.org/fhir/subscriptiontopic.html#search\">trigger-description</a></td><td>string</td></tr></tbody></table><hr/><h4 class=\"no_toc\" id=\"subscription\">Subscription</h4><p>Conformance Expectation: <strong>SHALL</strong></p><p>Supported Profiles:</p><ul><li><strong>SHALL</strong> support: <a href=\"StructureDefinition-backport-subscription.html\">Backported R5 Subscription</a></li></ul><p>Operation Summary:</p><ul><li><strong>SHALL</strong> support the <a href=\"OperationDefinition-backport-subscription-status.html\">$status</a> operation</li><li><strong>MAY</strong> support the <a href=\"OperationDefinition-backport-subscription-events.html\">$events</a> operation , <a href=\"OperationDefinition-backport-subscription-get-ws-binding-token.html\">$get-ws-binding-token</a> operation</li></ul><p>Fetch and Search Criteria:</p><ul><li>A Server <strong>SHALL</strong> be capable of returning a Subscription resource using: <code class=\"highlighter-rouge\">GET [base]/Subscription/[id]</code></li><li>A Server <strong>SHOULD</strong> be capable of creating a Subscription resource using either: <code class=\"highlighter-rouge\">POST [base]/Subscription</code> or <code class=\"highlighter-rouge\">PUT [base]/Subscription/[id]</code></li><li>A Server <strong>SHOULD</strong> be capable of modifying a Subscription resource using either: <code class=\"highlighter-rouge\">PUT [base]/Subscription/[id]</code> or <code class=\"highlighter-rouge\">PATCH [base]/Subscription/[id]</code></li><li>A Server <strong>SHOULD</strong> be capable of deleting a Subscription resource using: <code class=\"highlighter-rouge\">DELETE [base]/Subscription/[id]</code></li><li>A Server <strong>SHOULD</strong> be capable of searching for Subscription resources using: <code class=\"highlighter-rouge\">GET [base]/Subscription/?[parameters]</code></li></ul><p>Search Parameter Summary:</p><table class=\"grid\"><thead><tr><th>Conformance</th><th>Parameter</th><th>Type</th></tr></thead><tbody><tr><td><strong>SHOULD</strong></td><td><a href=\"http://hl7.org/fhir/subscription.html#search\">url</a></td><td>uri</td></tr><tr><td><strong>SHOULD</strong></td><td><a href=\"http://hl7.org/fhir/subscription.html#search\">status</a></td><td>token</td></tr></tbody></table><hr/></div>"
* text.status   = #generated
* implementationGuide = "http://hl7.org/fhir/uv/subscriptions-backport/ImplementationGuide/hl7.fhir.uv.subscriptions-backport"
* insert CapabilityCommon
* rest[+].mode  = #server
* rest[=].mode.extension[http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation].valueCode = #SHALL

* rest[=].resource[+].type = #SubscriptionTopic
* rest[=].resource[=].type.extension[http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation].valueCode = #SHALL
* rest[=].resource[=].interaction[+].code = #read
* rest[=].resource[=].interaction[=].code.extension[http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation].valueCode = #SHALL
* rest[=].resource[=].interaction[+].code = #create
* rest[=].resource[=].interaction[=].code.extension[http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation].valueCode = #MAY
* rest[=].resource[=].interaction[+].code = #update
* rest[=].resource[=].interaction[=].code.extension[http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation].valueCode = #MAY
* rest[=].resource[=].interaction[+].code = #delete
* rest[=].resource[=].interaction[=].code.extension[http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation].valueCode = #MAY
* rest[=].resource[=].searchParam[+].name = "url"
* rest[=].resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/url"
* rest[=].resource[=].searchParam[=].type = #uri
* rest[=].resource[=].searchParam[=].extension[http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation].valueCode = #SHALL
* rest[=].resource[=].searchParam[+].name = "derived-or-self"
* rest[=].resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/derived-or-self"
* rest[=].resource[=].searchParam[=].type = #uri
* rest[=].resource[=].searchParam[=].extension[http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation].valueCode = #SHALL
* rest[=].resource[=].searchParam[+].name = "resource"
* rest[=].resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/resource"
* rest[=].resource[=].searchParam[=].type = #uri
* rest[=].resource[=].searchParam[=].extension[http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation].valueCode = #SHOULD
* rest[=].resource[=].searchParam[+].name = "title"
* rest[=].resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/title"
* rest[=].resource[=].searchParam[=].type = #string
* rest[=].resource[=].searchParam[=].extension[http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation].valueCode = #SHOULD
* rest[=].resource[=].searchParam[+].name = "trigger-description"
* rest[=].resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/trigger-description"
* rest[=].resource[=].searchParam[=].type = #string
* rest[=].resource[=].searchParam[=].extension[http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation].valueCode = #SHOULD

* rest[=].resource[+].type = #Subscription
* rest[=].resource[=].extension[http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation].valueCode = #SHALL
* rest[=].resource[=].supportedProfile[+] = "http://hl7.org/fhir/uv/subscriptions-backport/StructureDefinition/backport-subscription"
* rest[=].resource[=].supportedProfile[=].extension[http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation].valueCode = #SHALL
* rest[=].resource[=].interaction[+].code = #read
* rest[=].resource[=].interaction[=].code.extension[http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation].valueCode = #SHALL
* rest[=].resource[=].interaction[+].code = #create
* rest[=].resource[=].interaction[=].code.extension[http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation].valueCode = #SHOULD
* rest[=].resource[=].interaction[+].code = #update
* rest[=].resource[=].interaction[=].code.extension[http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation].valueCode = #SHOULD
* rest[=].resource[=].interaction[+].code = #delete
* rest[=].resource[=].interaction[=].code.extension[http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation].valueCode = #SHOULD
* rest[=].resource[=].searchParam[+].name = "url"
* rest[=].resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/url"
* rest[=].resource[=].searchParam[=].type = #uri
* rest[=].resource[=].searchParam[=].extension[http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation].valueCode = #SHOULD
* rest[=].resource[=].searchParam[+].name = "status"
* rest[=].resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/status"
* rest[=].resource[=].searchParam[=].type = #token
* rest[=].resource[=].searchParam[=].extension[http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation].valueCode = #SHOULD
* rest[=].resource[=].operation[+].name = "$status"
* rest[=].resource[=].operation[=].definition = "http://hl7.org/fhir/uv/subscriptions-backport/OperationDefinition/OperationBackportSubscriptionStatus"
* rest[=].resource[=].operation[=].extension[http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation].valueCode = #SHALL
* rest[=].resource[=].operation[+].name = "$events"
* rest[=].resource[=].operation[=].definition = "http://hl7.org/fhir/uv/subscriptions-backport/OperationDefinition/OperationBackportSubscriptionEvents"
* rest[=].resource[=].operation[=].extension[http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation].valueCode = #MAY
* rest[=].resource[=].operation[+].name = "$get-ws-binding-token"
* rest[=].resource[=].operation[=].definition = "http://hl7.org/fhir/uv/subscriptions-backport/OperationDefinition/OperationBackportSubscriptionGetWsBindingToken"
* rest[=].resource[=].operation[=].extension[http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation].valueCode = #MAY
