public class ReferenceCode
{
  
  //http://sfdc2u.blogspot.in/search/label/Triggers
  
  
/*  //Trigger.new: Contains all new Data
//Trigger.Old: Contains all old Data (before change)
//Trigger.newMap: Map contains new Data (Key: Id)
//Trigger.oldMap: Map contains old Data (Key: Id)
for(Opportunity opp:Trigger.New){
    if(opp.Stage != Trigger.oldMap.get(opp.Id).Stage){
        //Your logic
    }
}
//Same way you can use Trigger.newMap



trigger candidateTrigger on Candidate__c (before delete)&nbsp;{
    for (Job_Application__c jobApp : [SELECT Candidate__c
                                      FROM Job_Application__c
                                      WHERE Candidate__c
                                      IN :Trigger.oldMap.keySet()])&nbsp;{
        Trigger.oldMap.get(jobApp.Candidate__c).addError(
                   'Cannot delete candidate with a job application');
    }
}
  
  
  
  trigger TestTrigger on Opportunity (before update) {
    Opportunity oldOpportunity = Trigger.oldMap.get(opp.ID);
    for(Opportunity opp : Trigger.new){
       ...
       oppOwnerId = [SELECT Id FROM User WHERE Id=:oldOpportunity.OwnerId limit 1];
       ...
    }
}
  
  
  
  
  trigger TestTrigger on Opportunity (before update) {
    for(Opportunity opp : Trigger.new){
       Opportunity oldOpportunity = Trigger.oldMap.get(opp.ID);
       oppOwnerId = oldOpportunity.OwnerId;
       ...
    }
}




Set<Id> ownerIds = new Set<Id>();
for( Opportunity opp : Trigger.old ) {
    ownerIds.add( opp.OwnerId );
}



trigger emailCheck on Employee__c (before update) 
{
    Map<Id,Employee__c> o = new Map<Id,Employee__c>();
    o = trigger.oldMap;
    for(Employee__c n : trigger.new)
    {
        Employee__c old = new Employee__c();
        old = o.get(n.Id);
        if(n.Email__c != old.Email__c)
        {
            n.Email__c.addError('Email cannot be changed');
        }
    }
}



trigger Compare_OldandNewvalues on Account (before update) {

   for (Account acc: Trigger.new) {
        Account oldAccount = Trigger.oldMap.get(acc.ID);
        if(acc.AccountNumber != oldAccount.AccountNumber) {
           System.debug('--*Account Number is changed*--');
           System.debug('**Old Account Number :'+oldAccount.AccountNumber);
           System.debug('**New Account Number :'+acc.AccountNumber);
           acc.Type = 'Prospect';
        }
        else{
            System.debug('--**Account Number has not been Updated**--');
            acc.Type = 'Other';  
        }
    }
    
    
    
    
    
    
    
    trigger userNamEmaiil on User (before insert, before update) 
{
    if(trigger.isInsert)
    {
        for(User u : trigger.new)
        {
            if(u.name != u.Email)
            {
                u.addError('Username and Email should be same');
            }           
        }
    }
    else if(trigger.isUpdate)
    {    
        for(User o : trigger.old)
        {
            for(User n : trigger.new)
            {
                if(o.email != n.Email)
                {
                    n.addError('Email address cannot be changed');
                }   
            } 
        } 
    }
}






Example:
     Suppose there is a scenario where in one trigger perform update operation, which results in invocation of second trigger and the update operation in second trigger acts as triggering criteria for trigger one.

Solution:

Class:

public class Utility
{
    public static boolean isFutureUpdate;
}


Trigger:

trigger updateSomething on Account (after insert, after update) 
{
 
    /*  This trigger performs its logic when the call is not from @future 
    if(Utility.isFutureUpdate != true)
    {
 
        Set<Id> idsToProcess = new Se<Id>();
 
        for(Account acct : trigger.new)
        {
            if(acct.NumberOfEmployees > 500)
            {
                idsToProcess.add(acct.Id);
            }
        }
 
        /* Sending Ids to @future method for processing 
        futureMethods.processLargeAccounts(idsToProcess);
 
    }
}

Class:

public class FutureMethods
{
 
    @future
    public static void processLargeAccounts(Set<Id> acctIDs)
    {
 
        List<Account> acctsToUpdate = new List<Account>();
 
        /* isFutureUpdate is set to true to avoid recursion /
        Utility.isFutureUpdate = true;
        
        update acctsToUpdate;
    }
}
    
    Custom controller pagination
    http://www.29lessons.com/2014/06/how-to-use-custom-controller-pagination.html
    
}






public static String getCodeByDescription(String categorys, String description) {
        String rtnString = UTIL_Constants.EMPTY;
        if (!String.isBlank(categorys) && !String.isBlank(description)) {

            List<String> descriptionList = description.split(UTIL_Constants.SEMICOLON);
            
            if (descriptionList.size() > 1) {
                  for (Integer i = 0; i < descriptionList.size(); i++) {
                    String strTemp = getCodeByDescription(categorys, descriptionList.get(i));
                    if (!String.isBlank(strTemp)) {
                      rtnString = rtnString + strTemp + UTIL_Constants.SEMICOLON;
                    }
                  }
                  if (rtnString.endsWith(UTIL_Constants.SEMICOLON)) {
                    rtnString = rtnString.substring(0, rtnString.length() - 1);
                  }
            } else {
                rtnString = codeDescriptionMap.get(categorys + description);
            }
        }
        system.debug('$$$$$rtnString--'+rtnString);
        return rtnString;
    }
    
    
    Batch class
    -------------
    
    global class CloseCaseBatch implements Database.Batchable<sObject>, Schedulable{
  private Boolean allClosedTickets;
  private String query = 'Select Id, Status from Case WHERE Status = \'Open\' OR ' +
         'Status = \'Escalated\' OR' +
         'Status = \'Breached\''; // Getting case records whose status is open (or) escalated (or) Breached

  // method implemented from Schedulable interface
  global void execute(SchedulableContext sc){
    Database.executebatch(this); 
    }
  //Start Method which retrieves the records of case
  global Database.QueryLocator start(Database.BatchableContext BC)  {
      return Database.getQueryLocator(query);
         System.debug('checkcase---' + query); //debugging
      }
  global void execute(Database.BatchableContext BC, List<sObject> scope) {
    List<Case> casestatusOEB = (List<Case>)scope; //List of cases
    System.debug('checkcase---' +scope); //debugging
    Set<ID> caseIDs = new Set<ID>(); // Setting Case id
    Map<ID,List<Ticket__c>> CaseID_TicketList = new Map<ID,List<Ticket__c>>(); //mapping case id to ticket__C
      for(case getCaserecords : casestatusOEB) {
             caseID.put(getCaserecords.id);  // Setting the case ID 
      }

  }
  List<Ticket__c> ticket = [Select ID, LastModifiedDate , GLOBAL_Ticket_Status__c,
                             GLOBAL_Goal__c from Ticket__c 
                             where GLOBAL_Goal__c in :caseIDs]; // Listing tickets whose id = Caseid
      for(Ticket__c tkt : ticket) {
      System.debug('new list of ticket' +ticket); 
          if (tkt.GLOBAL_Ticket_Status__c == 'closed')
              caseIDs.add(ticket.GLOBAL_Goal__c);    
      } 

  List<Ticket__c> tkt = new List<Ticket__c>();
      if(CaseID_TicketList.containsKey(ticket.GLOBAL_Goal__c)){
          tkt = CaseID_TicketList.get(ticket.GLOBAL_Goal__c);
      } 
          else {
          tkt.add(ticket);                }
          CaseID_TicketList.put(ticket.GLOBAL_Goal__c,tkList);
          // Map case & ticket
          }


  allClosedTickets;  // validation to check ticket status. if status != closed come out of the loop 
      for (Ticket__c ticket: scase) { // Ticket loop
         System.debug('checkcase---' +ticket); //debugging
      // save LastModified date of the highest date
          if (ticket.GLOBAL_Ticket_Status__c != 'closed') {
             allClosedTickets = false;
          //caseIDs.add(ticket.GLOBAL_Goal__c);   // case ID of current Records.
          }

    }

          if (allClosedTickets = true) { // all closed so Case can be closed
          // if lastModifiedDate greater than 7 days then
          // add CaseId to casesToUpdate


  List<Case> casesToUpdate = new List<Case>();  // getting total tickets of that case and closedticket and if(closedTickets == totalTickets) and all of them are closed. then update the case status to closed after 7 days of a tickets status = closed based on lastmodifieddate >7

      for (Id caseID : caseIDs) {

          Integer totalTickets = CaseID_TicketList.get(caseID).size();
          Integer closedTickets = 0;
              for(Ticket__c ticket : CaseID_TicketList.get(caseID)){ 
                  if(ticket.GLOBAL_Ticket_Status__c == 'Closed'){
                  closedTickets++;
                  }
              }
                  if(closedTickets == totalTickets) {
                  casesToUpdate.add(new Case(Id = caseID, Status= 'Closed'));
                  }
              }

                  if(!casesToUpdate.isEmpty()) {
                  update casesToUpdate; //updating case status after 7 days"" 7 days logic is missing
                  }
      }

  global void finish(Database.BatchableContext BC)
    {

    }

  }
  
  
  
  
  
  
  
  
  global class batchTaskUpdate implements Database.Batchable<sObject>
{
    global Database.QueryLocator start(Database.BatchableContext BC)
    {
        //query on Task
        String query = 'SELECT ActivityDate,Status FROM Task';
        return Database.getQueryLocator(query);
    }
   
    global void execute(Database.BatchableContext BC, List<Task> scope)
    {
         for(Task a : scope)
         {   
             //Updating Task status to completed
             a.Status = 'Completed';            
         }
         update scope;
    }   
    global void finish(Database.BatchableContext BC)
    {
    }
}










global class expireBackgroundChecks implements Database.Batchable<sObject>
{
    global Database.QueryLocator start(Database.BatchableContext BC)
    {
        Date d = Date.today();
        String soql = 'SELECT id, BGC_Expiration_Date__c, BGC_Status__c FROM Contact WHERE BGC_Expiration_Date__c <: d';
        return Database.getQueryLocator(soql);
    }
   
    global void execute(Database.BatchableContext BC, List<Contact> scope)
    {
         for(Contact c : scope)
         {
             c.BGC_Status__c = 'Expired';
             update c;
         }
    }   
    global void finish(Database.BatchableContext BC)
    {
    AsyncApexJob a = [Select Id, Status, NumberOfErrors, JobItemsProcessed,
            TotalJobItems, CreatedBy.Email
            from AsyncApexJob where Id =
            :BC.getJobId()];
 
        // Create and send an email with the results of the batch.
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
 
        mail.setToAddresses(new String[] {a.CreatedBy.Email});
        mail.setReplyTo('rachelbr@angieslist.com');
        mail.setSenderDisplayName('Senor Cardgage');
        mail.setSubject('Background Check Expiration has been' + a.Status);
        mail.setPlainTextBody('Hi there, Belindas.  The batch apex job processed ' + a.TotalJobItems +
        ' batches with ' + a.NumberofErrors + ' failures.  ');
 
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    
    }
}



Batch class:

global class UpdateAccountArea implements Database.Batchable<sObject> {
//map of userid - user
Map<Id, User> ownerMap = new Map<Id, User>();
global UpdateAccountArea(Map<Id, User> owners) {
ownerMap = owners;
}
global Database.QueryLocator start(Database.BatchableContext BC) {
return DataBase.getQueryLocator([SELECT Id,Area__c, OwnerId FROM account WHERE OwnerId IN : ownerMap.keySet()]);
}
global void execute(Database.BatchableContext BC,List<Account> scopeAcc) {
 
for (Integer i=0;i<scopeAcc.size();i++){
scopeAcc.get(i).Area__c=ownerMap.get(scopeAcc.get(i).OwnerId).Team__c;
}
update scopeAcc;
}
global void finish(Database.BatchableContext BC) {
//Send an email to the User after your batch completes
Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
String[] toAddresses = new String[] {'info@theblogreaders.com'};
mail.setToAddresses(toAddresses);
mail.setSubject('Apex Batch Job is done');
mail.setPlainTextBody('The batch Apex Job Processed Successfully');
Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
}
}





Trigger:

trigger UpdateAreaInfoUser on User (after update)  {
Map<id, User> owners = new Map<id, User>();
for (Integer i=0;i<Trigger.new.size();i++) {
if (Trigger.new[i].Team__c!=Trigger.old[i].Team__c) {
owners.put(Trigger.new[i].Id, Trigger.new[i]);
}
}
// You can execute batch apex using trigger using below codes
if (owners.size() > 0) {
Database.executeBatch(new UpdateAccountArea(owners));
}
}


comparing two fields:
---------------------

set<string>upgrades = new set<string>();
set<string>SNUpgrades = new set<string>();

//populate upgrades/SNUpgrades from wherever...
upgrades.add('UG-001');
upgrades.add('UG-002');
upgrades.add('UG-003');
SNUPgrades.add('UG-004');
for(string s : upgrades){
if(!SNUpgrades.contains(s){
SNUpgrades.put(s);
//can do other custom code here...
}
}
system.debug(Upgrades);
system.debug(SNUpgrades);



Comparing Two Maps:
--------------------
integer myCount = 0;
list<customa__c> myCustomA = new list<customa__c>();
myCustomA = [Select ID, myA__c, myAText__c From CustomA__c Where myA__c = false];
 
list<customb__c> myCustomB = new list<customb__c>();
myCustomB = [Select ID, myB__c, myBText__c From CustomB__c Where myB__c = false];
 
//Now do the two loops
for (CustomA__c a : myCustomA){
   for (CustomB__c b: myCustomB){
       if (a.myAText__c == b.myBText__c){
          myCount += 1;
       }
   }
}


integer myCount = 0;
list<customa__c> myCustomA = new list<customa__c>();
myCustomA = [Select ID, myA__c, myAText__c From CustomA__c Where myA__c = false];
 
list<customb__c> myCustomB = new list<customb__c>();
myCustomB = [Select ID, myB__c, myBText__c From CustomB__c Where myB__c = false];
 
//Now create a map for B that we can do look-ups on.
map<string, customb__c=""> myBMap = new map<id, customb__c="">();
for (CustomB__c b : myCustomB){
   myBMap.put(b.myBText__c, b);
}
 
//Now do our matching loop, but use the map instead
for (CustomA__c a: myCustomA){
  if (myBMap.containsKey(a.myAText__c){
      myCount += 1;
  }
}



Map<String, Obj__c> objMap1 = new Map<String, Obj__c>();
Map<String, Obj__c> objMap2 = new Map<String, Obj__c>();

// List 1
for(Obj__c o : list1)
{
    objMap1.put(o.UniqueName__c, o);
}

// List 2
for(Obj__c o : list2)
{
    objMap2.put(o.UniqueName__c, o);
}

// Now you can easily check if that value is in your map by doing.
objMap1.containsKey('WhateverYouWantToCompare');
// or
objMap2.containsKey(newObj.UniqueName__c);

// ... do your logic

http://www.sundoginteractive.com/sunblog/posts/apex-why-maps-are-your-friend
http://www.sfdc99.com/2014/01/25/use-maps-navigate-across-lists/

  */
  
  
 }