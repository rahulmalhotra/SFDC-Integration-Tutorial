// Setting up the Request URL
@RestResource(urlMapping='/ContactAPI/*')
global with sharing class ContactResource {
    // PUT Method
    @HTTPPut
    global static Contact upsertContact(String firstName, String lastName, String birthDate, String leadSource) {
        // Initializing the request parameter with the incoming request
        RestRequest contactRequest = RestContext.request;
        // Getting the request URI
        String contactRequestURI = contactRequest.requestURI;
        // Getting the contact id from the request URI
        String contactId = contactRequestURI.substring(contactRequestURI.lastIndexOf('/') + 1);
        // Initializing contact to upsert
        Contact contact = new Contact();
        if(String.isNotEmpty(contactId)) {
            contact.Id = contactId;
        }
        contact.FirstName = firstName;
        contact.LastName = lastName;
        contact.Birthdate = Date.parse(birthDate);
        contact.LeadSource = leadSource;
        // Upserting Contact
        upsert contact;
        // Returning the contact in the response
        return contact;
    }
}