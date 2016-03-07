trigger countryChange on Account (after insert,after update) {

   List<Contact> listOfContacts=new List<Contact>(); 
   Account acc=[select id,Name,Country_Name__c,(select id,Name,Country__c from Contacts) from Account where id=:Trigger.new[0].id];
   system.debug('list of  accounts are'+acc);
   listOfContacts=acc.Contacts;
   system.debug('list of contacts are'+listOfContacts);
   for(Contact con:listOfContacts)
   {
      system.debug('hi iam from for'+con);
      con.Country__c=acc.Country_Name__c;
      update con;
   }
   
}