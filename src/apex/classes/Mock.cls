public class Mock implements HttpCalloutMock {
    public HTTPResponse respond(HTTPRequest req) {
        HTTPResponse res = new HTTPResponse();
        res.setStatusCode(200);
        res.setBody('{message: "OK"}');
        return (res);
    }
}