trigger validateAccount on Account (before update,after update) {

set<id> accIds=new Set<Id>();
List<Opportunity> listOfOpps=new List<Opportunity>();
List<Account> listOfAccs = new List<Account>();
for(Account acc:trigger.new)
{
 accIds.add(acc.id);
}
listOfOpps = [select id,Name,StageName,AccountId from Opportunity where AccountId IN : accIds];

for(Account acc1:Trigger.New){
  if(listOfOpps.size()>0)
  {
    if(acc1.Rating == 'Cold')
    {
      acc1.Rating.addError('you cant');
    }
  } 
 }
}