The Subscription R5 Backport Implementation Guide enables servers running verions of FHIR earlier than R5 to implement a subset of R5 Subscriptions in a standardized way.

### About This Guide

During the development of FHIR R5, the Subscriptions Framework has gone through a significant redesign.  Many implementers have expressed a need for functionality from the FHIR R5 version of Subscriptions to be made available in FHIR R4.

The goal of publishing this guide is to define a standard method of back-porting the R5 Subscriptions Framework for greater compatibility and adoption.

### Contents

* [Background](background.html)
  * What are Subscriptions?
  * Subscriptions in R4
  * Subscriptions in R5
  * This IG

* Specification
  * [Actors](actors.html)
    * Server
    * Client
    * Endpoint
  * [Components](components.html)
    * Subscription Topics
    * Subscriptions
    * Notifications
  * [Workflow](workflow.html)
  * [Notifications](notifications.html)
    * Handshake
    * Heartbeat
    * Event Notification
    * Query Status
    * Query Event
  * [Channels](channels.html)
    * REST-Hook (http/s POST)
    * Websockets
    * Email
    * FHIR Messaging
  * [Payloads](payloads.html)
    * Empty
    * Id Only
    * Full Resource
  * [Conformance](conformance.html)
  * [Handling Errors](errors.html)
 
* [Safety and Security](safety_security.html)

* Profiles and Extensions
  * Profile: [Subscription](StructureDefinition-backport-subscription.html)
    * Extension: [Backport Channel Type](StructureDefinition-backport-channel-type.html)
    * Extension: [Backport Filter Criteria](StructureDefinition-backport-filter-criteria.html)
    * Extension: [Backport Heartbeat Period](StructureDefinition-backport-heartbeat-period.html)
    * Extension: [Backport Timeout](StructureDefinition-backport-timeout.html)
    * Extension: [Backport Notification Max Count](StructureDefinition-backport-max-count.html)
    * Extension: [Backport Payload Content](StructureDefinition-backport-payload-content.html)
  * Profile: Notification [Bundle](StructureDefinition-backport-subscription-notification.html)

* Operations
  * Operation: [$get-ws-binding-token](OperationDefinition-backport-subscription-get-ws-binding-token.html)
  * Operation: [$status](OperationDefinition-backport-subscription-status.html)
  * Operation: [$events](OperationDefinition-backport-subscription-events.html)

* Value Sets and Code Systems
  * Subscription Contents
    * [Code System](CodeSystem-backport-content-code-system.html)
    * [Value Set](ValueSet-backport-content-value-set.html)
  * Subscription Notification Types
    * [Code System](CodeSystem-backport-notification-type-code-system.html)
    * [Value Set](ValueSet-backport-notification-type-value-set.html)
  * Subscription Notification URL Location
    * [Code System](CodeSystem-backport-notification-url-location-code-system.html)
    * [Value Set](ValueSet-backport-notification-url-location-value-set.html)

* [Downloads](downloads.html)