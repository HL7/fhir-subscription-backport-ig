Instance:    BackportSubscriptionTopicExampleEncounterCompleteR4B
InstanceOf:  SubscriptionTopic
Usage:       #example
Title:       "Backported SubscriptionTopic: R4B Encounter Complete"
Description: "R4B example of a subscription topic for completed encounters."
* id     = "r4b-encounter-complete"
* url    = "http://hl7.org/fhir/uv/subscriptions-backport/SubscriptionTopic/r4b-encounter-complete"
* status = #draft
* resourceTrigger[+].description = "Triggered when an encounter is completed."
* resourceTrigger[=].resource    = "Encounter"
* resourceTrigger[=].supportedInteraction[+] = #create
* resourceTrigger[=].supportedInteraction[+] = #update

* resourceTrigger[=].queryCriteria.previous        = "status:not=finished"
* resourceTrigger[=].queryCriteria.resultForCreate = #test-passes
* resourceTrigger[=].queryCriteria.current         = "status=finished"
* resourceTrigger[=].queryCriteria.resultForDelete = #test-fails
* resourceTrigger[=].queryCriteria.requireBoth     = true

* resourceTrigger[=].fhirPathCriteria = "(%previous.id.empty() or (%previous.status != 'finished')) and (%current.status = 'finished')"

* canFilterBy[+].description     = "Filter based on the subject of an encounter."
* canFilterBy[=].resource        = "Encounter"
* canFilterBy[=].filterParameter = "subject"

* canFilterBy[+].description     = "Filter based on the group membership of the subject of an encounter."
* canFilterBy[=].resource        = "Encounter"
* canFilterBy[=].filterParameter = "_in"

* canFilterBy[+].description     = "Filter based on the length of an encounter."
* canFilterBy[=].resource        = "Encounter"
* canFilterBy[=].filterParameter = "length"
* canFilterBy[=].modifier[+]     = #gt
* canFilterBy[=].modifier[+]     = #lt
* canFilterBy[=].modifier[+]     = #ge
* canFilterBy[=].modifier[+]     = #le

* notificationShape[+].resource = "Encounter"
* notificationShape[=].include[+] = "Encounter:patient&iterate=Patient.link"
* notificationShape[=].include[+] = "Encounter:practitioner"
* notificationShape[=].include[+] = "Encounter:service-provider"
* notificationShape[=].include[+] = "Encounter:account"
* notificationShape[=].include[+] = "Encounter:diagnosis"
* notificationShape[=].include[+] = "Encounter:observation"
* notificationShape[=].include[+] = "Encounter:location"


Alias: $fhir-types = http://hl7.org/fhir/fhir-types

Instance: BackportSubscriptionTopicExampleEncounterCompleteR4
InstanceOf: Basic
Usage: #example
* id = "r4-encounter-complete"
* modifierExtension[+].url = "http://hl7.org/fhir/5.0/StructureDefinition/extension-SubscriptionTopic.status"
* modifierExtension[=].valueCode = #draft
* extension[0].url = "http://hl7.org/fhir/5.0/StructureDefinition/extension-SubscriptionTopic.url"
* extension[=].valueUri = "http://hl7.org/fhir/uv/subscriptions-backport/SubscriptionTopic/r4-encounter-complete"
* extension[+].url = "http://hl7.org/fhir/5.0/StructureDefinition/extension-SubscriptionTopic.version"
* extension[=].valueString = "1.2.0"
* extension[+].url = "http://hl7.org/fhir/5.0/StructureDefinition/extension-SubscriptionTopic.name"
* extension[=].valueString = "R4 example of a basic-converted subscription topic for completed encounters."
* extension[+].url = "http://hl7.org/fhir/5.0/StructureDefinition/extension-SubscriptionTopic.title"
* extension[=].valueString = "Backported SubscriptionTopic: R4 Encounter Complete"
* extension[+].url = "http://hl7.org/fhir/5.0/StructureDefinition/extension-SubscriptionTopic.date"
* extension[=].valueDateTime = "2019-01-01"
* extension[+].url = "http://hl7.org/fhir/5.0/StructureDefinition/extension-SubscriptionTopic.description"
* extension[=].valueMarkdown = "R4 example of a subscription topic for completed encounters."
* extension[+].extension[0].url = "description"
* extension[=].extension[=].valueMarkdown = "Triggered when an encounter is completed."
* extension[=].extension[+].url = "resource"
* extension[=].extension[=].valueUri = "http://hl7.org/fhir/StructureDefinition/Encounter"
* extension[=].extension[+].url = "supportedInteraction"
* extension[=].extension[=].valueCode = #create
* extension[=].extension[+].url = "supportedInteraction"
* extension[=].extension[=].valueCode = #update
* extension[=].extension[+].extension[0].url = "previous"
* extension[=].extension[=].extension[=].valueString = "status:not=finished"
* extension[=].extension[=].extension[+].url = "resultForCreate"
* extension[=].extension[=].extension[=].valueCode = #test-passes
* extension[=].extension[=].extension[+].url = "current"
* extension[=].extension[=].extension[=].valueString = "status=finished"
* extension[=].extension[=].extension[+].url = "resultForDelete"
* extension[=].extension[=].extension[=].valueCode = #test-fails
* extension[=].extension[=].extension[+].url = "requireBoth"
* extension[=].extension[=].extension[=].valueBoolean = true
* extension[=].extension[=].url = "queryCriteria"
* extension[=].extension[+].url = "fhirPathCriteria"
* extension[=].extension[=].valueString = "(%previous.id.empty() or (%previous.status != 'finished')) and (%current.status = 'finished')"
* extension[=].url = "http://hl7.org/fhir/5.0/StructureDefinition/extension-SubscriptionTopic.resourceTrigger"
* extension[+].extension[0].url = "description"
* extension[=].extension[=].valueMarkdown = "Filter based on the subject of an encounter."
* extension[=].extension[+].url = "resource"
* extension[=].extension[=].valueUri = "Encounter"
* extension[=].extension[+].url = "filterParameter"
* extension[=].extension[=].valueString = "subject"
* extension[=].url = "http://hl7.org/fhir/5.0/StructureDefinition/extension-SubscriptionTopic.canFilterBy"
* extension[+].extension[0].url = "description"
* extension[=].extension[=].valueMarkdown = "Filter based on the group membership of the subject of an encounter."
* extension[=].extension[+].url = "resource"
* extension[=].extension[=].valueUri = "Encounter"
* extension[=].extension[+].url = "filterParameter"
* extension[=].extension[=].valueString = "_in"
* extension[=].url = "http://hl7.org/fhir/5.0/StructureDefinition/extension-SubscriptionTopic.canFilterBy"
* extension[+].extension[0].url = "description"
* extension[=].extension[=].valueMarkdown = "Filter based on the length of an encounter."
* extension[=].extension[+].url = "resource"
* extension[=].extension[=].valueUri = "Encounter"
* extension[=].extension[+].url = "filterParameter"
* extension[=].extension[=].valueString = "length"
* extension[=].extension[+].url = "comparator"
* extension[=].extension[=].valueCode = #gt
* extension[=].extension[+].url = "comparator"
* extension[=].extension[=].valueCode = #lt
* extension[=].extension[+].url = "comparator"
* extension[=].extension[=].valueCode = #ge
* extension[=].extension[+].url = "comparator"
* extension[=].extension[=].valueCode = #le
* extension[=].url = "http://hl7.org/fhir/5.0/StructureDefinition/extension-SubscriptionTopic.canFilterBy"
* extension[+].extension[0].url = "resource"
* extension[=].extension[=].valueUri = "Encounter"
* extension[=].extension[+].url = "include"
* extension[=].extension[=].valueString = "Encounter:patient&iterate=Patient.link"
* extension[=].extension[+].url = "include"
* extension[=].extension[=].valueString = "Encounter:practitioner"
* extension[=].extension[+].url = "include"
* extension[=].extension[=].valueString = "Encounter:service-provider"
* extension[=].extension[+].url = "include"
* extension[=].extension[=].valueString = "Encounter:account"
* extension[=].extension[+].url = "include"
* extension[=].extension[=].valueString = "Encounter:diagnosis"
* extension[=].extension[+].url = "include"
* extension[=].extension[=].valueString = "Encounter:observation"
* extension[=].extension[+].url = "include"
* extension[=].extension[=].valueString = "Encounter:location"
* extension[=].extension[+].url = "revInclude"
* extension[=].extension[=].valueString = "Encounter:subject"
* extension[=].url = "http://hl7.org/fhir/5.0/StructureDefinition/extension-SubscriptionTopic.notificationShape"
* code = $fhir-types#SubscriptionTopic