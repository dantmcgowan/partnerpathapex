/**
 * TODO: Rename this file to PPDealUpdate.apxt
 */
trigger PPDealUpdate on Opportunity (after update) {

        System.debug('>>>>>>>>>>>>>> trigger PPDealUpdate called ');
        String environment = 'accept';
        PartnerPathRest.updateDeal(Trigger.new[0].PartnerPath_ID__c, environment);

}