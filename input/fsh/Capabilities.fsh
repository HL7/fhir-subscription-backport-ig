RuleSet:       CapabilityCommon
* jurisdiction        = http://unstats.un.org/unsd/methods/m49/m49.htm#001
* status              = #active
* date                = "2020-11-30"
* publisher           = "HL7 International - FHIR Infrastructure Work Group"
* contact[0].telecom[0].system = #url
* contact[0].telecom[0].value  = "https://hl7.org/Special/committees/fiwg/index.cfm"
* kind                = #requirements
* fhirVersion         = #4.0.1
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
* text.div      = "<div xmlns=\"http://www.w3.org/1999/xhtml\"> <h2 id=\"title\">Backport Subscription Server Capability Statement</h2> <ul> <li>Implementation Guide Version: 0.1.1</li> <li>FHIR Version: 4.0.1</li> <li>Supported formats: xml, json</li> <li>Published: 2020-11-30</li> <li>Published by: HL7 FHIR Infrastructure WG</li> </ul> <p>Example CapabilityStatement describing the expected capabilities of a FHIR Server supporting backported R5 Subscriptions.</p> <h3 id=\"behavior\">FHIR RESTful Capabilities</h3> <h3 class=\"no_toc\" id=\"resource--details\">RESTful Capabilities by Resource/Profile:</h3> <p><strong>Summary of Search Criteria</strong></p> <table class=\"grid\"> <thead> <tr> <th>Resource Type</th> <th>Supported Profiles</th> <th>Supported Searches</th> <th>Supported <code>_includes</code></th> <th>Supported <code>_revincludes</code></th> <th>Supported Operations</th> </tr> </thead> <tbody> <tr> <td> <a href=\"#subscriptiontopic\">SubscriptionTopic</a> </td> <td> </td> <td> url, title, resource </td> <td> </td> <td> </td> <td> </td> </tr> <tr> <td> <a href=\"#subscription\">Subscription</a> </td> <td> <a href=\"StructureDefinition-backport-subscription.html\">Backported R5 Subscription</a> </td> <td> </td> <td> </td> <td> </td> <td> $status, $events, $get-ws-binding-token </td> </tr> </tbody> </table> <h4 class=\"no_toc\" id=\"subscription\">Subscription</h4> <p>Conformance Expectation: <strong>SHALL</strong></p> <p>Supported Profiles: <a href=\"StructureDefinition-backport-subscription.html\">Backported R5 Subscription</a> </p> <p>Profile Interaction Summary:</p> <ul> </ul> <p>Operation Summary:</p> <ul> <li><strong>SHALL</strong> support the <a href=\"OperationDefinition-backport-subscription-status.html\">$status</a> operation </li> <li><strong>MAY</strong> support the <a href=\"OperationDefinition-backport-subscription-events.html\">$events</a> operation, <a href=\"OperationDefinition-backport-subscription-get-ws-binding-token.html\">$get-ws-binding-token</a> operation </li> </ul> <p>Fetch and Search Criteria:</p> <ul> <li> A Server <strong>SHALL</strong> be capable of returning Subscription resources using: <code class=\"highlighter-rouge\">GET [base]/Subscription</code> </li> <li> A Server <strong>SHALL</strong> be capable of returning a Subscription resource using: <code class=\"highlighter-rouge\">GET [base]/Subscription/[id]</code> </li> <li> A Server <strong>SHALL</strong> be capable of removing a Subscription resource using: <code class=\"highlighter-rouge\">DELETE [base]/Subscription/[id]</code> </li> <li> A Server <strong>SHALL</strong> be capable of returning SubscriptionTopic resources using: <code class=\"highlighter-rouge\">GET [base]/SubscriptionTopic</code> </li> <li> A Server <strong>SHALL</strong> be capable of returning a SubscriptionTopic resource using: <code class=\"highlighter-rouge\">GET [base]/SubscriptionTopic/[id]</code> </li> </ul> </div>"
* text.status   = #generated
* implementationGuide = "http://hl7.org/fhir/uv/subscriptions-backport/ImplementationGuide/hl7.fhir.uv.subscriptions-backport"
* insert CapabilityCommon
* rest[+].mode  = #server
* rest[=].resource[+].type                = #Subscription
* rest[=].resource[=].supportedProfile[+] = "http://hl7.org/fhir/uv/subscriptions-backport/StructureDefinition/backport-subscription"
* rest[=].resource[=].interaction[+].code = #read
* rest[=].resource[=].interaction[+].code = #create
* rest[=].resource[=].interaction[+].code = #update
* rest[=].resource[=].interaction[+].code = #delete
* rest[=].resource[=].operation[+].name       = "$status"
* rest[=].resource[=].operation[=].definition = "http://hl7.org/fhir/uv/subscriptions-backport/OperationDefinition/backport-subscription-status"
* rest[=].resource[+].type                = #SubscriptionTopic
* rest[=].resource[=].interaction[+].code = #read
