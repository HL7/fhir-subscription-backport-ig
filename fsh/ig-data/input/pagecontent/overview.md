## Subscriptions Overview

Subscriptions are used to establish proactive event notifications from a FHIR application to another system.  The R5 version of the subscriptions framework aligns (in concept) with specifications such as [W3 WebSub](https://www.w3.org/TR/websub/).

...

### Components of a Subscription

The subscription mechanism is composed of three parts:

* Subscription Topics
  * Define the **data** and **change** used to trigger notifications
  * Define the **filters** allowed to clients
  * Always referenced by canonical URL
* Subscriptions
  * Describe a client's request to be notified about events defined by a `SubscriptionTopic`
  * Set **filters** on events (as defined in the referenced `SubscriptionTopic`)
  * Describe the `channel` and `endpoint` used to send notifications
  * Describe the **payload** included in notifications (MIME type, content level, etc.)
* Notification Bundles
  * Describe the contents of a notification
  * Contain zero or more notification **payloads**

Definitionally, a `Subscription` requires the a `SubscriptionTopic` - without a resource describing the change of interest, a `Subscription` has no meaning and will not trigger any client notifications.

While active, a `Subscription` relies on both [Bundle](http://hl7.org/fhir/bundle.html) and [Parameters](http://hl7.org/fhir/parameters.html) for sending notifications.

When using the `Subscription` resource, the FHIR server combines the roles of publisher and information distributer. Some arrangements of the 'publish and subscribe' pattern describe separate agents for the two roles. This specification makes no recommendations towards the internal architecture of server implementations.

### Subscription Topics

In FHIR R5, the `SubscriptionTopic` resource is used to define conceptual or computable events for `Subscription` resources. Conceptually, subscription topics specify: a type of **data** (e.g., `Observation`, `Condition`, etc.), a type of **change** (e.g., create, delete, update, etc.), and a set of allowed **filters**.

In order to limit the scope of this Implementation Guide, `SubscriptionTopic` definitions are not defined here.  Since topics are always referenced by their canonical URL, servers using FHIR R4 have no need to implement any of the functionality around topics themselves.

In order to support discovery of which topics a server supports (a key feature of R5 subscriptions), the [Subscription/$topic-list](OperationDefinition-Backport-subscriptiontopic-list.html) operation has been defined.

### Subscriptions

The `Subscription` resource is used to request notifications for a specific client about a specific topic. Conceptually, a subscription specifies: a **topic** (`SubscriptionTopic`, by canonical URL), the notification **channel** (e.g., REST, websockets, email, etc.), and the notification **payload** (e.g., MIME type, amount of detail, etc.).

When a FHIR Server accepts a request to create a `Subscription`, the server is indicating to the client that the server:
* is capable of detecting when events covered by the requestion SubscriptionTopic occur, and
* is willing to make a simple best effort  attempt at delivering a notification for each occurance of a matching event.

In order to add the functionality of R5 subscriptions to the [R4 Subscription](http://hl7.org/fhir/subscription.html) resource, this guide defines several extensions.  A list of extensions defined by this guide can be found on the [Artifacts](artifacts.html#structures-extension-definitions) page.

### Subscription Notifications

In FHIR R5, a new type of `Bundle` has been introduced, which uses the new `SubscriptionStatus` resource to convey status information in notifications.  For FHIR R4, notifications are instead based on a [history Bundle](http://hl7.org/fhir/bundle.html#history), and a [Parameters](http://hl7.org/fhir/parameters.html) resource is used to convey meta-information.

Unless otherwise specified by a server implementation and channel, the Subscriptions Framework does not involve guaranteed  delivery of notifications. While the Subscriptions Framework is able to support such mechanisms, defining them are beyond the scope of the standard.

Subscribers should be aware of some limitations regarding delivery. In particular:

* Some notifications might not be delivered.
* Some notifications might be delivered multiple times.
* In order to mitigate the impact from the above issues, the Subscriptions Framework includes mechanisms to detect both scenarios.

### Safety and Security

Applications are responsible for following [FHIR security guidance](http://hl7.org/fhir/security.html). Some recommendations specific to subscriptions are provided below.

A subscription is a request for future event notifications. As with any client-initiated interaction, a `Subscription` could request information a client is not allowed to see. Applications SHALL enforce authorization in accordance with their policy requirements. Applications SHOULD take a subscription's topic and filters into account when authorizing the creation of a `Subscription`, and SHOULD ensure that authorization is (still) in place when sending any event notifications.

When sending an event notification, applications can adopt various strategies to ensure that authorization is still in place. Some strategies may provide imperfect assurance (e.g., a server might rely on signed tokens with some pre-specified lifetime as evidence of authorization). In addition to these strategies, servers can mitigate the risk of disclosing sensitive information by limiting the payload types it supports (e.g., by prohibiting certain clients from requesting `full-resource` notification payloads and relying instead on `id-only` payloads).

`Subscription` resources are not intended to be secure storage for secrets (e.g., OAuth Client ID or Tokens, etc.). Implementers MAY use their judgement on including limited-use secrets (e.g., a token supplied in Subscription.header to verify that a message is from the desired source).

Each notification sent by the application could reveal information about the application and subscriber relationship, as well as sensitive administrative or clinical information. Applications are responsible for ensuring appropriate security is employed for each channel they support. The `Subscription` resource does not address these concerns directly; it is assumed that these are administered by other configuration processes. For instance, an application might maintain a whitelist of acceptable endpoints or trusted certificate authorities for rest-hook channels.

Some topic and server implementation combinations may trigger internal notification workflows when notifications should NOT be sent. For example, if a topic is designed around `Observation` resources being removed (e.g., deleted), an implementation may be triggered if an `Observation` is moved to a higher security level and is no longer available to a user. These types of situations are implementation-specific, so this note is to raise awareness of potential pitfalls when implementing subscriptions.

Subscribers should ensure an appropriate process to validate incoming messages. For example, if the `full-resource` content type is used, clients should provide a header or some other secret to the server so that messages can be verified prior to being used for health decisions. Using content types of `empty` or `id-only` can mitigate this risk, as resources must be retrieved from a trusted location prior to use.

Subscribers should be aware of, and protect against, the possibility of being used as part of an attack on a FHIR server. For example, a malicious client may send a large volume of fake notifications with `empty` notifications, which would cause the subscriber to send many (potentially expensive) queries to a server.
