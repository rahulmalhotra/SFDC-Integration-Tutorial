// Setting up the Request URL
@RestResource(urlMapping='/ContactAPI/*')
global with sharing class ContactResource {

    // Get Method
    @HTTPGet
    global static List<Contact> getContactIdAndNames() {
        // Initializing the request parameter with the incoming request
        RestRequest contactRequest = RestContext.request;
        // Getting the request URI
        String contactRequestURI = contactRequest.requestURI;
        // Getting the limit from the request URI
        Integer contactLimit = Integer.valueOf(contactRequestURI.substring(contactRequestURI.lastIndexOf('/') + 1));
        // Querying contacts
        List<Contact> contactList = [SELECT Id, Name FROM Contact LIMIT :contactLimit];
        // Returning the contacts in the response
        return contactList;
    }

    // POST Method
    @HTTPPost
    global static Contact createNewContact(String firstName, String lastName, String birthDate, String leadSource) {
        // Initializing New Contact
        Contact contact = new Contact();
        contact.FirstName = firstName;
        contact.LastName = lastName;
        contact.Birthdate = Date.parse(birthDate);
        contact.LeadSource = leadSource;
        // Inserting Contact
        insert contact;
        // Returning the contact in the response
        return contact;
    }

    // DELETE Method
    @HTTPDelete
    global static Map<String, String> deleteContact() {
        // Initializing the response map
        Map<String, String> responseMap = new Map<String, String>();
        // Initializing the request parameter with the incoming request
        RestRequest contactRequest = RestContext.request;
        // Getting the request URI
        String contactRequestURI = contactRequest.requestURI;
        // Getting the contact id from the request URI
        Id contactId = Id.valueOf(contactRequestURI.substring(contactRequestURI.lastIndexOf('/') + 1));
        // Initializing contact to delete
        Contact contact = new Contact(Id=contactId);
        // Deleting contact
        try {
            delete contact;
            responseMap.put('success', '1');
            responseMap.put('message', 'Record Deleted Successfully');
        } catch(DmlException ex) {
            responseMap.put('success', '0');
            responseMap.put('message', ex.getMessage());
        }
        // Returning the response map in the response
        return responseMap;
    }

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
        // Assigning id to the contact if the contact id obtained from the URL is not empty
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

    // PATCH Method
    @HTTPPatch
    global static Contact updateContact() {
        // Initializing the request parameter with the incoming request
        RestRequest contactRequest = RestContext.request;
        // Getting the request URI
        String contactRequestURI = contactRequest.requestURI;
        // Getting the contact id from the request URI
        String contactId = contactRequestURI.substring(contactRequestURI.lastIndexOf('/') + 1);
        // Getting the request body from the request
        String requestBody = contactRequest.requestBody.toString();
        // Creating an instance of contact object
        Contact contact;
        // Checking if the contact id obtained from the URL is not empty
        if(String.isNotEmpty(contactId)) {
            // Deserializing the JSON response body and assigning it to the instance of Contact object
            contact = (Contact) JSON.deserialize(requestBody, Contact.class);
            // Assigning the contact id
            contact.Id = contactId;
            // Updating Contact
            update contact;
        }
        // Returning the contact in the response
        return contact;
    }
}