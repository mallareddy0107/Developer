public with sharing class CountOfRecordsExtension {
   
   public string buttonVal{get;set;}
   List<Account> QueryList = new List<Account>();

    public CountOfRecordsExtension(ApexPages.StandardController controller) {
    
       QueryList = [select id from Account];

    }
     public pagereference countOfRecords(){
     
     buttonVal = 'count - '+QueryList .size();
     return null;
     }

}