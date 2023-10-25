Extension:   NotificationSecurity
Id:          notification-security
Title:       "Security information for retrieving notification content"
Description: "Security context information and value (e.g., token)."
* insert StructureJurisdiction
* insert ExtensionContext(SubscriptionStatus.notificationEvent)
* extension contains
    securityType 1..1 MS and
    securityToken 0..1 MS
* extension[securityType].value[x] only Coding
* extension[securityType].valueCoding from SubscriptionSecurityTypeValueSet (extensible)
* extension[securityToken].value[x] only string
* insert ExtensionDefinition(
    securityType,
    "Security Type",
    "Information used by clients to determine what kind of security is required to follow-up with notifications.")
* insert ExtensionDefinition(
    securityToken,
    "Security Token",
    "Security token used to authenticate requests.")

CodeSystem:  SubscriptionSecurityTypeCodeSystem
Id:          subscription-security-type-code-system
Title:       "Subscription notification security types Code System"
Description: "Codes to represent different authentication options clients should use in order to retrieve content from a notification."
* insert StructureJurisdiction
* ^caseSensitive  = true
* ^experimental   = false
* #smart-launch  "SMART App Launch"       "Recipients must connect via a SMART App Launch."
* #smart-backend "SMART Backend Services" "Recipient systems must connect via SMART backend services."
* #bearer-token  "Bearer Token"           "Recipients must use the included Bearer token."
* #jwt-token     "JWT Token"              "Recipients must use the included JWT token."
* #saml-token    "SAML Token"             "Recipients must use the included SAML token."
* #mtls          "mTLS"                   "Recipients must use mTLS."
* #opaque-token  "Opaque Token"           "Recipients must use the included opaque token."

ValueSet:    SubscriptionSecurityTypeValueSet
Id:          subscription-security-type-value-set
Title:       "Subscription notification security types Value Set"
Description: "Codes to represent different authentication options clients should use in order to retrieve content from a notification."
* insert StructureJurisdiction
* ^experimental   = false
* codes from system SubscriptionSecurityTypeCodeSystem


// Questions:
// - What/how many options are considered 'core'?  E.g., SMART App Launch / Backend services, JWT, Bearer, SAML, mTLS?
// - Do we want to include an option for encrypted payloads?
//      i.e., The entire resource is transacted in the notification payload, and needs to be decrypted by the client with a private key.
// - Can we leave a token for a single session with all queries, or do we need to include a token for each query?