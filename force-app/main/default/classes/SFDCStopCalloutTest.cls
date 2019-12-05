// Test class for SFDCStopCallout class
@isTest
public with sharing class SFDCStopCalloutTest {
    // Method to test getBlogs() method
    @isTest
    public static void testGetBlogs() {
        Test.startTest();
        // Setting up the mock response
        Test.setMock(HTTPCalloutMock.class, new SFDCStopMock());
        // Performing the API callout
        HTTPResponse response = SFDCStopCallout.getBlogs();
        // Verifying the response information
        System.assertEquals(200, response.getStatusCode());
        System.assertEquals('application/json', response.getHeader('Content-Type'));
        System.assertEquals('{"author":"Rahul Malhotra","blogs":[{"id":"1","title":"Salesforce Integration Tutorial Part1 - Introduction and Setting up Workbench","url":"https://www.sfdcstop.com/2019/11/salesforce-integration-tutorial-part-1.html"},{"id":"2","title":"Salesforce Integration Tutorial Part 2 - Exploring GET Method","url":"https://www.sfdcstop.com/2019/11/salesforce-integration-tutorial-part-2.html"}]}', response.getBody());
        Test.stopTest();
    }
}
