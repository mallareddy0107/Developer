@RestResource(urlMapping='/FieldCase/*')
global with sharing class RESTCaseController {

@HttpPost   
  global static String createNewCase(String companyName, String caseType) {
  
    //https://developer.salesforce.com/page/Creating_REST_APIs_using_Apex_REST
     System.debug('COMPANY: '+companyName);
     System.debug('CASE TYPE: '+caseType);
     
     List<Account> company = [Select ID, Name, Email__c, BillingState from Account where Name = :companyName];
     List<Support_Member__c> support;
     
     if(company.size() > 0) {
        support = [SELECT ID, User__c, Name, User__r.Email from Support_Member__c WHERE Support_State__c = :company[0].BillingState LIMIT 1];
     }
     List<Support_Documentation__c> doc = [SELECT ID from Support_Documentation__c WHERE Type__c = :caseType ORDER BY CreatedDate ASC LIMIT 1];
     
     if(company.size() == 0 || support.size() == 0 || doc.size() == 0) {
        return 'No support data exists for this problem';
     }
     
     Case c = new Case();
     c.OwnerId = support[0].User__c;
     c.AccountId = company[0].Id;
     c.Subject = caseType + ' for '+companyName;
     c.Status = 'Open';
     insert c;
     
     
          
     return 'Submitted case to '+support[0].Name+' for '+companyName+'.  Confirmation sent to '+company[0].Email__c; 
  } 
}