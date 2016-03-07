trigger WebsiteFieldUpdation on Account (before insert,before update,after insert,after update) {

set<id> accIds=new Set<Id>();
List<Contact> listOfContacts=new List<Contact>();
List<Contact> listOfContactsToUpdate=new List<Contact>();

for(Account acc:Trigger.new)
{
  accIds.add(acc.id);
}
for(Account account:[select id,Name,Website,(select id,Name,Website__c from Contacts) from Account where id=:accIds]){
listOfContacts=account.Contacts;
  for(Contact con:listOfContacts)
  {
   con.Website__c=account.Website;
   listOfContactsToUpdate.add(con);
  }
  update listOfContactsToUpdate;
 }
}
/*
public void setCRClientServiceGroup(List<Opportunity> opps){
        Map<ID, Account> accMap = queryAccount(opps);
        for(Opportunity opp : opps){
            Account acc = accMap.get(opp.AccountId);
            System.debug('PPPPOpportunity : ' + opp + ' -- ' + acc);
            if(opp.CRClientServiceGroup__c != acc.CSG__c){
                opp.CRClientServiceGroup__c = acc.CSG__c;
            }
        }
    }
*/