public class PartnerPathREST {
   @future (callout=true)
   public static void updateDeal(String pp_id, String env ) {
      Opportunity opportunity = [SELECT Id, Name, Amount, CloseDate, Probability, DeliveryInstallationStatus__c FROM Opportunity WHERE PartnerPath_ID__c = :pp_id];
      String probability = opportunity.Probability.toPlainString();
      String name = opportunity.Name;
      String amount = opportunity.Amount.toPlainString();
      DateTime cd_date = DateTime.newInstance(opportunity.CloseDate.year(), opportunity.CloseDate.month(), opportunity.CloseDate.day());
      String close_date =  cd_date.format('yyyy-MM-dd');
      String status = opportunity.DeliveryInstallationStatus__c;
      String external_lead_id = opportunity.id;
      System.debug('>>>>>>>>>>>>>> PartnerPathREST.updateDeal called with pp_id: ' + pp_id + ' name: ' + name + ' amount: ' + amount + ' close_date: ' + close_date + ' probability: ' + probability + ' status: ' + status);
      String endpoint = getEndpoint(env) + pp_id;
      if(probability == null || String.isBlank(probability)){
         System.debug('Deal with id ' + pp_id + ' does not have a value for probability.');
      }
      else if (! probability.isNumeric()) {
         System.debug('Deal with id ' + pp_id + ' does not have a valid value for probability: ' + probability + '. ');
      }
      else{
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
         req.setHeader('Authorization', 'Token access_token=thepartnerpathtoken');
         req.setBody(jsonDeal);
         req.setCompressed(false);
         System.debug('>>>>>>>>>>>>>>>>>>>>>>>>>> Content-Type: ' + req.getHeader('Content-Type') + ' ---------');
         System.debug('>>>>>>>>>>>>>>>>>>>>>>>>>> X-API-Version: ' + req.getHeader('X-API-Version') + ' ---------');
         System.debug('>>>>>>>>>>>>>>>>>>>>>>>>>> Authorization: ' + req.getHeader('Authorization') + ' ---------');
         System.debug('>>>>>>>>>>>>>>>>>>>>>>>>>> JSON Body: ' + req.getBody() + ' ---------');
         try {
            res = http.send(req);
            System.debug('>>>>>>>>>>>>>>>>>>> after REST call ' + res.getBody());
         } catch(System.CalloutException e) {
            System.debug('Callout error: '+ e);
            System.debug(res.toString());
         }
      }
   }
   public static String getEndpoint(String env) {
      String endpoint = '';
      if(env == null || env.trim().length() == 0){
         endpoint = 'http://demopath.test.amazonconsulting.com/api/deals/';
         return (endpoint);
      }
      if (env.equalsIgnoreCase('dev')){
         endpoint = 'http://demopath.dev.test.amazonconsulting.com/api/deals/';
      }
      else if (env.equalsIgnoreCase('qa')){
         endpoint = 'http://demopath.qa.test.amazonconsulting.com/api/deals/';
      }
      else if (env.equalsIgnoreCase('staging')){
         endpoint = 'http://demopath.staging.test.amazonconsulting.com/api/deals/';
      }
      else if (env.equalsIgnoreCase('prod')){
         endpoint = 'http://demopath.amazonconsulting.com/api/deals/';
      }
      else {
         endpoint = 'http://demopath.test.amazonconsulting.com/api/deals/';
      }
      return (endpoint);
   }
   // run PartnerPathREST.execute(); from Execute Anonymous to test
   public static void execute() {
      PartnerPathREST.updateDeal('1','accept');
   }
}