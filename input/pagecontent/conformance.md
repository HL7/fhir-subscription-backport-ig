
This page defines how CapabilityStatements are used and the expectations for mandatory and must support elements. A conformant system SHALL support the resources as profiled by this guide.

Note that the conformance verbs - SHALL, SHOULD, MAY - used in this guide are defined by the [FHIR Conformance Rules](http://hl7.org/fhir/conformance-rules.html).

In order to claim conformance with this guide, a server:
* SHALL support the `Subscription` resource (read/write).
* SHALL support the `$status` operation on the `Subscription` resource.
* SHALL support the `SubscriptionTopic` resource (read/search).
* SHALL support at least one channel type, and SHOULD include one from this guide
* SHALL support at least one Payload Type

### Conformance Artifacts
FHIR Servers claiming conformance to this Implementation Guide must conform to the expectations described in the [Server CapabilityStatement](CapabilityStatement-backport-subscription-server.html).

Some options of the Subscriptions Framework are not easily expressed in a `CapabilityStatement`.  In addition to the basic support in the CapabilityStatement (e.g., resources, interactions, and operations), a conformant server SHALL support at least one [Payload Type](payloads.html) and SHOULD support one [Channel Type](channels.html) listed in this IG.

Note that the future publication of FHIR R5 may define capabilities included in this specification as cross-version extensions. Since FHIR R5 is currently under development, there are no guarantees these extensions will meet the requirements of this guide. In order to promote widespread compatibility, cross version extensions SHOULD NOT be used on R4 subscriptions to describe any elements described by this guide.

#### Profile Support
Profile Support refers to the support of the profiles defined in this guide in a system exposing FHIR resources. Specifically, a conformant server:
* SHALL communicate all profile data elements that are mandatory by that profile's StructureDefinition. 
* SHOULD declare conformance with the Backport Subscription Server Capability Statement by including its official URL in the server's `CapabilityStatement.instantiates` element: `http://hl7.org/fhir/uv/subscriptions-backport/CapabilityStatement/CapabilitySubscriptionServer`
* SHALL specify the full capability details from the CapabilityStatement it claims to implement, including declaring support for the Backported Subscription Profile by including its official URL in the server's `CapabilityStatement.rest.resource.supportedProfile` element

Note that the Backported Subscription Profile's official or "canonical" URL can be found on the profile page.


### Must-support
In this guide, some elements are marked as [Must Support](https://www.hl7.org/fhir/conformance-rules.html#mustSupport). Elements that are flagged as MS are enumerated below, with details on what support means.


#### backport-channel-type
The [backport-channel-type](StructureDefinition-backport-channel-type.html) extension is used to allow for custom channels not described in this guide.

##### Server Support
Servers supporting this guide SHALL be able to read values present in this element.  A server SHALL reject the subscription request if a client requests an unsupported channel via this element.

##### Client Support
Clients supporting this guide MAY support this extension, as necessary for their use case.


#### backport-filter-criteria
The [backport-filter-critiera](StructureDefinition-backport-filter-criteria.html) extension is used to describe the actual filters used in a specific instance of a subscription.

##### Server Support
Servers supporting this guide SHALL be able to read values in this extension and SHALL be able to apply filters as described by any Subscription Topics the server advertises support for.

If a server is capable of supporting filter critiera in general but unable to support criteria requested in a subscription, the server SHALL reject the subscription.

##### Client Support
Clients supporting this guide SHALL be able to write values in this extension.


#### backport-payload-content
The [backport-payload-content](StructureDefinition-backport-payload-content.html) extension is used to decribe the amount of detail included in notification payloads.

##### Server Support
Servers supporting this guide SHALL be able to read values from this extension.  A server SHALL reject the subscription request if a client asks for a content level the server does not intend to support (e.g., does not meet security requirements).  Servers SHALL include information in notifications as described in this guide based on this value.

##### Client Support
Clients supporting this guide SHALL be able to write values in this extension.


#### Notification entry: SubscriptionStatus
Notification bundles SHALL contain a `SubscriptionStatus` as the first entry.

##### Server Support
Servers supporting this guide SHALL be able to generate a valid and correct `SubscriptionStatus` resource for each notification.  The status entry SHALL be the first entry of each notification bundle.

##### Client Support
Clients supporting this guide SHALL be able to process a valid `SubscriptionStatus` resource without errors.


#### Subscription.criteria
The `Subscription.criteria` element is required (cardinality of 1..1), so any compatible implementation SHALL be able to read and/or write as necessary.  Compared with the core specification, this guide specifies that the element SHALL contain the canonical URL for the Subscription Topic.

##### Server Support
Servers supporting this guide SHALL be able to read values in this element and process requests for subscription topics referenced by it.  If a server does not support a requested topic or will not honor the subscription otherwise, a server SHALL reject the subscription request.

##### Client Support
Clients supporting this guide SHALL be able to write subscription topic URLs into this element.
