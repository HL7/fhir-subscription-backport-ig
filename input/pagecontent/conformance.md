
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
* [Empty](actors_and_operations.html#empty)
* [Id Only](actors_and_operations.html#id-only)
* [Full Resource](actors_and_operations.html#full-resource)

### Channel Types

At least one of:
* [REST Hook](actors_and_operations.html#rest-hook)
* [Websockets](actors_and_operations.html#websockets)
* [Email](actors_and_operations.html#email)
* [FHIR Messaging](actors_and_operations.html#fhir-messaging)
