
Subscriptions are operations which typically involve three actors:

1. Server or Publisher
1. Client or Subscriber
1. Endpoint

### FHIR Server

**Server** refers to the FHIR application or applications acting as the subscription provider. This includes the responsibilities of implementing one or more `SubscriptionTopics`, managing `Subscriptions`, and sending notifications.

Note that when using subscriptions, the FHIR server combines the roles of publisher and information distributer. Some arrangements of the 'publish and subscribe' pattern describe separate agents for the two roles. This specification makes no recommendations towards the internal architecture of server implementations.

### FHIR Client / Subscriber

**Client** or **Subscriber** refers to the application or applications acting as subscriber. This includes the responsibilites of acting as a FHIR client (to create a Subscription) and receiving notifications on a supported channel.

### Endpoint

**Endpoint** refers to the portion of the **client** which is responsible for receiving notifications, if applicable.  For example, when using the `rest-hook` channel type the endpoint is the HTTP server listening for notifications.  While part of the client, it is often useful to refer to the endpoint separately for clarity.