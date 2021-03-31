### Notifications

As described in [Components](components.html#subscription-notifications), **all** notifications use the same structure: a [Bundle](http://hl7.org/fhir/bundle.html), with the `type` of `history`, and a [Parameters](http://hl7.org/fhir/parameters.html) as the first `entry` that contains information about the subscription and notification.

The notification bundle has a profile defined in this IG, see [Backported R5 Subscription Notification Bundle](StructureDefinition-backport-subscription-notification.html).

The `Parameters` used to communicate information about a subscription and notification also has a profile defined in this IG, see [Backported R5 Subscription Notification Status](StructureDefinition-backport-subscriptionstatus.html).

Each type of notification message is described below:

#### Handshake

A `handshake` notification is used to verify a communication channel.  While not required, if a handshake message is sent, it SHALL only be used as the first message when establishing or re-establishing communication (e.g., testing a channel to resume communication).

Handshake bundles can be identified by looking in the notification bundle, at the notification status parameters: `Bundle.entry[0].resource.parameter:type` of `handshake`.

A handshake notification SHALL NOT contain any events (`eventsInNotification` SHALL be `0`).

#### Heartbeat

A `heartbeat` notification is used by a server to both ensure a communications channel is still valid, and communicate that to a client.  Servers and Clients negotiate the use and timing of heartbeat messages when creating or updating a Subscription (see [Backport R5 Subscription Heartbeat Period](StructureDefinition-backport-heartbeat-period.html)).

Heartbeat bundles can be identified by looking in the notification bundle, at the notification status parameters: `Bundle.entry[0].resource.parameter:type` of `heartbeat`.

A heartbeat notification SHALL NOT contain any events (`eventsInNotification` SHALL be `0`).

#### Event Notification

The `event-notification` type is used for event notifications.  It is the mechanism for a Server to notify a Client that an event of interest has occured.

Event Notification bundles can be identified by looking in the notification bundle, at the notification status parameters: `Bundle.entry[0].resource.parameter:type` of `event-notification`.

An event notification SHALL be used to communicate one or more events of interest (`eventsInNotification` SHALL be greater than `0`).  Note however, that the notification bundle may or may not contain any additional resources or URLs (as specified by the [payload content](StructureDefinition-backport-payload-content.html)).

#### Query Status

The `query-status` type is used when a Client requests the current status of a Subscription.  It is used to provide status information *only*.

Query Status bundles can be identified by looking in the notification bundle, at the notification status parameters: `Bundle.entry[0].resource.parameter:type` of `query-status`.

A query status bundle SHALL NOT contain any events which have not already been attempted. A Server MAY include events which have been sent or failed to send, at the Server's discretion (e.g., most recent 5 events, etc.).