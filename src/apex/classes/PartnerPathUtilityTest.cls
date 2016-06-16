@isTest
public class PartnerPathUtilityTest {
    @testSetup static void setup() {
        // Test data setup
        // Custom Setting
        String endpoint = 'http://demopath.test.amazonconsulting.com/api/deals/';
        String token = '742a966a061ed2beb61f5179162162a8';
        PartnerPathConfig__c cs = new PartnerPathConfig__c(Name='Acceptance',
                Token__c = token,
                Endpoint__c = endpoint);
        insert cs;
    }
    @isTest static void testIsSandbox(){
        // Perform test
        Test.startTest();
        Boolean isSandbox = PartnerPathUtility.isSandbox();
        Test.stopTest();
        // 
        System.assertNotEquals(true, isSandbox);
    }
    @isTest static void testAssembleEndpoint(){
        // Test data setup
        String endpoint_input = 'http://demopath.test.amazonconsulting.com/api/deals/';
        // Perform test
        Test.startTest();
        String endpoint_read = PartnerPathUtility.assembleEndpoint('1');
        Test.stopTest();
        // 
        System.assert(endpoint_read.startsWith(endpoint_input));
    }
}