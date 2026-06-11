
This section gives an overview of the workflow for both Servers and Clients to work with Subscriptions.  Each [channel](channels.html) MAY vary slightly from this general overview - specifically around interactions involving the `Endpoint` (e.g., when using a `rest-hook` the client must pre-configure an HTTP endpoint which the server validates, but when using `websockets` the client simply connects to the server).

### Overview

The workflow for topic-based subscriptions can be broken down into three matched process steps for each a server or client:

<figure>
  {% include workflow-overview.svg %}
  <figcaption>High-level workflow overview</figcaption>
</figure>

|#|Server|Client|
|--|--|--|
|1.|Implement Topic-Based Subscriptions|Topic Discovery|
|2.|Subscription Creation|Request a Subscription|
|3.|Send Notifications|Receive Notifications|

### Creating a Subscription

A `Subscription` resource may be created in one of two ways:

* **Dynamic** - the consuming client performs a RESTful interaction (typically a `POST`) against the server to register a `Subscription` resource. This is the flow depicted in the sequence diagrams below ([Dynamic Workflow: FHIR R4](#dynamic-workflow-fhir-r4), [Dynamic Workflow: FHIR R4B](#dynamic-workflow-fhir-r4b)) and is most appropriate when the consuming application can negotiate its own subscriptions at run time.
* **Administrative** - a server administrator configures the `Subscription` resource on behalf of the consuming client, outside of the normal RESTful client/server exchange. This is most appropriate when governance, security, or performance review is required before a subscription becomes active, or when the consuming client is not authorized (or not designed) to request its own subscriptions over the API. See [Administrative Workflow](#administrative-workflow) below.

Note that both mechanisms result in equivalent `Subscription` resource content being available _inside_ the server and the same runtime notification behaviour. The approaches differ only in how the `Subscription` resource is initially created and, _possibly_, what data is exposed to clients.


### Dynamic Workflow: FHIR R4

<figure>
  {% include workflow-r4.svg %}
  <figcaption>Sequence diagram of creating a FHIR Subscription in FHIR R4</figcaption>
</figure>

1. Server implements the core functionality required for subscriptions (see [Conformance](conformance.html)).
1. Server implements one or more subscription topics.  Implementation is specific to each topic, and will vary between servers.
1. *Optional* Client attempts topic discovery via the [CapabilityStatement SubscriptionTopic Canonical](StructureDefinition-capabilitystatement-subscriptiontopic-canonical.html) extension.
1. Server responds with its `CapabilityStatement`.
1. *Optional* Client attempts topic discovery via the `CapabilityStatement.instantiates` element.
1. Server responds with its `CapabilityStatement`.
1. *Optional* Client attempts topic discovery via the `CapabilityStatement.implementationGuide` element.
1. Server responds with its `CapabilityStatement`.
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

When a `handshake` notification is required by the channel, the Subscriber learns that its `Subscription` has transitioned from `requested` to `active` by *receiving* the `handshake` notification on its configured endpoint. A Subscriber does not need to poll its own `Subscription` resource and does not need to subscribe to changes on its own `Subscription`.  If the `handshake` fails, or if the Server requires additional approval steps before activating the `Subscription`, no `handshake` notification will be delivered and the Subscriber MAY read its `Subscription` resource on the Server to determine the current `Subscription.status`.

### Dynamic Workflow: FHIR R4B

<figure>
  {% include workflow-r4b.svg %}
  <figcaption>Sequence diagram of creating a FHIR Subscription in FHIR R4B</figcaption>
</figure>

1. Server implements the core functionality required for subscriptions (see [Conformance](conformance.html)).
1. Server implements one or more [SubscriptionTopic](http://hl7.org/fhir/R4B/subscriptiontopic.html) resources.  Implementation is specific to each topic, and will vary between servers.
1. Client asks the server for the list of supported [SubscriptionTopic](http://hl7.org/fhir/R4B/subscriptiontopic.html) resources, via querying the resource.
1. Server responds with a [searchset Bundle](http://hl7.org/fhir/R4B/bundle.html#searchset).
1. Client ensures that the endpoint is prepared (if applicable - see [Channels](channels.html)).
1. Client requests a [Subscription](http://hl7.org/fhir/R4B/subscription.html) (e.g., via `POST`, `PUT`, etc.).
1. Server MAY accept the [Subscription](http://hl7.org/fhir/R4B/subscription.html) request and mark it `active` (e.g., supported channel and payload, no handshake required).
1. Server MAY accept the [Subscription](http://hl7.org/fhir/R4B/subscription.html) request and mark it `requested` (e.g., supported channel and payload, handshake required).
1. Server sends a `handshake` bundle to the endpoint.
1. If the Endpoint responds appropriately, per the channel requirements (e.g., in REST an HTTP Success code such as 200), the Server updates the subscription to `active`.
1. Server MAY accept the [Subscription](http://hl7.org/fhir/R4B/subscription.html) request and mark it `requested` (e.g., supported channel and payload, handshake required).
1. Server sends a `handshake` bundle to the endpoint.
1. If the `handshake` fails (e.g., connection failure, bad response, etc.), the Server updates the subscription to `error`.
1. Server MAY reject the [Subscription](http://hl7.org/fhir/R4B/subscription.html) request (e.g., unsupported channel type).

Once the subscription is active, notifications will be sent according to the [Channel](channels.html).  Note that error states may occur, see [Handling Errors](errors.html) for more information.

When a `handshake` notification is required by the channel, the Subscriber learns that its `Subscription` has transitioned from `requested` to `active` by *receiving* the `handshake` notification on its configured endpoint. A Subscriber does not need to poll its own `Subscription` resource and does not need to subscribe to changes on its own `Subscription`.  If the `handshake` fails, or if the Server requires additional approval steps before activating the `Subscription`, no `handshake` notification will be delivered and the Subscriber MAY read its `Subscription` resource on the Server to determine the current `Subscription.status`.

### Administrative Workflow

Administrative subscriptions are created and maintained by a server administrator (or by a server-side configuration tool) rather than by the consuming client itself. This pattern is common in deployments where one or more of the following apply:

* Governance or project-onboarding processes require explicit operator review and approval of a `Subscription` before notifications begin (e.g., evaluating performance impact of the requested topic and filters, payload sensitivity, allowable channel types, recipient endpoint trust).
* The consuming client cannot, or chooses not to, present credentials that permit it to `POST` a `Subscription` resource itself (e.g., constrained OAuth scopes, business-to-business integrations where the client only consumes notifications).
* The lifecycle of the `Subscription` is governed by deployment milestones (provisioning, decommissioning, configuration drift management) rather than by run-time decisions in the consuming client.

The high-level stages are the same as for the Dynamic workflow (topic implementation and discovery, subscription negotiation, notification delivery), though the implementation of the stages will vary.

1. The consuming client and the server administrator agree on the desired `SubscriptionTopic`, channel, payload type, filters, and notification endpoint through an out-of-band process (e.g., onboarding ticket, governance review, deployment runbook). This step might occur at project deployment time rather than at run time, etc..
1. A server user or administrator creates a `Subscription` resource or equivalent directly on the server using an administrative tool, configuration loader, or privileged API call.
1. A server user or administrator handles channel handshake / endpoint validation as required by the chosen channel (see [Channels](channels.html)). The handshake MAY be performed at the time the `Subscription` or equivalent is created, or be deferred until the client's endpoint is ready, etc..
1. Once the subscription is `active`, notifications are sent to the configured endpoint exactly as described for Dynamic subscriptions; see [Channels](channels.html) for channel-specific behaviour and [Handling Errors](errors.html) for error states.


When a `handshake` notification is required by the channel, the Subscriber learns that an administrative `Subscription` is `active` by *receiving* the `handshake` notification on its endpoint.
