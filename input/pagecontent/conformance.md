
FHIR Servers claiming conformance to this Implementation Guide must conform to the expectations described in the [Server CapabilityStatement](CapabilityStatement-backport-subscription-server.html).

Some options of the Subscriptions Framework are not easily expressed in a `CapabilityStatement`.  In addition to the basic support in the CapabilityStatement (e.g., resources, interactions, and operations), a conformant server SHALL support at least one [Payload Type](payloads.html) and SHOULD support one [Channel Type](channels.html) listed in this IG.

Note that the future FHIR R5 publication may define capabilities included in this specification as cross-version extensions. Since the FHIR R5 is currently under development, there are no guarantees these extensions will meet the requirements of this guide. In order to promote widespread compatibility, cross version extensions SHOULD NOT be used on R4 subscriptions to describe any elements also described by this guide