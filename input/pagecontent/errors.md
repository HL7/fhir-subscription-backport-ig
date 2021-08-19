
Errors can occur at any point in the processing or delivery of a notification. This page describes some common error scenarios and mechanisms used to detect and recover from them.

### Handling Errors as a Server

Error handling as a Server is intended to be simple.  A server is not expected to know the best process for every use case of every subscriber, so the focus is on allowing clients to detect there is an issue.  A server SHALL:
* Increment the `eventsSinceSubscriptionStart` counter internally.
* Update the `status` of the subscription internally.
* Continue to respond to `$status` requests.

A server MAY:
* Continue to send `heartbeat` messages (with an `error` status set).

Disovering the error state and recovering from it are responsibilites of the subscriber.  This includes resetting the `Subscription` to an `active` or `requested` status - a client is responsible for requesting re-activation of a subscription.  Note: this is important because a subscriber must make the determiniation of how to recover from an error state; if a server arbitrarily resets a subscription, a subscriber may not be aware of missing notifications.

### Detecting Errors as a Subscriber

There are several mechanisms available to subscribers in order to understand the current state of notification delivery. Below are some example error scenarios with details about how a subscriber can detect the problem state.

#### Missing Event

The diagram below shows how a subscriber can use the `eventsSinceSubscriptionStart` parameter on received notifications to determine that an event has been missed.

<img src="subscriptions-skipped-event.svg" alt="Diagram showing the skipped event workflow" style="float:none;" />

In the above sequence, the subscriber tracks the `eventsSinceSubscriptionStart` of each received notification (per `Subscription`). When the subscriber received event 23, the subscriber was aware that the last notification it received was a single notification for event 21. The subscriber then waited an amount of time to ensure that event 22 was indeed missing (and not, for example, still being processed) and started a recovery process. The recovery process itself will vary by subscriber, but should be a well-understood method for recovering in the event of errors.

### Broken Communication

The diagram below show how a subscriber can use the `heartbeatPeriod` on a `Subscription` to determine errors which prevent notifications from reaching the endpoint.

<img src="subscriptions-no-event.svg" alt="Diagram showing the broken communication workflow" style="float:none;" />

In the above sequence, the subscriber is aware that the `heartbeatPeriod` has elapsed for a subscription without receiving any notifications. The subscriber then asks the server for the `$status` of the subscription, and seeing an error, begins a recovery process. As in the previous scenario, the recovery process itself will vary by subscriber, but should be a well-understood method for recovering in the event of errors.

### Recovering from Errors

Clients are responsible for devising an appropriate method for recovering from errors.  Often, this process will include a series or batch of requests that allow a client to know the current state.  For example, an application may need to query all relevant resources for a patient in order to ensure nothing has been missed.  Once an application has returned to a functional state, it should request the subscription is reactivated by updating the `status` to either `requested` or `active` as appropriate.

#### Using the $events operation

Servers MAY choose to support the `$events` operation, as defined in this IG.  The `$events` operation allows clients to request events which have occurred in the past.  Servers which implement the operation MAY use implementation-specific criteria to restrict availability of events (e.g., most recent 10 events, events within the past 30 days, etc.).

During a recovery process, clients MAY try to retrieve missing events via the `$events` operation, which should allow processing to continue as normal.