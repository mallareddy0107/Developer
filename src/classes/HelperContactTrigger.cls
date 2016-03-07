/**
* Description : Trigger to send email to the contact if accountId is null .
*
* Created By : Abhi Tripathi
*
* Created Date : 07/16/2013
*
* Revision Logs : V1.0
*
**/
public with sharing class HelperContactTrigger { 

//static method
public static void sendEmail(Map<Id,Account> newMap,Map<Id,Account> oldMap) { 

//query on template object
//EmailTemplate et=[Select id from EmailTemplate where name=:'Sales: New Customer Email'];
User current_user=[SELECT Email FROM User WHERE Id= :UserInfo.getUserId()] ;
String[] toAddresses = new String[] {'mallareddy.illuri@accenture.com'};
system.debug('current user id'+toAddresses);
for( Id id1 : newMap.keySet() )
{
  if( oldMap.get(id1).Active__c != newMap.get( id1 ).Active__c )
  {
        system.debug('********'+oldMap.get(id1).Active__c+'******'+newMap.get( id1 ).Active__c);
        //initiallize messaging method
        Messaging.SingleEmailMessage singleMail = new Messaging.SingleEmailMessage();
        //String[] toAddresses = new String[] {'mallareddy0107@gmail.com'};
        singleMail.setToAddresses(toAddresses);
        singleMail.setHtmlBody('Hello  malla');
        
        //set object Id
        //singleMail.setTargetObjectId(con.Id);
        
        
        
        //flag to false to stop inserting activity history
        singleMail.setSaveAsActivity(false); 
        //send mail 
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { singleMail });
        newMap.get(id1).addError('You Cant');
        //newMap.get( id1 ).Active__c = oldMap.get(id1).Active__c;
       
        system.debug('********'+oldMap.get(id1).Active__c+'******'+newMap.get( id1 ).Active__c);
        
       
  } 
  //newMap.get(id1).addError('You Cant');
}



} 
}