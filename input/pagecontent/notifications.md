### Notifications

As described in [Topic-Based Subscription Components](components.html#subscription-notifications), **all** notifications use the same structure: a [Bundle](http://hl7.org/fhir/bundle.html), with the `type` of `history`, and a [SubscriptionStatus](http://hl7.org/fhir/subscriptionstatus.html) as the first `entry` that contains information about the subscription and notification.

The notification bundle has a profile defined in this IG, see [Backported R5 Subscription Notification Bundle](StructureDefinition-backport-subscription-notification.html).

For detailed information about the `SubscriptionStatus` resource, please see the HL7 FHIR website:
* [SubscriptionStatus Resource](http://hl7.org/fhir/subscriptionstatus.html)
* [Notification Types](http://hl7.org/fhir/subscriptionstatus.html#notification-types)
* [Notifications and Errors](http://hl7.org/fhir/subscriptionstatus.html#errors)

### Event Notifications and What to Include

In addition to the `SubscriptionStatus` resource, each notification MAY include additional resources or references to resources (URLs or ids).  The notification shape SHALL be based on the definitions from the `SubscriptionTopic` relevant to the notification:

#### Focus Resource

Each topic trigger defines a resource type that is the focus for notifications.  For example: [SubscriptionTopic.resourceTrigger.resource](http://hl7.org/fhir/subscriptiontopic-definitions.html#SubscriptionTopic.resourceTrigger.resource) and [SubscriptionTopic.eventTrigger.resource](http://hl7.org/fhir/subscriptiontopic-definitions.html#SubscriptionTopic.eventTrigger.resource).

#### Additional Resources

Servers MAY choose to include additional resources with notifications that may be of interest to clients.  Servers SHALL conform to the paylod configuration of the subscription when adding additional resources (e.g., if the subscription is `id-only`, then only ids of additional resources may be provided; if the subscription is `full-resource`, then full resources should be provided).

In order to aid servers in determining which resources may be of interest to clients, subscription topics can define a list of included resources (see [SubscriptionTopic.notificationShape.include](http://hl7.org/fhir/subscriptiontopic-definitions.html#SubscriptionTopic.notificationShape.include)).  Included resources are matches based on the type of focus resource specified.

Note that the include list MAY contain resources that do not exist in a particular context (e.g., an Encounter with no Observations) or that a user may not be authorized to access (e.g., an Observation tagged as sensitive that cannot be shared with the owner of a subscription).  Servers SHOULD attempt to provide the resources described in the topic, however clients SHALL expect that any resource beyond the focus resource are not guaranteed to be present.
