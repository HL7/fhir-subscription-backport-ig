
This section gives an overview of the workflow for both Servers and Clients to work with Subscriptions.  Each [channel](channels.html) MAY vary slightly from this general overview - specifically around interactions involving the `Endpoint` (e.g., when using a `rest-hook` the client must pre-configure an HTTP endpoint which the server validates, but when using `websockets` the client simply connects to the server).

### Creating a Subscription

A workflow for creating a subscription is below:

<img src="workflow-01.svg" alt="Diagram showing a basic subscription workflow" style="float:none;" />

1. Server implements the core functionality required for subscriptions (see [Conformance](conformance.html)).
1. Server implements one or more `SubscriptionTopics`.  Topic implementation is specific to each defined topic, and will vary between implementations.
1. Client asks the server for the list of supported `SubscriptionTopics`, via the [Subscription/$topic-list](OperationDefinition-backport-subscriptiontopic-list.html) operation.
1. Server responds with a [Canonical URLs](StructureDefinition-backport-subscription-topic-canonical-urls.html) Parameters resource.
1. Client ensures that the endpoint is prepared (if applicable - see [Channels](channels.html)).
1. Client requests a Subscription (e.g., via `POST`, `PUT`, etc.).
1. Server MAY accept the Subscription request (e.g., supported channel and payload).
1. Server MAY reject the Subscription request (e.g., unsupported channel type).
1. If applicable, the server MAY send a `handshake` to the endpoint.
1. If the Server sends a `handshake`, the endpoint should respond appropriately.

Once the subscription is active, notifications will be sent according to the [Channel](channels.html).  Note that error states may occur, see [Handling Errors](errors.html) for more information.