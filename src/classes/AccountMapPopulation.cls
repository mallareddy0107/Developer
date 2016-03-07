public class AccountMapPopulation{

// Creating map with account id and account object

map <Id,Account> accountIdMap =new map<Id,Account>();

public void methodName(){

// creating the accounts

account acc1 = new account (name ='account1' , industry = ' Banking');

account acc2 =new account(name ='account2' , industry = 'Agriculture');

account acc3 = new account(name='account3' , industry='Banking');

// populating the map with account id and account object

accountIdMap .put(acc1.id,acc1);

accountIdMap .put(acc2.id,acc2);

accountIdMap .put(acc3.id,acc3);

system.debug('The map values are:'+accountIdMap);

}
   

}