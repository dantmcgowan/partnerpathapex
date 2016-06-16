@IsTest
public class PartnerPathRESTTest {
    // Opportunity.Probability
    // Opportunity.Name
    // Opportunity.Amount
    // Opportunity.CloseDate
    // Opportunity.DeliveryInstallationStatus__c
    @testSetup static void setup() {
        // Test data setup
        //
        // Custom Setting
        //
        String endpoint = 'http://demopath.test.amazonconsulting.com/api/deals/';
        String token = '337a966a061ed2beb61f5172772162a8';
        PartnerPathConfig__c cs = new PartnerPathConfig__c(Name = 'Acceptance',
                Token__c = token,
                Endpoint__c = endpoint);
        insert cs;
        // Create an account with an opportunity
        Account acct = new Account(Name = 'Test Account');
        insert acct;
        Opportunity opp = new Opportunity(Name = acct.Name + ' Opportunity',
                StageName = 'Prospecting',
                PartnerPath_ID__c = '23032',
                Probability = 55.00,
                Amount = 35000.00,
                DeliveryInstallationStatus__c = 'New',
                CloseDate = System.today().addMonths(1),
                AccountId = acct.Id);
        insert opp;
    }
    @isTest static void testUpdateProbability() {
        // Fetch inserts
        Account acct = [SELECT Id, Name FROM Account WHERE Name = 'Test Account'];
        Opportunity opp = [SELECT Id, PartnerPath_ID__c FROM Opportunity WHERE PartnerPath_ID__c = '23032'];
        opp.Probability = 95.00;
        // HTTP calls get routed to mock instead of out to the internet
        Test.setMock(HttpCalloutMock.class, new Mock());
        // Perform test
        Test.startTest();
        update opp;
        Test.stopTest();
        //
        // Verify
        //
        Database.DeleteResult resultAcct = Database.delete(acct, false);
        Database.DeleteResult resultOpp = Database.delete(opp, false);
        System.assert(resultOpp.isSuccess());
    }
    @isTest static void testUpdateName() {
        // Fetch inserts
        Account acct = [SELECT Id, Name FROM Account WHERE Name = 'Test Account'];
        Opportunity opp = [SELECT Id, PartnerPath_ID__c FROM Opportunity WHERE PartnerPath_ID__c = '23032'];
        opp.Name = 'Wild Thang';
        // HTTP calls get routed to mock instead of out to the internet
        Test.setMock(HttpCalloutMock.class, new Mock());
        // Perform test
        Test.startTest();
        update opp;
        Test.stopTest();
        //
        // Verify
        //
        Database.DeleteResult resultAcct = Database.delete(acct, false);
        Database.DeleteResult resultOpp = Database.delete(opp, false);
        System.assert(resultOpp.isSuccess());
    }
    @isTest static void testUpdateAmount() {
        // Fetch inserts
        Account acct = [SELECT Id, Name FROM Account WHERE Name = 'Test Account'];
        Opportunity opp = [SELECT Id, PartnerPath_ID__c FROM Opportunity WHERE PartnerPath_ID__c = '23032'];
        opp.Amount = 42000.0;
        // HTTP calls get routed to mock instead of out to the internet
        Test.setMock(HttpCalloutMock.class, new Mock());
        // Perform test
        Test.startTest();
        update opp;
        Test.stopTest();
        //
        // Verify
        //
        Database.DeleteResult resultAcct = Database.delete(acct, false);
        Database.DeleteResult resultOpp = Database.delete(opp, false);
        System.assert(resultOpp.isSuccess());
    }
    @isTest static void testUpdateCloseDate() {
        // Fetch inserts
        Account acct = [SELECT Id, Name FROM Account WHERE Name = 'Test Account'];
        Opportunity opp = [SELECT Id, PartnerPath_ID__c FROM Opportunity WHERE PartnerPath_ID__c = '23032'];
        opp.CloseDate =  System.today().addMonths(3);
        // HTTP calls get routed to mock instead of out to the internet
        Test.setMock(HttpCalloutMock.class, new Mock());
        // Perform test
        Test.startTest();
        update opp;
        Test.stopTest();
        //
        // Verify
        //
        Database.DeleteResult resultAcct = Database.delete(acct, false);
        Database.DeleteResult resultOpp = Database.delete(opp, false);
        System.assert(resultOpp.isSuccess());
    }
    @isTest static void testUpdateDeliveryInstallationStatus() {
        // Fetch inserts
        Account acct = [SELECT Id, Name FROM Account WHERE Name = 'Test Account'];
        Opportunity opp = [SELECT Id, PartnerPath_ID__c FROM Opportunity WHERE PartnerPath_ID__c = '23032'];
        opp.DeliveryInstallationStatus__c = 'Closed';
        // HTTP calls get routed to mock instead of out to the internet
        Test.setMock(HttpCalloutMock.class, new Mock());
        // Perform test
        Test.startTest();
        update opp;
        Test.stopTest();
        //
        // Verify
        //
        Database.DeleteResult resultAcct = Database.delete(acct, false);
        Database.DeleteResult resultOpp = Database.delete(opp, false);
        System.assert(resultOpp.isSuccess());
    }
}