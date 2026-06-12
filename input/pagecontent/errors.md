
Errors can occur at any point in the processing or delivery of a notification. This page describes some common error scenarios and mechanisms used to detect and recover from them.

### Handling Errors as a Server

Error handling as a Server is intended to be simple.  A server is not expected to know the best process for every use case of every client, so the focus is on allowing clients to detect that there is an issue.  A server SHALL:
* Increment the `eventsSinceSubscriptionStart` counter internally.
* Update the `status` of the subscription internally.
* Continue to respond to `$status` requests.

A server MAY:
* Continue to send `heartbeat` messages (with an `error` status set).

Discovering the error state and recovering from it are responsibilities of the Client (Subscriber).  This includes resetting the `Subscription` to an `active` or `requested` status - a client is responsible for requesting re-activation of a subscription.  Note: this is important because a client must make the determination of how to recover from an error state; if a server arbitrarily resets a subscription, a client may not be aware of missing notifications.

### Detecting Errors as a Client

There are several mechanisms available to clients in order to understand the current state of notification delivery. Below are some example error scenarios with details about how a client can detect a problem state.

#### Missing Event

The diagram below shows how a client can use the `eventsSinceSubscriptionStart` parameter on received notifications to determine that an event has been missed.

<figure>
  {% include error-missing-event.svg %}
  <figcaption>Diagram showing a missed-event detection and recovery workflow</figcaption>
</figure>

In the above sequence, the client tracks the `eventsSinceSubscriptionStart` of each received notification (per `Subscription`). When the client received event 23, they were aware that the last notification it received was a single notification for event 21. The client then waited an amount of time to ensure that event 22 was indeed missing (and not, for example, still being processed) and started a recovery process. The recovery process itself will vary by client and use-case, but should be a well-understood method for recovering in the event of errors.

### Broken Communication

The diagram below shows how a client can use the `heartbeatPeriod` on a `Subscription` to determine errors which prevent notifications from reaching the endpoint.

<figure>
  {% include error-no-communication.svg %}
  <figcaption>Diagram showing broken communication detection and recovery workflow</figcaption>
</figure>

In the above sequence, the client is aware that the `heartbeatPeriod` has elapsed for a subscription without receiving any notifications. They then ask the server for the `$status` of the subscription, and seeing an error, begin a recovery process. As in the previous scenario, the recovery process itself will vary by client and use-case, but should be a well-understood method for recovering in the event of errors.

### Recovering from Errors

Clients are responsible for devising an appropriate method for recovering from errors.  Often, this process will include a series or batch of requests that allow a client to know the current state.  For example, an application may need to query all relevant resources for a patient in order to ensure nothing has been missed.  Once an application has returned to a functional state, it SHOULD request that the subscription is reactivated by updating the `status` to either `requested` or `active` as appropriate.

#### Using the $events operation

Servers MAY choose to support the `$events` operation, as defined in this IG.  The `$events` operation allows clients to request events which have occurred in the past.  Servers which implement the operation MAY use implementation-specific criteria to restrict availability of events (e.g., most recent 10 events, events within the past 30 days, etc.).

During a recovery process, clients MAY try to retrieve missing events via the `$events` operation, which should allow processing to continue as normal.