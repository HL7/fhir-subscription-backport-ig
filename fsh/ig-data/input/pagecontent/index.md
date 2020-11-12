The Subscription R5 Backport Implementation Guide enables servers running verions of FHIR earlier than R5 to implement a subset of R5 Subscriptions in a standardized way.

### About This Guide

During the development of FHIR R5, the Subscriptions Framework has gone through a significant redesign.  Many implementers have expressed a need for functionality from the FHIR R5 version of Subscriptions to be made available in FHIR R4.

The goal of publishing this guide is to define a standard method of back-porting the R5 Subscriptions Framework for greater compatibility and adoption.

### Contents

* [Overview](overview.html)
  * Comonents of a Subscription
    * Subscription Topics
    * Subscriptions
    * Subscription Notifications
  * Safety and Security

* [Actors and Operations](actors_and_operations.html)
  * Server
  * Client
  * Endpoint
    * REST Hook
    * Websocket
    * Email
    * FHIR Messaging

* [Implementation Conformance](conformance.html)

* [Handling Errors](errors.html)
  * Handling Errors as a Server
  * Detecting Errors as a Client
  * Recovering from Errors

* Profiles and Extensions
  * Profile: [Subscription](StructureDefinition-backport-subscription.html)
    * Extension: [Backport Topic Canonical](StructureDefinition-backport-topic-canonical.html)
    * Extension: [Backport Heartbeat Period](StructureDefinition-backport-heartbeat-period.html)
    * Extension: [Backport Timeout](StructureDefinition-backport-timeout.html)
    * Extension: [Backport Payload Content](StructureDefinition-backport-payload-content.html)
  * Profile: Subscription Status - [Parameters](StructureDefinition-backport-subscription-status.html)
  * Profile: Notification [Bundle](StructureDefinition-backport-subscription-notification.html)

* Value Sets and Code Systems
  * Subscription Contents
    * [Code System](CodeSystem-backport-content-code-system.html)
    * [Value Set](ValueSet-backport-content-value-set.html)
  * Subscription Notification Types
    * [Code System](CodeSystem-backport-notification-type-code-system.html)
    * [Value Set](ValueSet-backport-notification-type-value-set.html)
