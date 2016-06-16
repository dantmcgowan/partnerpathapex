public class PartnerPathREST {
    // Opportunity.Probability
    // Opportunity.Name
    // Opportunity.Amount
    // Opportunity.CloseDate
    // Opportunity.DeliveryInstallationStatus__c
    public static void checkDealUpdates(list<Opportunity> listOfOpps, map<Id, Opportunity> mapOfOldOpps) {
        Boolean dirty = false;
        Opportunity oldOpp;
        list<Opportunity> changedOpps = new list<Opportunity>();

        for (Opportunity opp : listOfOpps) {
            dirty = false;
            oldOpp = mapOfOldOpps.get(opp.Id);

            if (oldOpp.Probability.intValue() != (opp.Probability.intValue())) {
                dirty = true;
            } else if (!oldOpp.Name.equals(opp.Name)) {
                dirty = true;
            } else if (oldOpp.Amount.intValue() != opp.Amount.intValue()) {
                dirty = true;
            } else if (oldOpp.CloseDate != opp.CloseDate) {
                dirty = true;
            } else if (!oldOpp.DeliveryInstallationStatus__c.equals(opp.DeliveryInstallationStatus__c)) {
                dirty = true;
            }

            if (dirty) {
                changedOpps.add(opp);
            }
        }

        if (!changedOpps.isEmpty()) {
            PartnerPathREST.updateDeals(changedOpps);
        }
    }
    //Can be invoked independently from other processes
    public static void updateDeals(List<SObject> listOfSobjects){
        if(System.isBatch() || System.isFuture()){
            updateDealsSync(listOfSobjects);
        }else{
            updateDealsAsync(new list<Id>(new map<Id, Sobject>(listOfSobjects).keyset()));
        }
    }
    //Synchronous update when invoked from from batch and future contexts
    public static void updateDealsSync(List<Sobject> listOfSobjects){

        for(Sobject sobj : listOfSobjects){
            updateDeal((Opportunity) sobj);
        }

    }
    //Asynchronous update when invoked from trigger and other places
    @future (callout=true)
    public static void updateDealsAsync(list<Id> sobjectIds){
        Id sobjId = sobjectIds.get(0);
        for(Opportunity opp : [SELECT Id, PartnerPath_ID__c, Name, Amount, CloseDate, Probability, DeliveryInstallationStatus__c FROM Opportunity WHERE Id IN :sobjectIds]){
            updateDeal(opp);
        }
    }

    public static void updateDeal(Opportunity opportunity) {
        String endpoint = PartnerPathUtility.assembleEndpoint(opportunity.PartnerPath_ID__c);
        System.Debug('>>>>>>>  updateDeal: ');
        String token = PartnerPathUtility.getToken();
        System.Debug('>>>>>>>       Token: ' + PartnerPathUtility.getToken());
        System.Debug('>>>>>>>       Endpoint: ' + endpoint);
        if (opportunity != null) {
            String probability = opportunity.Probability.toPlainString();
            String name = opportunity.Name;
            String amount = opportunity.Amount.toPlainString();
            DateTime cd_date = DateTime.newInstance(opportunity.CloseDate.year(), opportunity.CloseDate.month(), opportunity.CloseDate.day());
            String close_date = cd_date.format('yyyy-MM-dd');
            String status = opportunity.DeliveryInstallationStatus__c;
            String external_lead_id = opportunity.id;
            System.debug('>>>>>>>>>>>>>> PartnerPathREST.updateDeal called with pp_id: ' + opportunity.PartnerPath_ID__c + ' name: ' + name + ' amount: ' + amount + ' close_date: ' + close_date + ' probability: ' + probability + ' status: ' + status);
            if (probability == null || String.isBlank(probability)) {
                System.debug('Deal with id ' + opportunity.PartnerPath_ID__c + ' does not have a value for probability.');
            } else if (!probability.isNumeric()) {
                System.debug('Deal with id ' + opportunity.PartnerPath_ID__c + ' does not have a valid value for probability: ' + probability + '. ');
            } else {
                // we are good on with REST call
                System.debug('>>>>>>>>>>>>>>>>>>> before REST call ==>');
                // Create a JSON generator object
                JSONGenerator gen = JSON.createGenerator(true);
                gen.writeStartObject();
                gen.writeFieldName('deal');
                gen.writeStartObject();
                gen.writeStringField('lead_name', name);
                gen.writeStringField('revenue_license', amount);
                gen.writeStringField('estimated_close_date', close_date);
                gen.writeStringField('close_probability', probability);
                gen.writeStringField('workflow_status', status);
                gen.writeStringField('external_lead_id', external_lead_id);
                gen.writeEndObject();
                gen.writeEndObject();
                // create a string from the JSON generator
                String jsonDeal = gen.getAsString();
                HttpRequest req = new HttpRequest();
                HttpResponse res = new HttpResponse();
                Http http = new Http();
                req.setEndpoint(endpoint);
                req.setMethod('PUT');
                //req.setMethod('GET');
                req.setHeader('Content-Type', 'application/json');
                req.setHeader('X-API-Version', '1');
                req.setHeader('Authorization', 'Token access_token=' + token);
                req.setBody(jsonDeal);
                req.setCompressed(false);
                System.debug('>>>>>>>>>>>>>>>>>>>>>>>>>> Content-Type: ' + req.getHeader('Content-Type') + ' ---------');
                System.debug('>>>>>>>>>>>>>>>>>>>>>>>>>> X-API-Version: ' + req.getHeader('X-API-Version') + ' ---------');
                System.debug('>>>>>>>>>>>>>>>>>>>>>>>>>> Authorization: ' + req.getHeader('Authorization') + ' ---------');
                System.debug('>>>>>>>>>>>>>>>>>>>>>>>>>> JSON Body: ' + req.getBody() + ' ---------');
                try {
                    res = http.send(req);
                    System.debug('>>>>>>>>>>>>>>>>>>> after REST call ' + res.getBody());
                } catch (System.CalloutException e) {
                    System.debug('Callout error: ' + e);
                    System.debug(res.toString());
                }
            }
        }
    }

}