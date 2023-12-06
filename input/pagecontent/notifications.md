### Notifications

As described in [Topic-Based Subscription Components](components.html#subscription-notifications), **all** notifications are enclosed in a [Bundle](http://hl7.org/fhir/bundle.html) with the `type` of `history`.  Additionally, the first `entry` of the bundle SHALL be the `SubscriptionStatus` information, encoded as either a [Parameters](http://hl7.org/fhir/R4/parameters.html) resource using the [Backport SubscriptionStatus Profile](StructureDefinition-backport-subscription-status-r4.html) in FHIR R4 or a [SubscriptionStatus](http://hl7.org/fhir/subscriptionstatus.html) resource in FHIR R4B.

The notification bundle has a profile defined in this IG for each FHIR version: [R4 Topic-Based Subscription Notification Bundle](StructureDefinition-backport-subscription-notification-r4.html) and [R4B Topic-Based Subscription Notification Bundle](StructureDefinition-backport-subscription-notification.html).


For detailed information about the R4B `SubscriptionStatus` resource, please see the HL7 FHIR website:
* [SubscriptionStatus Resource](http://hl7.org/fhir/subscriptionstatus.html)
* [Notification Types](http://hl7.org/fhir/subscriptionstatus.html#notification-types)
* [Notifications and Errors](http://hl7.org/fhir/subscriptionstatus.html#errors)


### Bundle Type Considerations

In FHIR R5, a new type of `Bundle` has been introduced, which uses the new `SubscriptionStatus` resource to convey status information in notifications.  For FHIR R4, notifications are instead based on a [history Bundle](http://hl7.org/fhir/bundle.html#history), and a [SubscriptionStatus](http://hl7.org/fhir/subscriptionstatus.html) resource is used to convey related meta-information (e.g., which subscription the notification is for).

Note that since notifications use `history` type Bundles, all notifications need to comply with the requirements for that bundle type.  Specifically, there are two invariants on Bundle (`bdl-3` and `bdl-4`) that require a `Bundle.entry.request` element for *every* `Bundle.entry`.
* For the status resource (`entry[0]`), the request SHALL be filled out to match a request to the `$status` operation.
* For additional entries, the request SHOULD be filled out in a way that makes sense given the subscription (e.g., a `POST` or `PUT` operation on the resource, etc.).  However, a server MAY choose to simply include a `GET` to the relevant resource instead.

### Event Notifications and What to Include

What information is included in a notification depends on the level of information being provided (see [Payloads](payloads.html)).

In addition to general Subscription status information, each notification MAY include additional resources or references to resources (URLs or ids).  The notification shape SHALL be based on the definitions from the `SubscriptionTopic` relevant to the notification:

#### Focus Resource

Each topic trigger defines a resource type that is the focus for notifications.  For example: [SubscriptionTopic.resourceTrigger.resource](http://hl7.org/fhir/subscriptiontopic-definitions.html#SubscriptionTopic.resourceTrigger.resource) and [SubscriptionTopic.eventTrigger.resource](http://hl7.org/fhir/subscriptiontopic-definitions.html#SubscriptionTopic.eventTrigger.resource).

#### Additional Resources

Servers MAY choose to include additional resources with notifications that may be of interest to clients.  Servers SHALL conform to the payload configuration of the subscription when adding additional resources (e.g., if the subscription is `id-only`, then only ids of additional resources may be provided; if the subscription is `full-resource`, then full resources should be provided).

In order to aid servers in determining which resources may be of interest to clients, subscription topics can define a list of included resources (see [SubscriptionTopic.notificationShape.include](http://hl7.org/fhir/subscriptiontopic-definitions.html#SubscriptionTopic.notificationShape.include)).  Included resources are matches based on the type of focus resource specified.

Note that the include list MAY contain resources that do not exist in a particular context (e.g., an Encounter with no Observations) or that a user may not be authorized to access (e.g., an Observation tagged as sensitive that cannot be shared with the owner of a subscription).  Servers SHOULD attempt to provide the resources described in the topic, however clients SHALL expect that any resource beyond the focus resource are not guaranteed to be present.

### Notified Pull

#### Use Cases

##### Time Shifted Services

One presented use case is centered around a referral workflow.  The scenario is that some facility (A) is sending a referral to another facility (B) for some sort of patient service.  While Facility A knows the information that Facility B needs, Facility A does not know *when* Facility B will be performing services.  If there is a time gap (e.g., services at Facility B are running six months out), it is better for Facility B to resolve information at the time of service instead of at the time of referral.

<figure>
  {% include time-shifted-services.svg %}
  <figcaption>Workflow for referral service with a significant time delay</figcaption>
</figure>


##### Unstandardized Queries

Another use case for a 'notified pull' mechanism is a continuation of the `id-only` return data.  Specifically, in cases where the data necessary is not well-standardized, it is unreasonable to expect the referring facility to be able to construct the queries necessary to retrieve the data.  For example, in the United States, there is no standardized query to retrieve the current insurance coverage information for a patient.  The the process for retrieving that information is vendor-specific and it is unreasonable to expect a referring facility to be able to construct the queries necessary to retrieve it.

<figure>
  {% include unstandardized-query.svg %}
  <figcaption>Workflow showing how an unstandardized query can be used</figcaption>
</figure>

#### Adding Queries to Notifications

In both Use Cases described above, there are two pieces of information a subscriber needs in order to successfully use the provided queries: the URL for the query and coded information describing the query.

In this guide, the query and coded information are paired together as a `string` and a `Coding` respectively.  There are two places that need to contain this data: the topic definition and the notification itself.

##### FHIR R4

In FHIR R4, the topic definition is represented as a `Basic` resource that uses cross-version extensions to contain the information from a later-defined `SubscriptionTopic` resource (e.g., the FHIR R5 `SubscriptionTopic`).  Until FHIR R6 is published, there is no stable cross-version extension available to represent this data.  As such, this guide defines the [backport-related-query](StructureDefinition-backport-related-query.html) extension to represent the query and coded information.

Regarding notifications in FHIR R4, the information normally contained in a `SubscriptionStatus` resource, including details about notification events, is represented by a `Parameters` resource.  A `related-query` part was added to the [backport-subscription-status-r4](StructureDefinition-backport-subscription-status-r4.html) profile, inside the `notification-event` part.

For examples, please see [Backported SubscriptionTopic: R4 Encounter Complete](Basic-r4-encounter-complete.html), [R4 Notification: Id Only with Related Query](Bundle-r4-notification-id-only-with-query.html), or [R4 Notification: Full Resource with related query](Bundle-r4-notification-full-resource-with-query.html).


##### FHIR R4B and Later

In FHIR R4B and later, topic and notification information are represented in the `SubscriptionTopic` and `SubscriptionStatus` resources respectively.  Until FHIR R6 is published, there are no stable cross-version extension available to represent the elements needed for related-query data.  As such, this guide defines the [backport-related-query](StructureDefinition-backport-related-query.html) extension to represent the query and coded information.  The extension is usable on both `SubscriptionStatus.notificationEvent` and `SubscriptionTopic.notificationShape`.

For examples, please see [Backported SubscriptionTopic: R4B Encounter Complete](SubscriptionTopic-r4b-encounter-complete.html), [R4B Notification: Id Only with Query](Bundle-r4b-notification-id-only-with-query.html), or [R4B Notification: Full Resource with Query](Bundle-r4b-notification-full-resource-with-query.html).