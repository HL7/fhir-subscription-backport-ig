### What are Subscriptions?

The Subscriptions Framework is a mechanism designed to allow clients to ask for notifications when data changes.  It is an active notification system; a FHIR server actively sends notifications to clients as changes occur.

### Subscriptions in R4

There is a defined [Subscription](http://hl7.org/fhir/r4/subscription.html) resource in FHIR R4, which has been in place since DSTU2.  In those releases of FHIR, subscriptions are defined by a client at run-time via a query.  The FHIR server must then run the query and track the query result-set for each subscription request.  Each time a change to the server's data is made, a server must re-run the query and send notifications to clients if their result-set changes (e.g., a new entry is added or removed).

The above approach works well for some use cases, but has issues which prevent it from being used in others.  Some of the issues identified include:
* Difficulty implementing the server-side logic at scale (both in terms of large datasets and many clients).
* An opaque discovery process (e.g., servers that had restrictions on queries had no way to advertise them).
* Lack of granularity in events (e.g., it was unclear why something was removed from a dataset).
* No ability to bundle notifications (e.g., servers had to send a single notification for each discrete event).
* Notifications required clients to re-query after receiving a notification.

While some of the issues would be addressable with modifications to the existing `Subscription` resource, the FHIR Infrastructure Work Group felt that more extensive changes were needed, and so started a redesign of Subscriptions for R5.

### Subscriptions in R5

More than a year of focused work resulted in a new design for Subscriptions in FHIR R5.  The redesign focused on three main areas:

1. Moving to a topic-based model, with the defintion of a `SubscriptionTopic` resource.
1. Changing the `Subscription` resource to add clarity and flexibility.
1. Restructuring notifications by adding a new `Bundle` type.

The implementer response to these changes has been overwhelmingly positive - changes to the mechanism address the issues identified and retain all of the existing functionality.  However, many implementers are concerned that both publication and adoption of FHIR R5 are both in the future.

### This IG

In response to requests for a way to use "R5-style" subscriptions in earlier versions of FHIR, this Implementation Guide has been authored.  The goal is to provide a standard set of artifacts and extensions so that consistent behavior can be achieved prior to the release and adoption of FHIR R5.