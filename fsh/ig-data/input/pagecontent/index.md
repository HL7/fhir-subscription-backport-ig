The Subscription R5 Backport Implementation Guide enables servers running verions of FHIR earlier than R5 to implement a subset of R5 Subscriptions in a standardized way.

## About This Guide

This is a draft implementation guide to enable the implementation of R5-style subscriptions in earlier versions of FHIR.

The goal of publishing this guide is to define a standard method of back-porting newer subscriptions for greater compatibility and adoption.

## Contents

* [Overview](overview.html)
  * R5 Subscription Redesign
  * Subscriptions Overview
  * Useful Links

* [Actors and Operations](actors_and_transactions.html)
  * Server
  * Client
  * Endpoint (REST Hook)
  * Endpoint (Email)

* [Implementation Conformance](conformance.html)

* Handling Errors
  * Server
  * Client

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
