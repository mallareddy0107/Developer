trigger competetiorTrigger on Competitor1__c (before insert,before update) {
List<opportunity> listOfOpportunity=new List<Opportunity>();
List<Competitor1__c> listOfComps=new List<Competitor1__c>();
Set<id> oppId=new set<Id>();
set<Id> compId=new set<Id>();

for(Competitor1__c compete:trigger.new)
 {
  listOfComps=[select id,Name,Competitor_Master_data__c,Opportunity_Name__c from Competitor1__c where id=:compete.id];
  system.debug('@listOfComps'+compete.Test_competitor__c+'-------'+compete.Opportunity_Name__c);
  compete.Test_competitor__c = compete.Opportunity_Name__r.Account.Name;
  system.debug('@listOfComps'+compete.Test_competitor__c+'-------'+compete.Opportunity_Name__r.Account.Name);
  system.debug('compe is'+listOfComps);
 }
for(Competitor1__c compete1:listOfComps)
 { 
  Opportunity opp=[select id,(select id,Opportunity_Name__c,Name,Competitor_Master_data__c from Competitors1__r) from Opportunity where id =:compete1.Opportunity_Name__c];
  system.debug('opportunity is'+opp);
 }
 }