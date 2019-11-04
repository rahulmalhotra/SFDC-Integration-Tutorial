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

}