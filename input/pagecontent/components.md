
The FHIR Topic-Based Subscription Model is composed of three parts:

* [Subscription Topic](#subscription-topics)
  * What is it?
    * Defines the **what** is used to trigger notifications
    * Defines the **filters** allowed to clients
    * Defines the **shape** of the notification
    * Always referenced by canonical URL
  * How is it defined?
    * The R4B 4.3.0 (or later) [SubscriptionTopic](http://hl7.org/fhir/subscriptiontopic.html) resource
* [Subscription](#subscriptions)
  * What is it?
    * Describes a request to be notified about events defined by a `SubscriptionTopic`
      * Canonical URL reference to a `SubscriptionTopic`
      * Set **filters** on events (as allowed in the referenced `SubscriptionTopic`)
    * Describe the `channel` and `endpoint` used to send notifications
    * Describe the **payload** included in notifications (MIME type, content level, etc.)
  * How is it defined?
    * The R4 4.0.0 (or later) [Subscription](http://hl7.org/fhir/subscription.html) resource, plus extensions
* [Notification Bundle](#subscription-notifications)
  * What is it?
    * Describes the contents of a notification
    * Contains zero or more notification **payloads**
  * How is it defined?
    * An R4 4.0.0 (or later) [Bundle](http://hl7.org/fhir/bundle.html) resource, type of `history`,
    * an R4B 4.3.0 (or later) [SubscriptionStatus](http://hl7.org/fhir/subscriptionstatus.html) resource, and
    * zero or more additional entries, either URLs (ids) or resources with full contents.

### Subscription Topics

The `SubscriptionTopic` resource is used to define conceptual or computable events for `Subscription` resources. Conceptually, subscription topics specify an event or change in data that is used to trigger a notification.  Topic definitions also include the boundaries around what a Subscription can filter for and additional resources that MAY be included with notifications.

For example, a topic may define that notifications should be sent when an `Encounter` is created or updated to have the specific value of `status=in-progress`.  The topic may also specify that filters may only be applied to the Patient (`Encounter.subject` where subject is a Patient) referenced by the Encounter, and that notifications may include the relevant Patient resource.

In order to support this functionality in R4, the [SubscriptionTopic](http://hl7.org/fhir/subscriptiontopic.html) resource has been added as to FHIR version 4.3.0.  Detailed information about the resource can be found on the HL7 FHIR website.

In order to make subscription topics more widely available, support for `SubscriptionTopic` resources is available via the [FHIR Registry](http://registry.fhir.org).

### Subscriptions

The `Subscription` resource is used to request notifications for a specific client about a specific topic. Conceptually, a subscription is a concrete request for a single client to receive notifications per a single topic.

For example, a subscription may ask for notifications based on an 'Encounter in-progress' topic, such as the one briefly described as an example in [Subscription Topics](#subscription-topics).  The subscription requires a link to the canonical URL of the topic, such as `http://server.example.org/fhir/subscriptiontopics/encounter-in-progress`, information about the channel, such as requesting notifications via `rest-hook` to the endpoint at `http://client.example.org/notification-endpoint/abc`), and payload configuration, such as requesting that bundles are encoded as `application/fhir+json` and include only identifiers (`id-only`).  Additionally, a subscription sets the filters which are applied to determine when notifications should be sent, such as indicating that only notifications for `Patient/123` should be sent.

In order to support topic-based subscriptions in R4, this guide defines several extensions for use on the [R4 Subscription](http://hl7.org/fhir/subscription.html) resource.  A list of extensions defined by this guide can be found on the [Artifacts](artifacts.html#3) page. Note that the future FHIR R5 publication may define capabilities included in this specification as cross-version extensions. Since the FHIR R5 is currently under development, there are no guarantees these extensions will meet the requirements of this guide. In order to promote widespread compatibility, cross version extensions SHOULD NOT be used on R4 subscriptions to describe any elements also described by this guide

In order to link a `Subscription` to a `SubscriptionTopic` and prevent any confusion between the R4 query-based and topic-based implementations, the link to a `SubscriptionTopic` is specified in the `Subscription.criteria` field.  For more details, please see the [Subscription Profile](StructureDefinition-backport-subscription.html) in this guide.

#### Accepting Subscription Requests

When a FHIR Server accepts a request to create a `Subscription`, the server is indicating to the client that the server:
* is capable of detecting when events covered by the requestion SubscriptionTopic occur, and
* is willing to make a simple best effort attempt at delivering a notification for each occurance of a matching event.

When processing a request for a `Subscription`, following are *some* checks that a server SHOULD validate:
* that the `SubscriptionTopic` is valid and implemented by the server
* that all requested filters are defined in the requested topic and are implemented in the server
* that the channel type is known and implemented by the server
* that the channel endpoint is valid for the channel provided (e.g., is it a valid URL of the expected type)
* that the payload configuration is known and implemented by the server
* that the payload configuration is valid for the channel type requested (e.g., complies with the server's security policy)

### Subscription Notifications

In FHIR R5, a new type of `Bundle` has been introduced, which uses the new `SubscriptionStatus` resource to convey status information in notifications.  For FHIR R4, notifications are instead based on a [history Bundle](http://hl7.org/fhir/bundle.html#history), and a [SubscriptionStatus](http://hl7.org/fhir/subscriptionstatus.html) resource is used to convey related meta-information (e.g., which subscription the notification is for).

Note that since notifications use `history` type Bundles, all notifications need to comply with the requirements for that bundle type.  Specifically, there are two invariants on Bundle (`bdl-3` and `bdl-4`) that require a `Bundle.entry.request` element for *every* `Bundle.entry`.
* For the status resource (`entry[0]`), the request SHALL be filled out to match a request to the `$status` operation.
* For additional entries, the request SHOULD be filled out in a way that makes sense given the subscription (e.g., a `POST` or `PUT` operation on the resource, etc.).  However, a server MAY choose to simply include a `GET` to the relevant resource instead.

#### Scoping Responsibilities

Unless otherwise specified by a server implementation and channel, the Subscriptions Framework does not involve guaranteed delivery of notifications. While the Subscriptions Framework is able to support such mechanisms, defining them are beyond the scope of the standard or this guide.

Servers SHOULD detect errors and take appropriate action where possible.  In general, this boundary is when the notification is delivered.  For example, during a REST-hook notification, the subscription server can detect errors up until the REST endpoint returns a HTTP status code (e.g., 200).  This does not imply that a client successfully processed (or even received) a notification - simply that the server has sent the notification successfully.

Therefore, clients SHOULD be aware of some limitations regarding delivery. In particular:
* Some notifications might not be delivered.
* Some notifications might be delivered multiple times.

In order to mitigate the impact from the above issues, the Subscriptions Framework includes mechanisms to detect both scenarios.  Details can be found on the [Errors Page](errors.html).
