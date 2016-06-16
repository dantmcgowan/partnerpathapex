public class PartnerPathUtility {
   public static String assembleEndpoint(String pp_id) {
      //System.debug('>>>>>>>>>>>>>> PartnerPathUtility.assembleEndpoint');  
      PartnerPathConfig__c ppConfig = PartnerPathUtility.getConfig();
      return (ppConfig.Endpoint__c + pp_id);
   }
   public static PartnerPathConfig__c getConfig() {
      //System.debug('>>>>>>>>>>>>>> PartnerPathUtility.getConfig()');  
      String env = 'Production';
      if (!PartnerPathUtility.isSandbox()){
          env = 'Acceptance';
      }
      PartnerPathConfig__c config = PartnerPathConfig__c.getInstance(env); 
      return (config);
   }
   public static String getToken() {
      //System.debug('>>>>>>>>>>>>>> PartnerPathUtility.getToken()'); 
      PartnerPathConfig__c ppConfig = PartnerPathUtility.getConfig();
      return (ppConfig.Token__c);
   }
    public Static Boolean isSandbox(){
        return [SELECT isSandbox FROM Organization].isSandbox;       
    }
}