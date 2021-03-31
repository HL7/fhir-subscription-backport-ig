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
Title:         "Backport Subscription Server Capability Statement"
Description:   "Example CapabilityStatement describing the expected capabilities of a FHIR Server supporting backported R5 Subscriptions."
* id            = "backport-subscription-server"
* name          = "BackportSubscriptionCapabilityStatement"
* description   = "Example CapabilityStatement describing the expected capabilities of a FHIR Server supporting backported R5 Subscriptions."
* text.div      = "<div xmlns=\"http://www.w3.org/1999/xhtml\"> <h2 id=\"title\">Backport Subscription Server Capability Statement</h2> <ul> <li>Implementation Guide Version: 0.1.1</li> <li>FHIR Version: 4.0.1</li> <li>Supported formats: xml, json</li> <li>Published: 2020-11-30</li> <li>Published by: HL7 FHIR Infrastructure WG</li> </ul> <p>Example CapabilityStatement describing the expected capabilities of a FHIR Server supporting backported R5 Subscriptions.</p> <h3 id=\"behavior\">FHIR RESTful Capabilities</h3> <h3 class=\"no_toc\" id=\"resource--details\">RESTful Capabilities by Resource/Profile:</h3> <p><strong>Summary of Search Criteria</strong></p> <table class=\"grid\"> <thead> <tr> <th>Resource Type</th> <th>Supported Profiles</th> <th>Supported Searches</th> <th>Supported <code>_includes</code></th> <th>Supported <code>_revincludes</code></th> <th>Supported Operations</th> </tr> </thead> <tbody> <tr> <td> <a href=\"#subscription\">Subscription</a> </td> <td> <a href=\"StructureDefinition-backport-subscription.html\">Backported R5 Subscription</a> </td> <td> </td> <td> </td> <td> </td> <td> $topic-list, $status </td> </tr> </tbody> </table> <h4 class=\"no_toc\" id=\"subscription\">Subscription</h4> <p>Conformance Expectation: <strong>SHALL</strong></p> <p>Supported Profiles: <a href=\"StructureDefinition-backport-subscription.html\">Backported R5 Subscription</a> </p> <p>Profile Interaction Summary:</p> <ul> </ul> <p>Operation Summary:</p> <ul> <li><strong>SHALL</strong> support the <a href=\"OperationDefinition-backport-subscriptiontopic-list.html\">$topic-list</a> operation , <a href=\"OperationDefinition-backport-subscription-status.html\">$status</a> operation </li> </ul> <p>Fetch and Search Criteria:</p> <ul> <li> A Server <strong>SHALL</strong> be capable of returning a Subscription resource using: <code class=\"highlighter-rouge\">GET [base]/Subscription/[id]</code> </li> </ul> </div>"
* text.status   = #generated
* implementationGuide = "http://hl7.org/fhir/uv/subscriptions-backport/ImplementationGuide/hl7.fhir.uv.subscriptions-backport"
* insert CapabilityCommon
* rest[0].mode  = #server
* rest[0].resource[0].type                = #Subscription
* rest[0].resource[0].supportedProfile[0] = "http://hl7.org/fhir/uv/subscriptions-backport/StructureDefinition/backport-subscription"
* rest[0].resource[0].interaction[0].code = #read
* rest[0].resource[0].interaction[1].code = #create
* rest[0].resource[0].interaction[2].code = #update
* rest[0].resource[0].interaction[3].code = #delete
* rest[0].resource[0].operation[0].name       = "$topic-list"
* rest[0].resource[0].operation[0].definition = "http://hl7.org/fhir/uv/subscriptions-backport/OperationDefinition/backport-subscriptiontopic-list"
* rest[0].resource[0].operation[1].name       = "$status"
* rest[0].resource[0].operation[1].definition = "http://hl7.org/fhir/uv/subscriptions-backport/OperationDefinition/backport-subscription-status"
