global class BatchChangingOfOwner implements Database.Batchable<sObject>{
String query;

global Database.querylocator start(Database.BatchableContext BC){

return Database.getQueryLocator(query);}
global void execute(Database.BatchableContext BC,List<Student__c> scope){

//return null;
}
global void finish(Database.BatchableContext BC){

//return null;
}




}