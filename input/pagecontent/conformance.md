
This page defines how CapabilityStatements are used and the expectations for mandatory and must support elements. A conformant system SHALL support the resources as profiled by this guide.

Note that the conformance verbs - SHALL, SHOULD, MAY - used in this guide are defined by the [FHIR Conformance Rules](http://hl7.org/fhir/conformance-rules.html).

### Conformance Artifacts

FHIR Servers claiming conformance to this Implementation Guide must conform to the expectations described in the [Server CapabilityStatement](CapabilityStatement-backport-subscription-server.html).

Some options of the Subscriptions Framework are not easily expressed in a `CapabilityStatement`.  In addition to the basic support in the CapabilityStatement (e.g., resources, interactions, and operations), a conformant server SHALL support at least one [Payload Type](payloads.html) and SHOULD support one [Channel Type](channels.html) listed in this IG.

Note that the future publication of FHIR R5 may define capabilities included in this specification as cross-version extensions. Since FHIR R5 is currently under development, there are no guarantees these extensions will meet the requirements of this guide. In order to promote widespread compatibility, cross version extensions SHOULD NOT be used on R4 subscriptions to describe any elements described by this guide.

#### Profile Support
Profile Support refers to the support of the profiles defined in this guide, such that the system exposes FHIR resources which adhere to the profiles' content model. Specifically, a conformant server:
* SHALL communicate all profile data elements that are mandatory by that profile’s StructureDefinition. 
* SHOULD declare conformance with the Backport Subscription Server Capability Statement by including its official URL in the server’s `CapabilityStatement.instantiates` element: `http://hl7.org/fhir/uv/subscriptions-backport/CapabilityStatement/CapabilitySubscriptionServer`
* SHALL specify the full capability details from the CapabilityStatement it claims to implement, including declaring support for the Backported Subscription Profile by including its official URL in the server’s `CapabilityStatement.rest.resource.supportedProfile` element

Note that the Backported Subscription Profile’s official or “canonical” URL can be found on the profile page.

#### Interaction Support
Interaction Support refers to a system that support RESTful interactions. Specifically, a server with Interaction Support:
* SHALL implement the RESTful behavior according to the FHIR specification, including Read and Search behavior and required search parameters as defined in the [Server CapabilityStatement](CapabilityStatement-backport-subscription-server.html).
* SHALL specify the full capability details from the CapabilityStatement it claims to implement, including declaring support for the Profile’s FHIR RESTful transactions.

### Must-support
In the context of this guide, Supported on any data element SHALL be interpreted to mean [FHIR's MustSupport](https://www.hl7.org/fhir/conformance-rules.html#mustSupport), though additional implementation guides may provide further guidance. 

In situations where information on a particular data element is not present and the reason for absence is unknown, Responders SHALL NOT include the data elements in the resource instance returned as part of the query results. Conversely, Requestors SHALL be able to process resource instances containing data elements asserting missing information.
