Instance:      CapabilitySubscriptionServer
InstanceOf:    CapabilityStatement
Usage:         #definition
Title:         "R4B Topic-Based Subscription Server Capability Statement"
Description:   "CapabilityStatement describing the minimal required capabilities of a FHIR Server supporting backported R5 Subscriptions in R4B."
* insert ResourceCommonR4B
* id            = "backport-subscription-server"
* name          = "BackportSubscriptionCapabilityStatement"
* url           = "http://hl7.org/fhir/uv/subscriptions-backport/CapabilityStatement/backport-subscription-server"
* description   = "CapabilityStatement describing the required and optional capabilities of a FHIR Server supporting backported R5 Subscriptions in R4B."
* insert CapabilityCommon
* rest[+].mode  = #server
* rest[=].mode.extension[http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation].valueCode = #SHALL

* insert SupportResource(SubscriptionTopic, #SHALL)
* insert SupportInteraction(#read, #SHALL)
* insert SupportInteraction(#create, #MAY)
* insert SupportInteraction(#update, #MAY)
* insert SupportInteraction(#delete, #MAY)
* insert SupportSearchParam(url, http://hl7.org/fhir/SearchParameter/SubscriptionTopic-url, #uri, #SHALL)
* insert SupportSearchParam(derived-or-self, http://hl7.org/fhir/SearchParameter/SubscriptionTopic-derived-or-self, #uri, #SHALL)
* insert SupportSearchParam(resource, http://hl7.org/fhir/SearchParameter/SubscriptionTopic-resource, #uri, #SHOULD)
* insert SupportSearchParam(title, http://hl7.org/fhir/SearchParameter/SubscriptionTopic-title, #string, #SHOULD)
* insert SupportSearchParam(trigger-description, http://hl7.org/fhir/SearchParameter/SubscriptionTopic-trigger-description, #string, #SHOULD)

* insert SupportResource(Subscription, #SHALL)
* insert SupportProfile(http://hl7.org/fhir/uv/subscriptions-backport/StructureDefinition/backport-subscription, #SHOULD)
* insert SupportInteraction(#read, #SHALL)
* insert SupportInteraction(#create, #SHOULD)
* insert SupportInteraction(#update, #SHOULD)
* insert SupportInteraction(#delete, #SHOULD)
* insert SupportSearchParam(url, http://hl7.org/fhir/SearchParameter/Subscription-url, #uri, #SHALL)
* insert SupportSearchParam(status, http://hl7.org/fhir/SearchParameter/Subscription-status, #token, #SHOULD)
* insert SupportOperation(status, http://hl7.org/fhir/uv/subscriptions-backport/OperationDefinition/backport-subscription-status, #SHALL)
* insert SupportOperation(events, http://hl7.org/fhir/uv/subscriptions-backport/OperationDefinition/backport-subscription-events, #MAY)
* insert SupportOperation(get-ws-binding-token, http://hl7.org/fhir/uv/subscriptions-backport/OperationDefinition/backport-subscription-get-ws-binding-token, #MAY)


Instance:      CapabilitySubscriptionServerAdministrative
InstanceOf:    CapabilityStatement
Usage:         #definition
Title:         "R4B Topic-Based Administrative Subscription Server Capability Statement"
Description:   "CapabilityStatement describing the minimal required capabilities of a FHIR Server supporting backported R5 Subscriptions in R4B that uses administrative subscription management.."
* insert ResourceCommonR4B
* id            = "backport-subscription-server-administrative"
* name          = "BackportSubscriptionCapabilityStatementAdministrative"
* url           = "http://hl7.org/fhir/uv/subscriptions-backport/CapabilityStatement/backport-subscription-server-administrative"
* description   = "CapabilityStatement describing the required and optional capabilities of a FHIR Server supporting backported R5 Subscriptions in R4 that uses administrative subscription management."
* insert CapabilityCommon
* rest[+].mode  = #server
* rest[=].mode.extension[http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation].valueCode = #SHALL

* insert SupportResource(SubscriptionTopic, #SHOULD)
* insert SupportInteraction(#read, #SHOULD)
* insert SupportInteraction(#create, #MAY)
* insert SupportInteraction(#update, #MAY)
* insert SupportInteraction(#delete, #MAY)
* insert SupportSearchParam(url, http://hl7.org/fhir/SearchParameter/SubscriptionTopic-url, #uri, #SHOULD)
* insert SupportSearchParam(derived-or-self, http://hl7.org/fhir/SearchParameter/SubscriptionTopic-derived-or-self, #uri, #SHOULD)
* insert SupportSearchParam(resource, http://hl7.org/fhir/SearchParameter/SubscriptionTopic-resource, #uri, #SHOULD)
* insert SupportSearchParam(title, http://hl7.org/fhir/SearchParameter/SubscriptionTopic-title, #string, #SHOULD)
* insert SupportSearchParam(trigger-description, http://hl7.org/fhir/SearchParameter/SubscriptionTopic-trigger-description, #string, #SHOULD)

* insert SupportResource(Subscription, #SHALL)
* insert SupportProfile(http://hl7.org/fhir/uv/subscriptions-backport/StructureDefinition/backport-subscription, #SHALL)
* insert SupportInteraction(#read, #SHALL)
* insert SupportInteraction(#create, #MAY)
* insert SupportInteraction(#update, #MAY)
* insert SupportInteraction(#delete, #MAY)
* insert SupportSearchParam(url, http://hl7.org/fhir/SearchParameter/Subscription-url, #uri, #SHOULD)
* insert SupportSearchParam(status, http://hl7.org/fhir/SearchParameter/Subscription-status, #token, #SHOULD)
* insert SupportOperation(status, http://hl7.org/fhir/uv/subscriptions-backport/OperationDefinition/backport-subscription-status, #SHALL)
* insert SupportOperation(events, http://hl7.org/fhir/uv/subscriptions-backport/OperationDefinition/backport-subscription-events, #MAY)
* insert SupportOperation(get-ws-binding-token, http://hl7.org/fhir/uv/subscriptions-backport/OperationDefinition/backport-subscription-get-ws-binding-token, #MAY)
