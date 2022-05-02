### Payload Types

There are three options available when specifying the contents of a Notification: `empty`, `id-only`, and `full-resource`. These options change the level of detail conveyed in the notification Bundle.

When deciding which payload types to support, systems SHOULD consider both ease of processing and security of PHI. Clients often prefer the highest amount of data in notifications (e.g., `full-resource`) in order to reduce their processing burden.  Servers often prefer the lowest amount of data in notifications (e.g., `empty`) in order to mitigate the risk of information leakage (though also need to balance this against additional load caused by client queries). In practice, `id-only` provides a good balance between security and performance for many real-world scenarios.

Some security guidance is included below, however implementers SHOULD use the minimum level of detail consistent with the use case and SHOULD conduct a security review to determine how the payload and channel type interact with respect to data security. 

<figure>
  {% include payload-comparison.svg %}
  <figcaption>Diagram showing the different round-trips based on payload types</figcaption>
</figure>


If a server will not honor a payload type (e.g., will not send `full-resource` over HTTP), it SHOULD reject the Subscription request, but the server MAY accept the subscription with modifications.

#### Empty

With the content type of `empty`, no information about the resources involved in triggering the notification is available via the subscription channel. This mitigates many security concerns by both removing most PHI from the notification and allows servers to consolidate authorization and authentication logic. When the client receives a notification of this type, it may query the server to fetch all the relevant resources based on the SubscriptionTopic and applicable filters. The client might include a `_since=` query parameter, supplying its last query timestamp to retrieve only the most recent resources. For example, if the notification is for a topic about patient admission, the client will generally query for recent `Encounters` for a patient or group of patients, then fetch them as needed.

When populating the `SubscriptionStatus.notificationEvent` structure for a notification with an `empty` payload, a server SHALL NOT include references to resources (e.g., [SubscriptionStatus.notificationEvent.focus](http://hl7.org/fhir/subscriptionstatus-definitions.html#SubscriptionStatus.notificationEvent.focus) and [SubscriptionStatus.notificationEvent.additionalContext](http://hl7.org/fhir/subscriptionstatus-definitions.html#SubscriptionStatus.notificationEvent.additionalContext) SHALL NOT be present).

When the content type is `empty`, notification bundles SHALL not contain `Bundle.entry` elements other than the `SubscriptionStatus` for the notification.

From a security perspective, `empty` payloads expose the lowest risk, since they contain no PHI. The trade-off is that clients need to perform queries against the server in order to discover what events have occured, costing bot client and server additional time, data transfer, and processing.

#### Id Only

With the content type of `id-only`, the resources involved in triggering the notification are only available through other channels (e.g., REST API), but notifications include URLs which can be used to access those resources. This allows servers to consolidate authorization and authentication logic, while removing the need for expensive queries by clients. When a client receives a notification of this type, it may directly fetch all the relevant resources using the supplied resource ids. For example, if the notification is for a topic about patient admission, the client may fetch the `Encounter` resources for a patient or group of patients using URLs included in the notification.

When the content type is `id-only`, notification bundles SHALL include references to the appropriate focus resources in the [SubscriptionStatus.notificationEvent.focus](http://hl7.org/fhir/subscriptionstatus-definitions.html#SubscriptionStatus.notificationEvent.focus) element.  This provides clients a fixed location to consolidate IDs for all notification types.

Additionally, notification bundles MAY contain, in addition to the `SubscriptionStatus` used to convey status information, at least one `Bundle.entry` for each resource relevant to the notification. For example, a notification for a topic based on `Encounter` MAY include a reference to the `Encounter` and MAY also include additional resources deemed relevant (e.g., the linked `Patient`).

Each `Bundle.entry` for `id-only` notification SHALL contain a relevant resource URL in the `fullUrl` and `request` elements, as is requred for `history` bundles.

From a security perspective, `id-only` payloads have a low risk of exposing PHI. While there is no PHI directly in the payload, some links to resources can be considered PHI. For example, if a system contains `Medication` resources using `RxNorm` codes as ids (e.g., `Medication/RX10359383`), a notification including a reference to that medication would communicate the patient has some interaction with `ciprofloxacin 500 mg 24-hour extended release tablets`.

#### Full Resource

With the content type of `full-resource`, the resources involved in triggering the notification are included in the notification bundle. When a client receives a notification of this type, resources are already present in the bundle, though the client may need to fetch additional resources from the server. For example, the if the notification is for a topic about patient admission, the client may require related `Observation` resources.

When the content type is `full-resource`, notification bundles SHALL include references to the appropriate focus resources in the [SubscriptionStatus.notificationEvent.focus](http://hl7.org/fhir/subscriptionstatus-definitions.html#SubscriptionStatus.notificationEvent.focus) element.  This provides clients a fixed location to consolidate IDs for all notification types.

Notification bundles for `full-resource` subscriptions SHALL contain, in addition to the `SubscriptionStatus`, at least one `Bundle.entry` for each resource relevant to the notification. For example, a notification for a topic based on the Encounter resource SHALL include an Encounter and MAY include additional resources deemed relevant (e.g., the referenced Patient). Each `Bundle.entry` for a full-resource notification SHALL contain a relevant resource in the `entry.resource` element. If a server cannot include the resource contents due to an issue with a specific notification, the server SHALL populate the `entry.request` and/or `entry.response` elements.

From a security perspecitve, `full-resource` payloads should only be used when the channel is secure - notifications *will* contain PHI.