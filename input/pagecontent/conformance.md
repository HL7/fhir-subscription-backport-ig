
FHIR Servers claiming conformance to this Implementation Guide must conform to the expectations described in the [Server CapabilityStatement](CapabilityStatement-backport-subscription-server.html).

Some options of the Subscriptions Framework are not easily expressed in a `CapabilityStatement`.  In addition to the basic support in the CapabilityStatement (e.g., resources, interactions, and operations), a conformant server SHALL support at least one [Payload Type](payloads.html) and SHOULD support one [Channel Type](channels.html) listed in this IG.

