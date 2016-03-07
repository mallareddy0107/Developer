public class CurrencyConversionRate{
   
   /* List<MyCurrencies__c> cur=new List<MyCurrencies__c>();
    List<MyCurrencies__c> curId=new List<MyCurrencies__c>();
    List<BankAccount__c> bankid=new List<BankAccount__c>();
    //curId=[select id from MyCurrencies__c];
   
    //cur=[select Conversion_Rate__c,ISOCode__c,(select Balance__c,US_Dollar__c from BankAccounts__r) from MyCurrencies__c where id=:curId];
    public integer getUsConversion()
     {
        curId=[select id from MyCurrencies__c]; 
        cur=[select Conversion_Rate__c,ISOCode__c,(select Balance__c,US_Dollar__c from BankAccounts__r) from MyCurrencies__c where id=:curId];
        //BankAccount__c bid1=cur.BankAccounts__r;
        for(BankAccount__c bid:cur)
        {
        bankid=bid.BankAccounts__r;       
        } 
        return null;
     }   */
   }