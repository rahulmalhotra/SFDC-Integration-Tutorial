// Mock class for SFDC Stop API
@isTest
global class SFDCStopMock implements HTTPCalloutMock {
    // Creating a fake response
    global HTTPResponse respond(HTTPRequest request) {
        HTTPResponse response = new HTTPResponse();
        // Setting the response body
        response.setBody('{"author":"Rahul Malhotra","blogs":[{"id":"1","title":"Salesforce Integration Tutorial Part1 - Introduction and Setting up Workbench","url":"https://www.sfdcstop.com/2019/11/salesforce-integration-tutorial-part-1.html"},{"id":"2","title":"Salesforce Integration Tutorial Part 2 - Exploring GET Method","url":"https://www.sfdcstop.com/2019/11/salesforce-integration-tutorial-part-2.html"}]}');
        // Setting the response header
        response.setHeader('Content-Type', 'application/json');
        // Setting the response code
        response.setStatusCode(200);
        // Returning the response
        return response;
    }
}
