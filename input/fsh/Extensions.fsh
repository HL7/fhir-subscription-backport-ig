Extension:   BackportRelatedQuery
Id:          backport-related-query
Title:       "Related query information"
Description: "Combination of coded information and query for information related to a notification event."
* insert StructureJurisdiction
* insert ExtensionContext(SubscriptionStatus.notificationEvent)
* insert ExtensionContext(SubscriptionTopic.notificationShape)
* insert ExtensionContext(Basic.extension)
// * insert ExtensionContext(Element)
* extension contains
    queryType 0..1 MS and
    query 1..1 MS
* extension[queryType] ^short = "Type of query."
* extension[queryType] ^definition = "Coded value used to describe the type of information this query can be used to retrieve."
* extension[queryType].value[x] only Coding
* extension[query] ^short = "URL for a query."
* extension[query] ^definition = "URL used via HTTP GET to perform the query."
* extension[query].value[x] only string
