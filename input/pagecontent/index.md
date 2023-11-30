The Subscription R5 Backport Implementation Guide enables servers running versions of FHIR earlier than R5 to implement a subset of R5 Subscriptions in a standardized way.

### About This Guide

During the development of FHIR R5, the Subscriptions Framework has gone through a significant redesign.  Many implementers have expressed a need for functionality from the FHIR R5 version of Subscriptions to be made available in FHIR R4.

The goal of publishing this guide is to define a standard method of back-porting the R5 Subscriptions Framework for greater compatibility and adoption.

### What are Subscriptions?

The Subscriptions Framework is a mechanism designed to allow clients to ask for notifications when data changes.  It is an active notification system; a FHIR server actively sends notifications to clients as changes occur.

### Query-Defined Subscriptions (DSTU2 - R4)

There is a defined [Subscription](http://hl7.org/fhir/r4/subscription.html) resource in FHIR R4 that has been in place since DSTU2.  In those releases of FHIR, subscriptions are defined by a client dynamically by posting a Subscription resource with a criteria string. The FHIR server must then run a query against that criteria and track the query result-set for each subscription request.  Each time a change to the server's data is made, a server must re-run the query and send notifications to clients if their result-set changes (e.g., a new entry is added or removed).

The above approach works well for some use cases, but has issues which prevent it from being used in others.  Some of the issues identified include:
* Difficulty implementing the server-side logic at scale (both in terms of large datasets and many clients).
* An opaque discovery process (e.g., servers that had restrictions on queries had no way to advertise them).
* Lack of granularity in events (e.g., it was unclear why something was removed from a dataset).
* No ability to bundle notifications (e.g., servers had to send a single notification for each discrete event).
* Notifications required clients to re-query after receiving a notification.

Some of the issues would be addressable with modifications to the existing `Subscription` resource, but the FHIR Infrastructure Work Group felt that more extensive changes were needed, and so started a redesign of Subscriptions for R5.

### Topic-Based Subscriptions - FHIR R5 and Later

More than a year of focused work resulted in a new design for Subscriptions in FHIR.  The redesign focused on three main areas:

1. Moving to a topic-based model, with the definition of a `SubscriptionTopic` resource.
1. Changing the `Subscription` resource to add clarity and flexibility.
1. Restructuring notifications by adding a new `Bundle` type.

The implementer response to these changes has been positive - changes to the mechanism address the issues identified and retain all of the existing functionality.  However, many of the changes cannot be made to the FHIR specifications until the release of R5.  Implementers have expressed concern that the publication and adoption of FHIR R5 are too far in the future.

### Topic-Based Subscriptions - FHIR R4B and Later

With the publication of [FHIR R4B](https://hl7.org/fhir/R4B/), there was an opportunity to add some of the models designed for FHIR R5 into a FHIR R4-series.  Wherever possible, both those additions and this guide tries to align with FHIR R5 to lower implementer burden, however some differences are unavoidable.

In the context of FHIR R4B, this guide bridges the gap between what could be added in a [minor release](https://hl7.org/fhir/versions.html#versions) and the changes made in R5.

In order to provide topic-based subscription support in FHIR R4, this Implementation Guide supplements additions made to FHIR R4B to support the new topic-based subscriptions model.  Wherever possible, this guide tries to align with FHIR R5 to lower implementer burden, however some differences are unavoidable.

### Topic-Based Subscriptions - FHIR R4

In order to provide topic-based subscription support in FHIR R4, this Implementation Guide defines FHIR artifacts (e.g., Operations, Extensions, Profiles, etc.) to extend the existing subscription functionality present in R4.  Due to practical constraints, some functionality has been left out-of-scope for FHIR R4 support.

More information can be found on the [Topic-Based Subscription Components](components.html) page.

### Boundaries and Relationships

#### Relation to FHIRcast

[FHIRcast](http://fhircast.org) is a framework for user-activity synchronization across applications.  FHIRcast and Subscriptions are both conceptually based [W3 WebSub](https://www.w3.org/TR/websub/), and while the mechanics of two projects look similar they are fundamentally different projects used to address different use cases.  In particular:

1. What Is Communicated
    * FHIRcast is primarily concerned with context synchronization.
    * Subscriptions are focused on content synchronization.

1. User Interaction
    * FHIRcast is designed to be used by multiple applications perhaps with the same user and typically on the same device.
    * Subscriptions are designed to be used by multiple distinct systems, often outside of a user workflow.

1. Session Duration
    * FHIRcast is designed around short-lived sessions.
    * Subscriptions are intended to be long-lived resources.

1. Event Frequency
    * FHIRcast sends only single-event notifications.
    * Subscriptions allow servers to batch multiple notifications in high-frequency scenarios.

#### Relation to FHIR Messaging

FHIR [Messaging](http://hl7.org/fhir/messaging.html) is a message-based protocol which can be used for communication. When combining Messaging and Subscriptions, complete notifications are wrapped into Messaging Bundles.  More details are provided on the [channels page](channels.html#fhir-messaging).

### Change Log

A [Change log](ig_changelog.html) is provided to highlight differences between versions.

### Authors and Contributors

| **Role** | **Name** | **Organization** |
| -------- | -------- | ---------------- |
| Author | Gino Canessa | Microsoft |
| Contributor | Eric Haas | Health eData |
| Contributor | Josh Mandel | Microsoft / SMART Health IT |
| Contributor | Adam Strickland | Epic |
| Contributor | Jason Vogt | Meditech |
{: .grid }

The authors gratefully acknowledge the many contributions from numerous users and facilitators who helped shape, mature, debug, and advance Topic-Based Subscriptions:

Avery Allen,
Steve Atwood,
Brian Swinkels,
Rick Geimer,
Grahame Grieve,
Alexander Henket,
Bas van den Heuvel,
Spencer LaGesse,
Brett Marquard,
Lloyd McKenzie,
John Moehrke,
Vassil Peytchev,
Pascal Pfiffner,
David Pyke,
René Spronk,
Jenni Syed,
Cooper Thompson,
Isaac Vetter,
and
Julie Winters

The authors apologize if they have omitted any contributor from this list.

### Intellectual Property Statements

{% include ip-statements.xhtml %}