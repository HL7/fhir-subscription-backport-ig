### What are Subscriptions?

The Subscriptions Framework is a mechanism designed to allow clients to ask for notifications when data changes.  It is an active notification system; a FHIR server actively sends notifications to clients as changes occur.

### Query-Defined Subscriptions (DSTU2 - R4)

There is a defined [Subscription](http://hl7.org/fhir/r4/subscription.html) resource in FHIR R4, which has been in place since DSTU2.  In those releases of FHIR, subscriptions are defined by a client dynamically by posting a Subscription resource with a criteria string. The FHIR server must then run a query against that criteria and track the query result-set for each subscription request.  Each time a change to the server's data is made, a server must re-run the query and send notifications to clients if their result-set changes (e.g., a new entry is added or removed).

The above approach works well for some use cases, but has issues which prevent it from being used in others.  Some of the issues identified include:
* Difficulty implementing the server-side logic at scale (both in terms of large datasets and many clients).
* An opaque discovery process (e.g., servers that had restrictions on queries had no way to advertise them).
* Lack of granularity in events (e.g., it was unclear why something was removed from a dataset).
* No ability to bundle notifications (e.g., servers had to send a single notification for each discrete event).
* Notifications required clients to re-query after receiving a notification.

While some of the issues would be addressable with modifications to the existing `Subscription` resource, the FHIR Infrastructure Work Group felt that more extensive changes were needed, and so started a redesign of Subscriptions for R5.

### Topic-Based Subscriptions - R5 and Later

More than a year of focused work resulted in a new design for Subscriptions in FHIR.  The redesign focused on three main areas:

1. Moving to a topic-based model, with the defintion of a `SubscriptionTopic` resource.
1. Changing the `Subscription` resource to add clarity and flexibility.
1. Restructuring notifications by adding a new `Bundle` type.

The implementer response to these changes has been overwhelmingly positive - changes to the mechanism address the issues identified and retain all of the existing functionality.  However, many of the changes cannot be made to the FHIR specifications until the release of R5.  Implementers have expressed concern that the publication and adoption of FHIR R5 are too far in the future.

### Topic-Based Subscriptions - R4 4.1.0 and Later

In order to provide topic-based subscription support in FHIR R4, this Implementation Guide supplements additions made to FHIR R4 4.1.0 to support the new FHIR R5 topic-based subscriptions.  Wherever possible, this guide tries to align with FHIR R5 to lower implementer burden, however some differences are unavoidable.

### Boundaries and Relationships

#### Relation to FHIRcast

[FHIRcast](http://fhircast.org) is a framework for user-activity synchronization across applications.  FHIRcast and Subscription are both conceptually based [W3 WebSub](https://www.w3.org/TR/websub/), and while the mechanics of two projects look similar, they are fundamentally different projects used to address different use cases.  In particular:

1. What Is Communicated
    * FHIRcast is primarily concerned with context syncrhonization.
    * Subscriptions are focused on content synchonization.

1. User Interaction
    * FHIRcast is designed to be used by multiple applications perhaps with the same user and typically on the same device.
    * Subscriptions are designed to be used by multiple distinct systems, often outside of a user workflow.

1. Session Duration
    * FHIRcast is designed around short-lived sessions.
    * Subscriptions are intented to be long-lived resources.

1. Event Frequency
    * FHIRcast sends only single-event notifications.
    * Subscriptions allow servers to batch multiple notifications in high-frequency scenarios.

#### Relation to FHIR Messaging

FHIR [Messaging](http://hl7.org/fhir/messaging.html) is a message-based protocol which can be used for communication. When combining Messaging and Subscriptions, complete notifications are wrapped into Messaging Bundles.  More details are provided on the [channels page](channels.html#fhir-messaging).

### This IG

In response to requests for a way to use "R5-style" subscriptions in earlier versions of FHIR, this Implementation Guide has been authored.  The goal is to provide a standard set of artifacts and extensions so that consistent behavior can be achieved prior to the release and adoption of FHIR R5.