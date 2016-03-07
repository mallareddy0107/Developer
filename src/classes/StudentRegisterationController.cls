public class StudentRegisterationController {
public  Lead lead{get;set;}
public List<SelectOption> Items{get;set;}
public string responseValue{get;set;}
public string CurrencyValue{get;set;}
public StudentRegisterationController()
{
  lead=new Lead();
}
//Lead lead=new Lead();
public pagereference save(){
//lead=new Lead();
lead.Company='IBM';
lead.Status='Open';
insert lead;
return null;
}
public List<SelectOption> getCurrency() {
            List<SelectOption> options = new List<SelectOption>();
            options.add(new SelectOption('Testing','--Select--'));
            options.add(new SelectOption('USD','Dollars'));
            options.add(new SelectOption('INR','Rupees'));
            options.add(new SelectOption('EUR','Euros'));
            options.add(new SelectOption('GBP','Pounds'));
            return options;
        }
public void getCurrencyFromWebservice()
{
  wwwWebservicexNet.CurrencyConvertorSoap soapService=new wwwWebservicexNet.CurrencyConvertorSoap();
  
  responseValue=soapService.ConversionRate('INR',CurrencyValue)*15000+' '+CurrencyValue;

}
}