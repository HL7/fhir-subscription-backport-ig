Extension:   BackportRelatedQuery
Id:          backport-related-query
Title:       "Related query information"
Description: "Combination of coded information and query for information related to a notification event."
* insert StructureJurisdiction
* . 0..*
* insert ExtensionContext(SubscriptionStatus.notificationEvent)
* insert ExtensionContext(SubscriptionTopic.notificationShape)
* insert ExtensionContext(Basic.extension)
* insert ExtensionContext(Basic.modifierExtension)
* insert ExtensionContext(Basic.modifierExtension.extension)
// * insert ExtensionContext(Element)
* extension contains
    queryType 0..1 MS and
    query 0..1 MS
* extension[queryType] ^short = "Type of query."
* extension[queryType] ^definition = "Coded value used to describe the type of information this query can be used to retrieve."
* extension[queryType].value[x] only Coding
* extension[query] ^short = "URL for a query."
* extension[query] ^definition = "URL used via HTTP GET to perform the query."
* extension[query].value[x] only string


// -----------------------------------------------------------------------------
// The following extensions are *consumed* by the cross-version packages for
// backwards compatibility with existing implementations. Changes should be 
// considered carefully and discussed with FHIR-I in detail.
// Note that we use the R5 CodeSystems via the cross-version packages to avoid
// duplication of terminology content and prevent drift.
// -----------------------------------------------------------------------------

ValueSet:    BackportContentValueSet
Id:          backport-content-value-set
Title:       "Backported R5 Subscription Content Value Set"
Description: "Codes to represent how much resource content to send in the notification payload."
* insert StructureJurisdiction
* . 0..*
* ^experimental   = false
* codes from system http://hl7.org/fhir/subscription-payload-content|5.0.0

Extension:   BackportPayloadContent
Id:          backport-payload-content
Title:       "Backported R5 Subscription Payload Content"
Description: "How much of the resource content to deliver in the notification payload. The choices are an empty payload, only the resource id, or the full resource content."
* insert StructureJurisdiction
* . 0..*
* insert ExtensionContext(Subscription)
* value[x] only code
* valueCode from BackportContentValueSet (required)
* value[x] ^short      = "Notification content level"
* value[x] ^definition = "How much of the resource content to deliver in the notification payload. The choices are an empty payload, only the resource id, or the full resource content."
* value[x] ^comment    = "Sending the payload has obvious security implications. The server is responsible for ensuring that the content is appropriately secured."

Extension:   BackportHeartbeatPeriod
Id:          backport-heartbeat-period
Title:       "Backported R5 Subscription Heartbeat Period"
Description: "Interval in seconds to send 'heartbeat' notifications."
* insert StructureJurisdiction
* . 0..*
* insert ExtensionContext(Subscription)
* value[x] only unsignedInt
* value[x] ^short      = "Interval in seconds to send 'heartbeat' notification"
* value[x] ^definition = "If present, a 'heartbeat' notification (keep-alive) is sent via this channel with an interval period equal to this element's integer value in seconds. If not present, a heartbeat notification is not sent."

Extension:   BackportTimeout
Id:          backport-timeout
Title:       "Backported R5 Subscription Timeout"
Description: "Timeout in seconds to attempt notification delivery."
* insert StructureJurisdiction
* . 0..*
* insert ExtensionContext(Subscription)
* value[x] only unsignedInt
* value[x] ^short      = "Timeout in seconds to attempt notification delivery"
* value[x] ^definition = "If present, the maximum amount of time a server will allow before failing a notification attempt."

Extension:   BackportMaxCount
Id:          backport-max-count
Title:       "Backported R5 Subscription MaxCount"
Description: "Maximum number of triggering resources included in notification bundles."
* insert StructureJurisdiction
* . 0..*
* insert ExtensionContext(Subscription)
* value[x] only positiveInt
* value[x] ^short      = "Maximum number of triggering resources included in notification bundles"
* value[x] ^definition = "If present, the maximum number of triggering resources that will be included in a notification bundle. Note that this is not a strict limit on the number of entries in a bundle, as dependent resources can be included."

Extension:   BackportChannelType
Id:          backport-channel-type
Title:       "Backported R5 Subscription Additional Channel Type"
Description: "Additional channel types not defined before FHIR R5."
* insert StructureJurisdiction
* . 0..*
* insert ExtensionContext(Subscription.channel.type)
* value[x] only Coding
* value[x] ^short      = "Extended channel type for notifications"
* value[x] ^definition = "The type of channel to send notifications on."
* value[x] ^comment    = "This extension allows for the use of additional channel types that were not defined in the FHIR R4 subscription definition."