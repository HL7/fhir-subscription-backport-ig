RuleSet:       OperationCommon
* jurisdiction        = http://unstats.un.org/unsd/methods/m49/m49.htm#001
* status              = #active
* date                = "2020-11-30"
* publisher           = "HL7 International - FHIR Infrastructure Work Group"
* contact[0].telecom[0].system = #url
* contact[0].telecom[0].value  = "https://hl7.org/Special/committees/fiwg/index.cfm"
* version             = "0.1.1"
* kind                = #operation
* extension[0].url          = "http://hl7.org/fhir/StructureDefinition/structuredefinition-fmm"
* extension[0].valueInteger = 0
* extension[1].url          = "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status"
* extension[1].valueCode    = #trial-use


Instance:      OperationBackportSubscriptionStatus
InstanceOf:    OperationDefinition
Usage:         #definition
Title:         "Backport Subscription Status Operation"
Description:   "This operation is used to return the current status information about one or more backported R5-Style Subscriptions in R4."
* id            = "backport-subscription-status"
* name          = "R5SubscriptionStatus"
* description   = "This operation is used to return the current status information about one or more backported R5-Style Subscriptions in R4."
* insert OperationCommon
* system        = false
* type          = true
* instance      = false
* code          = #status
* resource[0]   = #Subscription
* parameter[0].name          = #ids
* parameter[0].use           = #in
* parameter[0].min           = 0
* parameter[0].max           = "*"
* parameter[0].documentation = "At the Resource level, one or more parameters containing one or more comma-delimited FHIR ids of Subscriptions to get status information for.  In the absense of any specified ids, the server returns the status for all Subscriptions available to the caller.  At the Instance level, this parameter is ignored."
* parameter[0].type          = #id
* parameter[1].name          = #return
* parameter[1].use           = #out
* parameter[1].min           = 1
* parameter[1].max           = "1"
* parameter[1].documentation = "The bundle type is \"searchset\". The operation returns a bundle containing one or more Parameters resources, compliant with \"backport-subscriptionstatus\", one per Subscription being queried."
* parameter[1].type          = #Bundle


Instance:      OperationBackportSubscriptionTopicList
InstanceOf:    OperationDefinition
Usage:         #definition
Title:         "Backport Subscription Topic List Operation"
Description:   "This operation is used to return the current list of R5 SubscriptionTopics in a Backported-R4 environment."
* id            = "backport-subscriptiontopic-list"
* name          = "R5SubscriptionTopicList"
* description   = "This operation is used to return the current list of R5 SubscriptionTopics in a Backported-R4 environment."
* insert OperationCommon
* system        = false
* type          = true
* instance      = false
* code          = #topic-list
* resource[0]   = #Subscription
* parameter[0].name          = #urls
* parameter[0].use           = #in
* parameter[0].min           = 0
* parameter[0].max           = "*"
* parameter[0].documentation = "If present, one or more parameters each containing exactly one Canonical SubscriptionTopic URL to search for."
* parameter[0].type          = #uri
* parameter[1].name          = #return
* parameter[1].use           = #out
* parameter[1].min           = 1
* parameter[1].max           = "1"
* parameter[1].documentation = "The operation returns a Parameters resource compliant with the \"backport-subscription-topic-list\" profile, representing supported SubscriptionTopics for the server by their canonical URLs."
* parameter[1].type          = #Parameters
