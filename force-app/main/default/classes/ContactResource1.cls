// Setting up the Request URL
@RestResource(urlMapping='/ContactAPI1/*')
global with sharing class ContactResource1 {
    // Post Method
    @HTTPPost
    global static Contact createNewContact() {
        // Initializing the request parameter with the incoming request
        RestRequest contactRequest = RestContext.request;
        // Getting the request body from the request
        String requestBody = contactRequest.requestBody.toString();
        // Deserializing the JSON response body and assigning it to an instance of Contact object
        Contact contact = (Contact) JSON.deserialize(requestBody, Contact.class);
        // Inserting Contact
        insert contact;
        // Returning the contact in the response
        return contact;
    }
}