// Setting up the Request URL
@RestResource(urlMapping='/ContactAPI/*')
global with sharing class ContactResource {
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
}