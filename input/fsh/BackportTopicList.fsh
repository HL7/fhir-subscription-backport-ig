Profile:     BackportTopicList
Parent:      Parameters
Id:          backport-subscription-topic-canonical-urls
Title:       "Backported R5 SubscriptionTopic Canonical URL Parameters"
Description: "Profile on the R4 Parameters resource to enable R5-style topic-based subscriptions in FHIR R4."
* ^jurisdiction = http://unstats.un.org/unsd/methods/m49/m49.htm#001
* parameter  ^slicing.discriminator.type = #value
* parameter  ^slicing.discriminator.path = "name"
* parameter  ^slicing.rules = #open
* parameter  ^slicing.ordered = false
* parameter  ^slicing.description = "Slice on parameter name"
* parameter contains subscriptionTopicCanonical 0..* MS
* parameter[subscriptionTopicCanonical].name = "subscription-topic-canonical" (exactly)
* parameter[subscriptionTopicCanonical].value[x] 1..1 MS
* parameter[subscriptionTopicCanonical].value[x] only canonical

Instance:    BackportTopicListExampleSingle
InstanceOf:  BackportTopicList
Usage:       #example
Title:       "Backported Subscription Topic List"
Description: "Example of a backported subscription topic list with a single entry."
* id       = "topic-list-single"
* parameter[subscriptionTopicCanonical].name = "subscription-topic-canonical"
* parameter[subscriptionTopicCanonical].valueCanonical = "http://argonautproject.org/encounters-ig/SubscriptionTopic/encounter-start"