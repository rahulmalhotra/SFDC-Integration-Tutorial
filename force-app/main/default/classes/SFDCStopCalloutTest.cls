// Test class for SFDCStopCallout class
@isTest
public with sharing class SFDCStopCalloutTest {

    public static Integer RESPONSE_CODE = 200;
    public static String RESPONSE_HEADER_KEY = 'Content-Type';
    public static String RESPONSE_HEADER_VALUE = 'application/json';
    public static String RESPONSE_BODY = '{"author":"Rahul Malhotra","blogs":[{"id":"1","title":"Salesforce Integration Tutorial Part1 - Introduction and Setting up Workbench","url":"https://www.sfdcstop.com/2019/11/salesforce-integration-tutorial-part-1.html"},{"id":"2","title":"Salesforce Integration Tutorial Part 2 - Exploring GET Method","url":"https://www.sfdcstop.com/2019/11/salesforce-integration-tutorial-part-2.html"}]}';

    // Method to test getBlogs() method
    @isTest
    public static void testGetBlogs() {
        Test.startTest();
        // Setting up the mock response
        Test.setMock(HTTPCalloutMock.class, new SFDCStopMock());
        // Performing the API callout
        HTTPResponse response = SFDCStopCallout.getBlogs();
        // Verifying the response information
        System.assertEquals(RESPONSE_CODE, response.getStatusCode());
        System.assertEquals(RESPONSE_HEADER_VALUE, response.getHeader(RESPONSE_HEADER_KEY));
        System.assertEquals(RESPONSE_BODY, response.getBody());
        Test.stopTest();
    }

    // Method to test getBlogs() method using HTTPCalloutFramework
    @isTest
    public static void testGetBlogsUsingFramework() {
        Test.startTest();
        // Initializing the mock response class
        HTTPCalloutServiceMock sfdcStopApiMock = new HTTPCalloutServiceMock();
        sfdcStopApiMock.setResponseCode(RESPONSE_CODE);
        sfdcStopApiMock.setResponseBody(RESPONSE_BODY);
        sfdcStopApiMock.setResponseHeader(RESPONSE_HEADER_KEY, RESPONSE_HEADER_VALUE);
        // Setting up the mock response
        Test.setMock(HTTPCalloutMock.class, sfdcStopApiMock);
        // Performing the API callout
        HTTPResponse response = SFDCStopCallout.getBlogs();
        // Verifying the response information
        System.assertEquals(RESPONSE_CODE, response.getStatusCode());
        System.assertEquals(RESPONSE_HEADER_VALUE, response.getHeader(RESPONSE_HEADER_KEY));
        System.assertEquals(RESPONSE_BODY, response.getBody());
        Test.stopTest();
    }
}