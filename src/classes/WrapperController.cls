public class WrapperController {

    public WrapperController() {

    }

     
   Public List<WrapAccount> WrapperList{get;set;}
   //public WrapAccount waccount{get;set;}
    public List<Account> listOfAccounts{get;set;}
    public WrapperController(ApexPages.StandardController controller) {
      
      listOfAccounts=[select id,Name,Phone,AccountNumber from Account limit 10];
    }
    public pagereference moveRecords(){
    WrapperList=new List<WrapAccount>();
    for(Account acc1: listOfAccounts)
      {
              WrapAccount waccount=new WrapAccount();
              waccount.wacc=acc1;
              WrapperList.add(waccount); 
      }
      return null;
    }
  public class WrapAccount{
   
   public boolean selected{get;set;}
   public Account wacc{get;set;}
   
   /*public WrapAccount(Account c) {
   wacc = c;
   selected = false;
   } */
 }

}