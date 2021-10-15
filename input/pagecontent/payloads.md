### Payload Types

There are three options available when specifying the contents of a Notification: `empty`, `id-only`, and `full-resource`. These options change the level of detail conveyed in the notification Bundle.

When deciding which payload type to request, systems SHOULD consider both ease of processing and security of PHI. To mitigate the risk of information leakage, systems SHOULD use the minimum level of detail consistent with the use case. In practice, `id-only` provides a good balance between security and performance for many real-world scenarios.

<figure>
  {% include payload-comparison.svg %}
  <figcaption>Diagram showing the different round-trips based on payload types</figcaption>
</figure>


If a server will not honor a payload type (e.g., will not send `full-resource` over HTTP), it SHOULD reject the Subscription request, but the server MAY accept the subscription with modifications.

#### Empty

With the content type of `empty`, no information about the resources involved in triggering the notification is available via the subscription channel. This mitigates many security concerns by both removing most PHI from the notification and allows servers to consolidate authorization and authentication logic. When the subscriber receives a notification of this type, it may query the server to fetch all the relevant resources based on the SubscriptionTopic and applicable filters. The client might include a `_since=` query parameter, supplying its last query timestamp to retrieve only the most recent resources. For example, if the notification is for a topic about patient admission, the subscriber will generally query for recent `Encounters` for a patient or group of patients, then fetch them as needed.

When the content type is `empty`, notification bundles SHALL not contain `Bundle.entry` elements other than the `SubscriptionStatus` used to convey status information about the notification.

#### Id Only

With the content type of `id-only`, the resources involved in triggering the notification are only available through other channels (e.g., REST API), but notifications include URLs which can be used to access those resources. This allows servers to consolidate authorization and authentication logic, while removing the need for expensive queries by subscribers. When a subscriber receives a notification of this type, it may directly fetch all the relevant resources using the supplied resource ids. For example, if the notification is for a topic about patient admission, the subscriber may fetch the `Encounter` resources for a patient or group of patients using URLs included in the notification.

When the content type is `id-only`, notification bundles SHALL contain, in addition to the `SubscriptionStatus` used to convey status information, at least one `Bundle.entry` for each resource relevant to the notification. For example, a notification for a topic based on `Encounter` SHALL include a reference to the `Encounter` and MAY include additional resources deemed relevant (e.g., the linked `Patient`).

Each `Bundle.entry` for `id-only` notification SHALL contain a relevant resource URL in the `fullUrl` and `request` elements, as is requred for `history` bundles

#### Full Resource

With the content type of `full-resource`, the resources involved in triggering the notification are included in the notification bundle. When a subscriber receives a notification of this type, resources are already present in the bundle, though the subscriber may need to fetch additional resources from the server. For example, the if the notification is for a topic about patient admission, the subscriber may require related `Observation` resources.

When the content type is `full-resource`, notification bundles SHALL contain, in addition to the `SubscriptionStatus` for status information, at least one `Bundle.entry` for each resource relevant to the notification. For example, a notification for a topic based on `Encounter` SHALL include an `Encounter` and MAY include additional resources deemed relevant (e.g., the relevant `Patient`).

In most scenarios, each `Bundle.entry` for a `full-resource` notification SHALL contain a relevant resource in the `resource` element. In some scenarios, it is not possible to include the resource, in which case `entry.request` and/or `entry.response` are required. For example, in the case of a notification about a deleted resource, the server may no longer have access to the resource. In this case, information in the `entry.response` is critical for a subscriber to process the notification (e.g., the `etag`).
