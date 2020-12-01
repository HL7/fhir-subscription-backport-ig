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
* description   = "Example CapabilityStatement describing the expected capabilities of a FHIR Server supporting backported R5 Subscriptions."
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
* rest[0].resource[0].operation[0].definition = "http://hl7.org/fhir/uv/subscriptions-backport/OperationDefinition/Backport-subscriptiontopic-list"
* rest[0].resource[0].operation[1].name       = "$status"
* rest[0].resource[0].operation[1].definition = "http://hl7.org/fhir/uv/subscriptions-backport/OperationDefinition/Backport-subscription-status"
