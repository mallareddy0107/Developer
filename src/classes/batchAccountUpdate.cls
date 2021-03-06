global class batchAccountUpdate implements Database.Batchable<sObject>,Schedulable
{
    global Database.QueryLocator start(Database.BatchableContext BC)
    {
        String query = 'SELECT Id,Name FROM Account';
        return Database.getQueryLocator(query);
        
    }
    global void execute(SchedulableContext sc){
    Database.executebatch(this); 
    }
    global void execute(Database.BatchableContext BC, List<Account> scope)
    {
         for(Account a : scope)
         {
             a.Name = a.Name.remove('Updated');            
         }
         update scope;
    }   
    global void finish(Database.BatchableContext BC)
    {
    }
}