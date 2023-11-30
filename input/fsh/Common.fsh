Alias: $admissionTopic = http://hl7.org/SubscriptionTopic/admission
Alias: $admissionSub = https://example.org/fhir/Subscription/admission
Alias: $admissionSubStatus = https://example.org/fhir/Subscription/admission/$status

Alias: $webHookEndpoint = https://example.org/Endpoints/d7dcc004-808d-452b-8030-3a3a13cd871d
Alias: $zulipEndpoint = https://example.org/Endpoints/ZulipForwarder

Alias: $authorizationHintExt = http://hl7.org/fhir/uv/subscriptions-backport/StructureDefinition/notification-authorization-hint

Alias: $relatedQueryExt = http://hl7.org/fhir/uv/subscriptions-backport/StructureDefinition/backport-related-query


RuleSet: StructureJurisdiction
* ^jurisdiction = http://unstats.un.org/unsd/methods/m49/m49.htm#001

RuleSet: StructureCommonR4
* ^jurisdiction = http://unstats.un.org/unsd/methods/m49/m49.htm#001
// * ^fhirVersion = #4.0.1

RuleSet: StructureCommonR4B
* ^jurisdiction = http://unstats.un.org/unsd/methods/m49/m49.htm#001
// * ^fhirVersion = #4.3.0

RuleSet: ResourceJurisdiction
* jurisdiction = http://unstats.un.org/unsd/methods/m49/m49.htm#001

RuleSet: ResourceCommonR4
* jurisdiction = http://unstats.un.org/unsd/methods/m49/m49.htm#001
* fhirVersion = #4.0.1

RuleSet: ResourceCommonR4B
* jurisdiction = http://unstats.un.org/unsd/methods/m49/m49.htm#001
* fhirVersion = #4.3.0


// The path is either the name of a resource or path to an element
RuleSet: ExtensionContext(path)
* ^context[+].type = #element
* ^context[=].expression = "{path}"

// The strings defined for short and definition should not be quoted, and any comma must be escaped with a backslash.
RuleSet: ExtensionDefinition(path, short, definition)
* extension[{path}] ^short = {short}
* extension[{path}] ^definition = {definition}


// Patient for use in notifications
Alias: $notificationPatient    = https://example.org/fhir/Patient/1599eb66-431a-447c-a3de-6897fe9ae9a1
Alias: $notificationPatientId  = 1599eb66-431a-447c-a3de-6897fe9ae9a1

Instance:    BackportNotificationPatient
InstanceOf:  Patient
Usage:       #inline
* id                = "1599eb66-431a-447c-a3de-6897fe9ae9a1"
* active            = true
* name[+].use       = #usual
* name[=].text      = "Example Patient"
* name[=].family    = "Patient"
* name[=].given[0]  = "Example"


// Encounter for use in notifications
Alias: $notificationEncounter1   = https://example.org/fhir/Encounter/86009987-eabe-42bf-8c02-b112b18cb616
Alias: $notificationEncounter1Id = 86009987-eabe-42bf-8c02-b112b18cb616

Instance:    BackportNotificationEncounter
InstanceOf:  Encounter
Usage:       #inline
* id            = "86009987-eabe-42bf-8c02-b112b18cb616"
* status        = #in-progress
* class         = http://terminology.hl7.org/CodeSystem/v3-ActCode#VR
* subject.reference = $notificationPatient
* subject.display   = "Example Patient"

// Operation common definitions
RuleSet:       OperationCommon
* jurisdiction        = http://unstats.un.org/unsd/methods/m49/m49.htm#001
* status              = #active
* date                = "2020-11-30"
* publisher           = "HL7 International - FHIR Infrastructure Work Group"
// * contact[0].telecom[0].system = #url
// * contact[0].telecom[0].value  = "https://hl7.org/Special/committees/fiwg/index.cfm"
* affectsState        = false
* version             = "0.1.1"
* kind                = #operation
* extension[0].url          = "http://hl7.org/fhir/StructureDefinition/structuredefinition-fmm"
* extension[0].valueInteger = 0
* extension[1].url          = "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status"
* extension[1].valueCode    = #trial-use
