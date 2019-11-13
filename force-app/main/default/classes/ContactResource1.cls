// Setting up the Request URL
@RestResource(urlMapping='/ContactAPI1/*')
global with sharing class ContactResource1 {

    // Creating a response wrapper class
    global class ResponseWrapper {
        String success;
        String message;
    }

    // PATCH Method
    @HTTPPatch
    global static List<ResponseWrapper> updateContacts() {
        // Initializing the response wrapper list
        List<ResponseWrapper> responseWrapperList = new List<ResponseWrapper>();
        // Initializing the request parameter with the incoming request
        RestRequest contactRequest = RestContext.request;
        // Getting the request body from the request
        String requestBody = contactRequest.requestBody.toString();
        // Deserializing the JSON request body and initializing the list of contacts to update
        List<Contact> contactsToUpdate = (List<Contact>) JSON.deserialize(requestBody, List<Contact>.class);
        // Updating contacts with partial success enabled
        Database.SaveResult[] updateResults = Database.update(contactsToUpdate, false);
        // Checking the result of update operation for each contact
        for(Database.SaveResult updateResult : updateResults) {
           // Initializing the response wrapper
            ResponseWrapper wrapper = new ResponseWrapper();
            // Initializing the response wrapper
            if (updateResult.isSuccess()) {
                // Update successful, setting up the appropriate message in response wrapper
                wrapper.success = '1';
                wrapper.message = 'Successfully updated contact with Id: ' + updateResult.getId();
            }
            else {
                // Update failed, getting errors and setting up the error message in response wrapper
                wrapper.success = '0';
                for(Database.Error error : updateResult.getErrors()) {
                    wrapper.message = 'The following error has occurred for contact with Id: ' + updateResult.getId() + '. ';
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