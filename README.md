# partnerpathapex
Necessary SFDC configuration and APEX code to facilitate PartnerPath synchronization. 

[Salesforce] Integration with the [PartnerPath] portal. Synchronize:
  - [Lead]
  - [Opportunity]
  - [Account]
  - [Contact]
  - [Custom Objects]

with your [PartnerPath] application. Using [Apex] classes and triggers allows you to *synchronize* your web application with your [Salesforce] implementation.

Note: You need not be a [PartnerPath] customer to leverage the provided code. You simply need a third party [REST] based application to receive the updates from your [Salesforce] implementation. Substitute your application authorization credentials and API calls and off you go!

## Version
1.0.0

## Configuration
Synchronization requires a [Salesforce] **Connected App**
See the wiki regarding [Configuring a Connected App]
## Installation
Apply the code below to your [Salesforce] implementation using the steps shown in the [Apex Tutorial].
## Code
Note: In order for syntax hilighting to work these source files have been renamed. Please follow **TODO** at the top of earch file to rename with the required extension.
[Apex Trigger] and [Apex Class]

## Development/Contact
[Dan McGowan]

## Todo's

Write Tests


<sub>[PartnerPath] &copy; 2015</sub>

[Dan McGowan]:<mailto:dmcgowan@partner-path.com>
[account]:https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/sforce_api_objects_account.htm#topic-title
[opportunity]:https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/sforce_api_objects_opportunity.htm#topic-title
[contact]:https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/sforce_api_objects_contact.htm#topic-title
[lead]:https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/sforce_api_objects_lead.htm#topic-title
[custom objects]:https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/sforce_api_objects_custom_objects.htm
[partnerpath]:http://demopath.test.amazonconsulting.com/api/v1/
[salesforce]:http://salesforce.com
[rest]:http://www.restapitutorial.com/lessons/whatisrest.html
[apex]:https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/
[apex trigger]:https://github.com/dantmcgowan/partnerpathapex/blob/master/src/apex/triggers/PPDealUpdate.apxt
[apex class]:https://github.com/dantmcgowan/partnerpathapex/blob/master/src/apex/classes/PartnerPathREST.apxc
[apex tutorial]:https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_qs_HelloWorld.htm
[configuring a connected app]:https://github.com/dantmcgowan/partnerpathapex/wiki
