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
* notificationShape[=].extension[+].url = $relatedQueryExt
* notificationShape[=].extension[=].extension[+].url = "queryType"
* notificationShape[=].extension[=].extension[=].valueCoding = http://example.org/query-types#prescribed "Prescribed medications"
* notificationShape[=].extension[=].extension[+].url = "query"
* notificationShape[=].extension[=].extension[=].valueString = "http://example.org/fhir/Encounter/[id]/$prescribed-medications"
