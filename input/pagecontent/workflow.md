
This section gives an overview of the workflow for both Servers and Clients to work with Subscriptions.  Each [channel](channels.html) MAY vary slightly from this general overview - specifically around interactions involving the `Endpoint` (e.g., when using a `rest-hook` the client must pre-configure an HTTP endpoint which the server validates, but when using `websockets` the client simply connects to the server).

### Creating a Subscription

A workflow for creating a subscription is below:

<figure>
  {% include workflow-general.svg %}
  <figcaption>Sequence diagram of creating a FHIR Subscription</figcaption>
</figure>

1. Server implements the core functionality required for subscriptions (see [Conformance](conformance.html)).
1. Server implements one or more [SubscriptionTopic](http://hl7.org/fhir/R4/subscriptiontopic.html) resources.  Implementation is specific to each topic, and will vary between servers.
1. Client asks the server for the list of supported [SubscriptionTopic](http://hl7.org/fhir/R4/subscriptiontopic.html) resources, via querying the resource.
1. Server responds with a [searchset Bundle](http://hl7.org/fhir/R4/bundle.html#searchset).
1. Client ensures that the endpoint is prepared (if applicable - see [Channels](channels.html)).
1. Client requests a [Subscription](http://hl7.org/fhir/R4/subscription.html) (e.g., via `POST`, `PUT`, etc.).
1. Server MAY accept the [Subscription](http://hl7.org/fhir/R4/subscription.html) request and mark it `active` (e.g., supported channel and payload, no handshake required).
1. Server MAY accept the [Subscription](http://hl7.org/fhir/R4/subscription.html) request and mark it `requested` (e.g., supported channel and payload, handshake required).
1. Server sends a `handshake` bundle to the endpoint.
1. If the Endpoint responds appropriately, per the channel requirements (e.g., in REST an HTTP Success code such as 200), the Server updates the subscription to `active`.
1. Server MAY accept the [Subscription](http://hl7.org/fhir/R4/subscription.html) request and mark it `requested` (e.g., supported channel and payload, handshake required).
1. Server sends a `handshake` bundle to the endpoint.
1. If the `handshake` fails (e.g., connection failure, bad response, etc.), the Server updates the subscription to `error`.
1. Server MAY reject the [Subscription](http://hl7.org/fhir/R4/subscription.html) request (e.g., unsupported channel type).

Once the subscription is active, notifications will be sent according to the [Channel](channels.html).  Note that error states may occur, see [Handling Errors](errors.html) for more information.