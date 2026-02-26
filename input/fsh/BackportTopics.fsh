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


Alias: $fhir-types = http://hl7.org/fhir/fhir-types


Extension:   BackportSubscriptionTopicStatusR4
Id:          backport-subscription-topic-status-r4
Title:       "Backported R5 SubscriptionTopic Status for R4"
Description: "Publication status of the SubscriptionTopic."
* insert StructureCommonR4
* insert ExtensionContext(Basic)
* . ?!
* . ^isModifierReason = "The publication status affects whether the topic should be used."
* value[x] only code
* valueCode from http://hl7.org/fhir/ValueSet/publication-status


Extension:   BackportSubscriptionTopicR4Extension
Id:          backport-subscription-topic-r4-extension
Title:       "Backported R5 SubscriptionTopic for R4"
Description: "Complex extension representing SubscriptionTopic information on a Basic resource for R4."
* insert StructureCommonR4
* insert ExtensionContext(Basic)
* extension contains
    url 1..1 MS and
    version 0..1 MS and
    name 0..1 MS and
    title 0..1 MS and
    date 0..1 MS and
    description 0..1 MS and
    resourceTrigger 0..* MS and
    canFilterBy 0..* MS and
    notificationShape 0..* MS
* extension[url] ^short = "Canonical URL for the SubscriptionTopic"
* extension[url] ^definition = "The canonical URL that identifies this subscription topic."
* extension[url].value[x] 1..1 MS
* extension[url].value[x] only uri
* extension[version] ^short = "Business version"
* extension[version] ^definition = "The business version of the subscription topic."
* extension[version].value[x] 1..1 MS
* extension[version].value[x] only string
* extension[name] ^short = "Name for the topic (computer friendly)"
* extension[name] ^definition = "A natural language name identifying the subscription topic."
* extension[name].value[x] 1..1 MS
* extension[name].value[x] only string
* extension[title] ^short = "Title for the topic (human friendly)"
* extension[title] ^definition = "A short, descriptive, user-friendly title for the subscription topic."
* extension[title].value[x] 1..1 MS
* extension[title].value[x] only string
* extension[date] ^short = "Date status last changed"
* extension[date] ^definition = "The date on which the resource content was last reviewed or changed."
* extension[date].value[x] 1..1 MS
* extension[date].value[x] only dateTime
* extension[description] ^short = "Description of the subscription topic"
* extension[description] ^definition = "A free text natural language description of the topic from a consumer's perspective."
* extension[description].value[x] 1..1 MS
* extension[description].value[x] only markdown
// resourceTrigger (complex sub-extension)
* extension[resourceTrigger] ^short = "Resource trigger definition"
* extension[resourceTrigger] ^definition = "A definition of a resource-based event that triggers a notification based on the SubscriptionTopic."
* extension[resourceTrigger].extension contains
    description 0..1 MS and
    resource 1..1 MS and
    supportedInteraction 0..* MS and
    queryCriteria 0..1 MS and
    fhirPathCriteria 0..1 MS
* extension[resourceTrigger].extension[description] ^short = "Text representation of the trigger"
* extension[resourceTrigger].extension[description].value[x] 1..1 MS
* extension[resourceTrigger].extension[description].value[x] only markdown
* extension[resourceTrigger].extension[resource] ^short = "Data type or resource for trigger definition"
* extension[resourceTrigger].extension[resource].value[x] 1..1 MS
* extension[resourceTrigger].extension[resource].value[x] only uri
* extension[resourceTrigger].extension[supportedInteraction] ^short = "create | update | delete"
* extension[resourceTrigger].extension[supportedInteraction].value[x] 1..1 MS
* extension[resourceTrigger].extension[supportedInteraction].value[x] only code
* extension[resourceTrigger].extension[queryCriteria] ^short = "Query based trigger rule"
* extension[resourceTrigger].extension[queryCriteria] ^definition = "The FHIR query based rules that the server should use to determine when to trigger a notification for this topic."
* extension[resourceTrigger].extension[queryCriteria].extension contains
    previous 0..1 MS and
    resultForCreate 0..1 MS and
    current 0..1 MS and
    resultForDelete 0..1 MS and
    requireBoth 0..1 MS
* extension[resourceTrigger].extension[queryCriteria].extension[previous] ^short = "Rule applied to state of a resource before update/delete"
* extension[resourceTrigger].extension[queryCriteria].extension[previous].value[x] 1..1 MS
* extension[resourceTrigger].extension[queryCriteria].extension[previous].value[x] only string
* extension[resourceTrigger].extension[queryCriteria].extension[resultForCreate] ^short = "test-passes | test-fails"
* extension[resourceTrigger].extension[queryCriteria].extension[resultForCreate].value[x] 1..1 MS
* extension[resourceTrigger].extension[queryCriteria].extension[resultForCreate].value[x] only code
* extension[resourceTrigger].extension[queryCriteria].extension[current] ^short = "Rule applied to state of a resource after create/update"
* extension[resourceTrigger].extension[queryCriteria].extension[current].value[x] 1..1 MS
* extension[resourceTrigger].extension[queryCriteria].extension[current].value[x] only string
* extension[resourceTrigger].extension[queryCriteria].extension[resultForDelete] ^short = "test-passes | test-fails"
* extension[resourceTrigger].extension[queryCriteria].extension[resultForDelete].value[x] 1..1 MS
* extension[resourceTrigger].extension[queryCriteria].extension[resultForDelete].value[x] only code
* extension[resourceTrigger].extension[queryCriteria].extension[requireBoth] ^short = "Both must be true flag"
* extension[resourceTrigger].extension[queryCriteria].extension[requireBoth].value[x] 1..1 MS
* extension[resourceTrigger].extension[queryCriteria].extension[requireBoth].value[x] only boolean
* extension[resourceTrigger].extension[fhirPathCriteria] ^short = "FHIRPath based trigger rule"
* extension[resourceTrigger].extension[fhirPathCriteria].value[x] 1..1 MS
* extension[resourceTrigger].extension[fhirPathCriteria].value[x] only string
// canFilterBy (complex sub-extension)
* extension[canFilterBy] ^short = "Properties by which a Subscription can filter notifications"
* extension[canFilterBy] ^definition = "List of properties by which Subscriptions on the SubscriptionTopic can be filtered."
* extension[canFilterBy].extension contains
    description 0..1 MS and
    resource 0..1 MS and
    filterParameter 1..1 MS and
    comparator 0..* MS and
    modifier 0..* MS
* extension[canFilterBy].extension[description] ^short = "Description of this filter parameter"
* extension[canFilterBy].extension[description].value[x] 1..1 MS
* extension[canFilterBy].extension[description].value[x] only markdown
* extension[canFilterBy].extension[resource] ^short = "URL of the triggering resource type filter"
* extension[canFilterBy].extension[resource].value[x] 1..1 MS
* extension[canFilterBy].extension[resource].value[x] only uri
* extension[canFilterBy].extension[filterParameter] ^short = "Search-style filter parameter"
* extension[canFilterBy].extension[filterParameter].value[x] 1..1 MS
* extension[canFilterBy].extension[filterParameter].value[x] only string
* extension[canFilterBy].extension[comparator] ^short = "Allowed comparator"
* extension[canFilterBy].extension[comparator].value[x] 1..1 MS
* extension[canFilterBy].extension[comparator].value[x] only code
* extension[canFilterBy].extension[modifier] ^short = "Allowed modifier"
* extension[canFilterBy].extension[modifier].value[x] 1..1 MS
* extension[canFilterBy].extension[modifier].value[x] only code
// notificationShape (complex sub-extension)
* extension[notificationShape] ^short = "Properties for describing the shape of notifications"
* extension[notificationShape] ^definition = "List of properties to describe the shape (e.g., resources) included in notifications from this Subscription Topic."
* extension[notificationShape].extension contains
    resource 1..1 MS and
    include 0..* MS and
    revInclude 0..* MS and
    BackportRelatedQuery named relatedQuery 0..*
* extension[notificationShape].extension[resource] ^short = "URL of the resource that is the focus"
* extension[notificationShape].extension[resource].value[x] 1..1 MS
* extension[notificationShape].extension[resource].value[x] only uri
* extension[notificationShape].extension[include] ^short = "Include directives, rooted in the resource for this shape"
* extension[notificationShape].extension[include].value[x] 1..1 MS
* extension[notificationShape].extension[include].value[x] only string
* extension[notificationShape].extension[revInclude] ^short = "Reverse include directives, rooted in the resource for this shape"
* extension[notificationShape].extension[revInclude].value[x] 1..1 MS
* extension[notificationShape].extension[revInclude].value[x] only string


Profile:      BackportSubscriptionTopicR4
Parent:       Basic
Id:           backport-subscription-topic-r4
Title:        "R4 Backported R5 SubscriptionTopic"
Description:  "Profile on Basic for representing SubscriptionTopic resources in R4."
* insert StructureCommonR4
* code = http://hl7.org/fhir/fhir-types#SubscriptionTopic
* modifierExtension contains BackportSubscriptionTopicStatusR4 named status 0..1
* modifierExtension[status] ^short = "Publication status of the topic"
* modifierExtension[status] ^definition = "The publication status of the SubscriptionTopic (draft, active, retired, unknown)."
* extension contains BackportSubscriptionTopicR4Extension named subscriptionTopic 1..1 MS


Instance:    BackportSubscriptionTopicExampleEncounterCompleteR4
InstanceOf:  BackportSubscriptionTopicR4
Usage:       #example
Title:       "Backported SubscriptionTopic: R4 Encounter Complete"
Description: "R4 example of a basic-wrapped subscription topic for completed encounters."
* id = "r4-encounter-complete"
* modifierExtension[status].valueCode = #draft
// Simple SubscriptionTopic metadata
* extension[subscriptionTopic].extension[url].valueUri = "http://hl7.org/fhir/uv/subscriptions-backport/SubscriptionTopic/r4-encounter-complete"
* extension[subscriptionTopic].extension[version].valueString = "1.2.0"
* extension[subscriptionTopic].extension[name].valueString = "R4 example of a basic-converted subscription topic for completed encounters."
* extension[subscriptionTopic].extension[title].valueString = "Backported SubscriptionTopic: R4 Encounter Complete"
* extension[subscriptionTopic].extension[date].valueDateTime = "2019-01-01"
* extension[subscriptionTopic].extension[description].valueMarkdown = "R4 example of a subscription topic for completed encounters."
// resourceTrigger
* extension[subscriptionTopic].extension[resourceTrigger].extension[description].valueMarkdown = "Triggered when an encounter is completed."
* extension[subscriptionTopic].extension[resourceTrigger].extension[resource].valueUri = "http://hl7.org/fhir/StructureDefinition/Encounter"
* extension[subscriptionTopic].extension[resourceTrigger].extension[supportedInteraction][0].valueCode = #create
* extension[subscriptionTopic].extension[resourceTrigger].extension[supportedInteraction][1].valueCode = #update
* extension[subscriptionTopic].extension[resourceTrigger].extension[queryCriteria].extension[previous].valueString = "status:not=finished"
* extension[subscriptionTopic].extension[resourceTrigger].extension[queryCriteria].extension[resultForCreate].valueCode = #test-passes
* extension[subscriptionTopic].extension[resourceTrigger].extension[queryCriteria].extension[current].valueString = "status=finished"
* extension[subscriptionTopic].extension[resourceTrigger].extension[queryCriteria].extension[resultForDelete].valueCode = #test-fails
* extension[subscriptionTopic].extension[resourceTrigger].extension[queryCriteria].extension[requireBoth].valueBoolean = true
* extension[subscriptionTopic].extension[resourceTrigger].extension[fhirPathCriteria].valueString = "(%previous.id.empty() or (%previous.status != 'finished')) and (%current.status = 'finished')"
// canFilterBy[0] - subject
* extension[subscriptionTopic].extension[canFilterBy][0].extension[description].valueMarkdown = "Filter based on the subject of an encounter."
* extension[subscriptionTopic].extension[canFilterBy][0].extension[resource].valueUri = "Encounter"
* extension[subscriptionTopic].extension[canFilterBy][0].extension[filterParameter].valueString = "subject"
// canFilterBy[1] - _in
* extension[subscriptionTopic].extension[canFilterBy][1].extension[description].valueMarkdown = "Filter based on the group membership of the subject of an encounter."
* extension[subscriptionTopic].extension[canFilterBy][1].extension[resource].valueUri = "Encounter"
* extension[subscriptionTopic].extension[canFilterBy][1].extension[filterParameter].valueString = "_in"
// canFilterBy[2] - length with comparators
* extension[subscriptionTopic].extension[canFilterBy][2].extension[description].valueMarkdown = "Filter based on the length of an encounter."
* extension[subscriptionTopic].extension[canFilterBy][2].extension[resource].valueUri = "Encounter"
* extension[subscriptionTopic].extension[canFilterBy][2].extension[filterParameter].valueString = "length"
* extension[subscriptionTopic].extension[canFilterBy][2].extension[comparator][0].valueCode = #gt
* extension[subscriptionTopic].extension[canFilterBy][2].extension[comparator][1].valueCode = #lt
* extension[subscriptionTopic].extension[canFilterBy][2].extension[comparator][2].valueCode = #ge
* extension[subscriptionTopic].extension[canFilterBy][2].extension[comparator][3].valueCode = #le
// notificationShape
* extension[subscriptionTopic].extension[notificationShape].extension[resource].valueUri = "Encounter"
* extension[subscriptionTopic].extension[notificationShape].extension[include][0].valueString = "Encounter:patient&iterate=Patient.link"
* extension[subscriptionTopic].extension[notificationShape].extension[include][1].valueString = "Encounter:practitioner"
* extension[subscriptionTopic].extension[notificationShape].extension[include][2].valueString = "Encounter:service-provider"
* extension[subscriptionTopic].extension[notificationShape].extension[include][3].valueString = "Encounter:account"
* extension[subscriptionTopic].extension[notificationShape].extension[include][4].valueString = "Encounter:diagnosis"
* extension[subscriptionTopic].extension[notificationShape].extension[include][5].valueString = "Encounter:observation"
* extension[subscriptionTopic].extension[notificationShape].extension[include][6].valueString = "Encounter:location"
* extension[subscriptionTopic].extension[notificationShape].extension[revInclude].valueString = "Encounter:subject"
* extension[subscriptionTopic].extension[notificationShape].extension[relatedQuery].extension[queryType].valueCoding = http://example.org/query-types#prescribed "Prescribed medications"
* extension[subscriptionTopic].extension[notificationShape].extension[relatedQuery].extension[query].valueString = "http://example.org/fhir/Encounter/[id]/$prescribed-medications"