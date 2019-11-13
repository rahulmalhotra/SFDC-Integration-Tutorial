// Setting up the Request URL
@RestResource(urlMapping='/ContactAPI/*')
global with sharing class ContactResource {
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