Extension:   NotificationRelatedQuery
Id:          notification-related-query
Title:       "FHIR query to retrieve data about a notification"
Description: "A FHIR query fragment and related context information that can be used to retrieve resources related to a notification."
* insert StructureJurisdiction
* insert ExtensionContext(SubscriptionStatus.notificationEvent)
* insert ExtensionContext(SubscriptionTopic.notificationShape)
* extension contains
    queryType 0..1 MS and
    query 1..1 MS
* extension[queryType].value[x] only Coding
* extension[query].value[x] only string
* insert ExtensionDefinition(
    queryType,
    "Query Type",
    "Information used by clients to determine if a query should be run and what type of data it returns.")
* insert ExtensionDefinition(
    query,
    "Query",
    "The query to be performed. This is a FHIR search query rooted in a resource identified in a Subscription Topic.")

// Questions:
// - How do we describe/relate/restrict queries in topics?
//      e.g., do we list them in a topic?  
//      If so, how do we split out things like _include?
//      If not, how does a server implemter know what queries are expected?
// - How are queries restricted / filtered?  I do not think we can use *only* token-based restrictions in core FHIR.
//      e.g., in example 
//Coverage?_include=Coverage:payor:Organization
//  &_include=Coverage:payor:Patient 
// what filters are automatically applied and how do we make this compatible with existing filter mechanisms?

// Shared screen: https://meet.jit.si/fhir

// Please sign-in: https://bit.ly/fhiri
// (google sheet - if you cannot access, just ask)
// Name is there if you have been to FHIR-I, otherwise add at the bottom please!
