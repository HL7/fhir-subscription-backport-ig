### Notifications

As described in [Topic-Based Subscription Components](components.html#subscription-notifications), **all** notifications are enclosed in a [Bundle](http://hl7.org/fhir/bundle.html) with the `type` of `history`.  Additionally, the first `entry` of the bundle SHALL be the `SubscriptionStatus` information, encoded as either a [Parameters](http://hl7.org/fhir/R4/parameters.html) resource using the [Backport SubscriptionStatus Profile](StructureDefinition-backport-subscription-status-r4.html) in FHIR R4 or a [SubscriptionStatus](http://hl7.org/fhir/subscriptionstatus.html) resource in FHIR R4B.

The notification bundle has a profile defined in this IG for each FHIR version: [R4 Topic-Based Subscription Notification Bundle](StructureDefinition-backport-subscription-notification-r4.html) and [R4B Topic-Based Subscription Notification Bundle](StructureDefinition-backport-subscription-notification.html).


For detailed information about the R4B `SubscriptionStatus` resource, please see the HL7 FHIR website:
* [SubscriptionStatus Resource](http://hl7.org/fhir/subscriptionstatus.html)
* [Notification Types](http://hl7.org/fhir/subscriptionstatus.html#notification-types)
* [Notifications and Errors](http://hl7.org/fhir/subscriptionstatus.html#errors)



### The history bundle type

In FHIR R5, a new type of `Bundle` has been introduced, which uses the new `SubscriptionStatus` resource to convey status information in notifications.  For FHIR R4, notifications are instead based on a [history Bundle](http://hl7.org/fhir/bundle.html#history), and a [SubscriptionStatus](http://hl7.org/fhir/subscriptionstatus.html) resource is used to convey related meta-information (e.g., which subscription the notification is for).

Note that since notifications use `history` type Bundles, all notifications need to comply with the requirements for that bundle type.  Specifically, there are two invariants on Bundle (`bdl-3` and `bdl-4`) that require a `Bundle.entry.request` element for *every* `Bundle.entry`.
* For the status resource (`entry[0]`), the request SHALL be filled out to match a request to the `$status` operation.
* For additional entries, the request SHOULD be filled out in a way that makes sense given the subscription (e.g., a `POST` or `PUT` operation on the resource, etc.).  However, a server MAY choose to simply include a `GET` to the relevant resource instead.

### Event Notifications and What to Include

In addition to the Subscription Status information, each notification MAY include additional resources or references to resources (URLs or ids).  The notification shape SHALL be based on the definitions from the `SubscriptionTopic` relevant to the notification:

#### Focus Resource

Each topic trigger defines a resource type that is the focus for notifications.  For example: [SubscriptionTopic.resourceTrigger.resource](http://hl7.org/fhir/subscriptiontopic-definitions.html#SubscriptionTopic.resourceTrigger.resource) and [SubscriptionTopic.eventTrigger.resource](http://hl7.org/fhir/subscriptiontopic-definitions.html#SubscriptionTopic.eventTrigger.resource).

#### Additional Resources

Servers MAY choose to include additional resources with notifications that may be of interest to clients.  Servers SHALL conform to the payload configuration of the subscription when adding additional resources (e.g., if the subscription is `id-only`, then only ids of additional resources may be provided; if the subscription is `full-resource`, then full resources should be provided).

In order to aid servers in determining which resources may be of interest to clients, subscription topics can define a list of included resources (see [SubscriptionTopic.notificationShape.include](http://hl7.org/fhir/subscriptiontopic-definitions.html#SubscriptionTopic.notificationShape.include)).  Included resources are matches based on the type of focus resource specified.

Note that the include list MAY contain resources that do not exist in a particular context (e.g., an Encounter with no Observations) or that a user may not be authorized to access (e.g., an Observation tagged as sensitive that cannot be shared with the owner of a subscription).  Servers SHOULD attempt to provide the resources described in the topic, however clients SHALL expect that any resource beyond the focus resource are not guaranteed to be present.
