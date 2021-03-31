
The subscription mechanism is composed of three parts:

* [Subscription Topic](#subscription-topics)
  * What is it?
    * Defines the **data** and **change** used to trigger notifications
    * Defines the **filters** allowed to clients
    * Always referenced by canonical URL
  * How is it defined?
    * Implicitly defined in R4 (use canonical URLs)
* [Subscription](#subscriptions)
  * What is it?
    * Describes a request to be notified about events defined by a `SubscriptionTopic`
      * Canonical URL link to a `SubscriptionTopic`
      * Set **filters** on events (as allowed in the referenced `SubscriptionTopic`)
    * Describe the `channel` and `endpoint` used to send notifications
    * Describe the **payload** included in notifications (MIME type, content level, etc.)
  * How is it defined?
    * Uses the existing R4 [Subscription](http://hl7.org/fhir/subscription.html) resource with extensions
* [Notification Bundle](#subscription-notifications)
  * What is it?
    * Describes the contents of a notification
    * Contains zero or more notification **payloads**
  * How is it defined?
    * Uses the existing R4 [Bundle](http://hl7.org/fhir/bundle.html) resource (with type of `history`)
    * Uses the R4 [Parameters](http://hl7.org/fhir/parameters.html) resource to convey subscription information

### Subscription Topics

In FHIR R5, the `SubscriptionTopic` resource is used to define conceptual or computable events for `Subscription` resources. Conceptually, subscription topics specify: a type of **data** (e.g., `Observation`, `Condition`, etc.), a type of **change** (e.g., create, delete, update, etc.), and a set of allowed **filters**.

In order to limit the scope of this Implementation Guide, a definition of `SubscriptionTopic` is not provided.  Since topics are only referenced by their canonical URL, servers using FHIR R4 have no need to implement any of the functionality around topics themselves. E.g., even though the definition itself will not be representable in R4, a canonical URL for an R5 `SubscriptionTopic` can be used.

In order to support discovery of which topics a server supports (a key feature of R5 subscriptions), the [Subscription/$topic-list](OperationDefinition-Backport-subscriptiontopic-list.html) operation has been defined.

### Subscriptions

The `Subscription` resource is used to request notifications for a specific client about a specific topic. Conceptually, a subscription specifies: a **topic** (`SubscriptionTopic`, by canonical URL), the notification **channel** (e.g., REST, websockets, email, etc.), and the notification **payload** (e.g., MIME type, amount of detail, etc.).

When a FHIR Server accepts a request to create a `Subscription`, the server is indicating to the client that the server:
* is capable of detecting when events covered by the requestion SubscriptionTopic occur, and
* is willing to make a simple best effort  attempt at delivering a notification for each occurance of a matching event.

In order to add the functionality of R5 subscriptions to the [R4 Subscription](http://hl7.org/fhir/subscription.html) resource, this guide defines several extensions.  A list of extensions defined by this guide can be found on the [Artifacts](artifacts.html#3) page.

### Subscription Notifications

In FHIR R5, a new type of `Bundle` has been introduced, which uses the new `SubscriptionStatus` resource to convey status information in notifications.  For FHIR R4, notifications are instead based on a [history Bundle](http://hl7.org/fhir/bundle.html#history), and a [Parameters](http://hl7.org/fhir/parameters.html) resource is used to convey meta-information.

Since notifications use `history` type Bundles, a few additional elements are required.  Specifically, in order to meet the requirements of `bdl-3` and `bdl-4`, `Bundle.entry.request` must exist for each entry.  For the status resource (`entry[0]`), the request SHALL filled out to match a request to the `$status` operation.

For additional entries, the request SHOULD be filled out in a way that makes sense given the subscription (e.g., a `POST` or `PUT` operation on the resource, etc.).  However, a server MAY choose to simply include a `GET` to the relevant resource instead.

Unless otherwise specified by a server implementation and channel, the Subscriptions Framework does not involve guaranteed  delivery of notifications. While the Subscriptions Framework is able to support such mechanisms, defining them are beyond the scope of the standard.

Clients should be aware of some limitations regarding delivery. In particular:

* Some notifications might not be delivered.
* Some notifications might be delivered multiple times.
* In order to mitigate the impact from the above issues, the Subscriptions Framework includes mechanisms to detect both scenarios.
