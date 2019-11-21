@isTest
public with sharing class ContactResourceTest {

    @TestSetup
    static void makeData() {
        // Inserting a new contact
        Contact contactTest = new Contact(FirstName='Richard', LastName='Hendricks');
        insert contactTest;
    }

    // Testing the GET request
    @isTest
    static void testGetContactIdAndNames() {
        Test.startTest();
        // Forming the request
        RestRequest contactRequest = new RestRequest();
        contactRequest.requestUri = 'https://ap5.salesforce.com/services/apexrest/ContactAPI/1';
        contactRequest.httpMethod = 'GET';
        RestContext.request = contactRequest;
        // Testing the API
        List<Contact> returnedContacts = ContactResource.getContactIdAndNames();
        // Confirming the response
        System.assert(returnedContacts != null);
        System.assert(returnedContacts.size() == 1);
        System.assertEquals('Richard Hendricks', returnedContacts[0].Name);
        Test.stopTest();
    }

    // Testing the POST request
    @isTest
    static void testCreateNewContact() {
        Test.startTest();
        // Testing the API
        Contact returnedContact = ContactResource.createNewContact('Gavin', 'Belson', '03/03/1980', 'Web');
        System.assert(returnedContact != null);
        System.assert(returnedContact.Id != null);
        // Querying the newly created contact
        Contact queriedContact = [SELECT LeadSource FROM Contact WHERE Id =: returnedContact.Id];
        // Confirming the response
        System.assert(queriedContact != null);
        System.assertEquals(returnedContact.LeadSource, queriedContact.LeadSource);
        Test.stopTest();
    }

    // Testing the DELETE request
    @isTest
    static void testDeleteContact() {
        Test.startTest();
        // Querying the contact to delete
        Contact contactToDelete = [SELECT Id FROM Contact LIMIT 1];
        // Forming the request
        RestRequest contactRequest = new RestRequest();
        contactRequest.requestUri = 'https://ap5.salesforce.com/services/apexrest/ContactAPI/' + contactToDelete.Id;
        contactRequest.httpMethod = 'DELETE';
        RestContext.request = contactRequest;
        // Testing the API
        Map<String, String> responseMap = ContactResource.deleteContact();
        // Confirming the response
        Contact queriedContact = [SELECT Id, IsDeleted FROM Contact WHERE Id =:contactToDelete.Id ALL ROWS];
        System.assertEquals('1', responseMap.get('success'));
        System.assert(queriedContact.IsDeleted);
        Test.stopTest();
    }

    // Testing the UPSERT request
    @isTest
    static void testUpsertContact() {
        Test.startTest();
        // Querying the contact to upsert
        Contact contactToUpsert = [SELECT Id FROM Contact LIMIT 1];
        // Forming the request
        RestRequest contactRequest = new RestRequest();
        contactRequest.requestUri = 'https://ap5.salesforce.com/services/apexrest/ContactAPI/' + contactToUpsert.Id;
        contactRequest.httpMethod = 'PUT';
        RestContext.request = contactRequest;
        // Testing the API
        Contact returnedContact = ContactResource.upsertContact('Gavin', 'Belson', '03/03/1980', 'Phone Enquiry');
        // Confirming the response
        Contact queriedContact = [SELECT Name, LeadSource FROM Contact WHERE Id =: contactToUpsert.Id];
        System.assertEquals(returnedContact.Id, queriedContact.Id);
        System.assertEquals('Gavin Belson', queriedContact.Name);
        System.assertEquals('Phone Enquiry', queriedContact.LeadSource);
        Test.stopTest();
    }

    // Testing the UPDATE request
    @isTest
    static void testUpdateContact() {
        Test.startTest();
        // Querying the contact to update
        Contact contactToUpdate = [SELECT Id FROM Contact LIMIT 1];
        // Updating the first name of contact
        Contact contact = new Contact();
        contact.FirstName = 'Gavin';
        // Forming the request
        RestRequest contactRequest = new RestRequest();
        contactRequest.requestUri = 'https://ap5.salesforce.com/services/apexrest/ContactAPI/' + contactToUpdate.Id;
        contactRequest.httpMethod = 'PATCH';
        contactRequest.requestBody = Blob.valueOf(JSON.serialize(contact));
        RestContext.request = contactRequest;
        // Testing the API
        Contact returnedContact = ContactResource.updateContact();
        // Confirming the response
        Contact queriedContact = [SELECT FirstName, LastName FROM Contact WHERE Id =: contactToUpdate.Id];
        System.assertEquals(returnedContact.Id, queriedContact.Id);
        System.assertEquals('Gavin', queriedContact.FirstName);
        System.assertEquals('Hendricks', queriedContact.LastName);
        Test.stopTest();
    }

    // Testing the DELETE request with Exception
    @isTest
    static void testDeleteContactWithException() {
        Test.startTest();
        // Querying the contact to delete
        Contact contactToDelete = [SELECT Id FROM Contact LIMIT 1];
        // Deleting the contact
        delete contactToDelete;
        // Forming the request with deleted contact id
        RestRequest contactRequest = new RestRequest();
        contactRequest.requestUri = 'https://ap5.salesforce.com/services/apexrest/ContactAPI/' + contactToDelete.Id;
        contactRequest.httpMethod = 'DELETE';
        RestContext.request = contactRequest;
        // Testing the API
        Map<String, String> responseMap = ContactResource.deleteContact();
        // Confirming the response
        System.assertEquals('0', responseMap.get('success'));
        Test.stopTest();
    }
}