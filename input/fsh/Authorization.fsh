Extension:   NotificationAuthorizationHint
Id:          notification-authorization-hint
Title:       "Authorization information relevant to a notification"
Description: "Authorization context information and value (e.g., token)."
* insert StructureJurisdiction
* insert ExtensionContext(SubscriptionStatus.notificationEvent)
* insert ExtensionContext(Basic.extension)
* insert ExtensionContext(Basic.modifierExtension)
* insert ExtensionContext(Basic.modifierExtension.extension)
* extension contains
    type 1..1 MS and
    value 0..1 MS
* extension[type] ^short = "Authorization Type"
* extension[type] ^definition = "Used by clients to determine what kind of authorization is appropriate in this context."
* extension[type].value[x] only Coding
* extension[value] ^short = "Authorization Value"
* extension[value] ^definition = "A value related to the authorization (e.g., a token)."
* extension[value].value[x] only string
