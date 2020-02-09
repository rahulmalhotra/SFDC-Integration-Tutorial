/*
*	Author:- Rahul Malhotra
*	Description:- This class is used as a SOAP Webservice
*	Created:- 09/02/2020
*	Last Updated:- 09/02/2020
*	Code Origin:- SFDCStop (https://www.sfdcstop.com/)
*	Tutorial:- Salesforce Integration Tutorial Series
*/
global with sharing class ContactResource {
    webservice static List<Contact> getContactIdAndNames(Integer contactLimit) {
        // Querying contacts
        List<Contact> contactList = [SELECT Id, Name, Birthdate, Phone FROM Contact LIMIT :contactLimit];
        // Returning the contacts in the response
        return contactList;
    }
}