/*
*	Author:- Rahul Malhotra
*	Description:- This is the test class for ContactResource class
*	Created:- 15/02/2020
*	Last Updated:- 15/02/2020
*   Test Coverage:- 100%
*	Code Origin:- SFDCStop (https://www.sfdcstop.com/)
*	Tutorial:- Salesforce Integration Tutorial Series
*/
@isTest
public with sharing class ContactResourceTest {

    @TestSetup
    static void makeData() {
        List<Contact> contacts = new List<Contact>();
        // Inserting 5 contacts
        for(Integer i=0; i<5; i++) {
            Contact contact = new Contact(FirstName='Rahul', LastName='Malhotra');
            contacts.add(contact);
        }
        insert contacts;
    }

    @isTest
    static void testGetContactIdAndNames() {
        Test.startTest();
        // Testing the API
        List<Contact> returnedContacts = ContactResource.getContactIdAndNames(1);
        // Confirming the response
        System.assert(returnedContacts != null);
        System.assert(returnedContacts.size() == 1);
        System.assertEquals('Rahul Malhotra', returnedContacts[0].Name);
        Test.stopTest();
    }
}