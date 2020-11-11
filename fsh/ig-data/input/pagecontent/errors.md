
Errors can occur at any point in the processing or delivery of a notification. This page describes some common error scenarios and mechanisms used to detect and recover from them.

### Handling Errors as a Server


### Detecting Errors as a Subscriber

There are several mechanisms available to subscribers in order to understand the current state of notification delivery. Below are some example error scenarios with details about how a subscriber can detect the problem state.

#### Skipped Event

The diagram below shows how a subscriber can use the `eventsSinceSubscriptionStart` parameter on received notifications to determine that an event has been missed.

<img src="subscriptions-skipped-event.svg" alt="Diagram showing the skipped event workflow" style="float:none;" />

In the above sequence, the subscriber tracks the `eventsSinceSubscriptionStart` of each received notification (per `Subscription`). When the subscriber received event 23, the subscriber was aware that the last notification it received was a single notification for event 21. The subscriber then waited an amount of time to ensure that event 22 was indeed missing (and not, for example, still being processed) and started a recovery process. The recovery process itself will vary by subscriber, but should be a well-understood method for recovering in the event of errors.

### Broken Communication

The diagram below show how a subscriber can use the `heartbeatPeriod` on a `Subscription` to determine errors which prevent notifications from reaching the endpoint.

<img src="subscriptions-no-event.svg" alt="Diagram showing the broken communication workflow" style="float:none;" />

In the above sequence, the subscriber is aware that the `heartbeatPeriod` has elapsed for a subscription without receiving any notifications. The subscriber then asks the server for the `$status` of the subscription, and seeing an error, begins a recovery process. As in the previous scenario, the recovery process itself will vary by subscriber, but should be a well-understood method for recovering in the event of errors.