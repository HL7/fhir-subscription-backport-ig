
FHIR Servers claiming conformance to this Implementation Guide must include:

### Resource Support

* [Subscription](http://hl7.org/fhir/subscription.html)
  * Create
  * Update
  * Delete
  * Search

### Operations

* Topic discovery: [$topic-list](OperationDefinition-Backport-subscriptiontopic-list.html)
* Subscription Status: [$status](OperationDefinition-Backport-subscription-status.html)

### Payload Content Types

At least one of:
* [Empty](payloads.html#empty)
* [Id Only](payloads.html#id-only)
* [Full Resource](payloads.html#full-resource)

### Channel Types

At least one of:
* [REST Hook](channels.html#rest-hook)
* [Websockets](channels.html#websockets)
* [Email](channels.html#email)
* [FHIR Messaging](channels.html#fhir-messaging)
