// Setting up the Request URL
@RestResource(urlMapping='/ContactAPI1/*')
global with sharing class ContactResource1 {

    // Get Method
    @HTTPGet
    global static List<Contact> getContactIdNameAndLeadSource() {
        // Initializing the request parameter with the incoming request
        RestRequest contactRequest = RestContext.request;
        // Getting the URL parameters from the request
        Map<String, String> contactRequestParams = contactRequest.params;
        // Getting the limit and leadsource from the request URL params
        Integer contactLimit = Integer.valueOf(contactRequestParams.get('limit'));
        String leadSource = contactRequestParams.get('leadsource');
        // Querying contacts
        List<Contact> contactList = [SELECT Id, Name, LeadSource FROM Contact WHERE LeadSource =:leadSource LIMIT :contactLimit];
        // Returning the contacts in the response
        return contactList;
    }

}