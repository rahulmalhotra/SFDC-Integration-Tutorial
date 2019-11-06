// Setting up the Request URL
@RestResource(urlMapping='/ContactAPI1/*')
global with sharing class ContactResource1 {

    // Creating a response wrapper class
    global class ResponseWrapper {
        String success;
        String message;
    }

    // DELETE Method
    @HTTPDelete
    global static List<ResponseWrapper> deleteContacts() {
        // Initializing the response wrapper list
        List<ResponseWrapper> responseWrapperList = new List<ResponseWrapper>();
        // Initializing the request parameter with the incoming request
        RestRequest contactRequest = RestContext.request;
        // Getting the request URI
        String contactRequestURI = contactRequest.requestURI;
        // Getting the contact ids from the request URI
        String[] contactIds = (contactRequestURI.substring(contactRequestURI.lastIndexOf('/') + 1)).split(',');
        // Initializing contacts list to delete
        List<Contact> contactsToDelete = new List<Contact>();
        // Adding contacts in the contacts list
        for(String contactId : contactIds) {
            Contact contact = new Contact(Id=contactId);
            contactsToDelete.add(contact);
        }
        // Deleting contacts with partial success enabled
        Database.DeleteResult[] deleteResults = Database.delete(contactsToDelete, false);
        // Checking the result of delete operation for each contact
        for(Database.DeleteResult deleteResult : deleteResults) {
            // Initializing the response wrapper
            ResponseWrapper wrapper = new ResponseWrapper();
            if (deleteResult.isSuccess()) {
                // Delete successful, setting up the appropriate message in response wrapper
                wrapper.success = '1';
                wrapper.message = 'Successfully deleted contact with Id: ' + deleteResult.getId();
            }
            else {
                // Delete failed, getting errors and setting up the error message in response wrapper
                wrapper.success = '0';
                for(Database.Error error : deleteResult.getErrors()) {
                    wrapper.message = 'The following error has occurred for contact with Id: ' + deleteResult.getId() + '. ';
                    wrapper.message += error.getStatusCode() + ': ' + error.getMessage() + '. ';
                    wrapper.message += 'Contact fields that affected this error: ' + error.getFields();
                }
            }
            // Adding response wrapper instance to the response wrapper list
            responseWrapperList.add(wrapper);
        }
        // Returning the response wrapper list in the response
        return responseWrapperList;
    }
}