
Subscriptions are operations which typically involve three actors:

1. Server
1. Client or Subscriber
1. Endpoint

### FHIR Server

**Server** refers to the FHIR application or applications acting as the subscription provider. This includes the responsibilities of implementing one or more `SubscriptionTopics`, managing `Subscriptions`, and sending notifications.

### FHIR Client / Subscriber

**Client** or **Subscriber** refers to the application or applications acting as subscriber. This includes the responsibilites of acting as a FHIR client (to create a Subscription) and receiving notifications on a supported channel.

### Endpoint

**Endpoint** refers to the portion of the **client** which is responsible for receiving notifications, if applicable.  For example, when using the `rest-hook` channel type the endpoint is the HTTP server listening for notifications.  While part of the client, it is often useful to refer to the endpoint separately for clarity.