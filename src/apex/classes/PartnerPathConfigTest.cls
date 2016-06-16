@IsTest
public class PartnerPathConfigTest {
    @testSetup static void setup() {
        // Test data setup
        // Custom Setting
        String endpoint = 'http://demopath.test.amazonconsulting.com/api/deals/';
        String token = '770a966a061ed2beb61f5172772162a8';
        PartnerPathConfig__c cs = new PartnerPathConfig__c(Name='Acceptance',
                Token__c = token,
                Endpoint__c = endpoint);
        insert cs;
    }
    @isTest static void testCustomSetting(){
        String endpoint = 'http://demopath.test.amazonconsulting.com/api/deals/';
        // Perform test
        Test.startTest();
        System.Debug('>>>>>>>  testCustomSetting: ');
        PartnerPathConfig__c config = PartnerPathConfig__c.getInstance('Acceptance');
        System.Debug('>>>>>>>     Name: ' + config.Name);
        Test.stopTest();
        //
        System.assertNotEquals(null, config);
        System.assertEquals(endpoint, config.Endpoint__c);
    }
}