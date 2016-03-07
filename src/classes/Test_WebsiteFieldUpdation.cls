@isTest

private class Test_WebsiteFieldUpdation{
   static testMethod void verifyFieldUpdation(){
   
   Account acc1=new Account(Name='Malla',Website='google.com');
   insert acc1;
   Contact con1=new Contact(AccountId=acc1.id,lastname='reddy',Website__c=acc1.Website);
   insert con1;
   acc1.website='accenture.com';
   update acc1;
   
   }
}