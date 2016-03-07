trigger WebsiteFieldUpdate on Contact (before insert,before update,after insert,after update) {


      Set<ID> accSet = new Set<ID>();
        for(Contact opp : Trigger.new){
              if(!accSet.contains(opp.AccountId))
                  accSet.add(opp.AccountId);
          }

   Map<ID, Account> accountMap = new Map<ID, Account>([SELECT ID, Name, Website FROM ACCOUNT WHERE ID IN :accSet]);
    
        for(Contact opp : Trigger.new){
            Account acc = accountMap.get(opp.AccountId);
            System.debug('PPPPOpportunity : ' + opp + ' -- ' + acc);
            if(opp.Website__c!= acc.Website){
                opp.Website__c = acc.Website;
            }
        }
       




}