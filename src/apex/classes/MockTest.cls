/**
 * Created by mookie on 6/14/16.
 */

@IsTest
public class MockTest {
    @isTest static void testMock(){
        //
        // Perform test
        //
        Test.startTest();
        HTTPRequest req = new HTTPRequest();
        Mock mock = new Mock();
        HTTPResponse res = mock.respond(req);
        Test.stopTest();
        //
        // Verify
        //
        System.assertEquals(200,res.getStatusCode());
    }
}