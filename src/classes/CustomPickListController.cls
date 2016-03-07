public class CustomPickListController {

    // public boolean newvalue { get; set; }

    public String newpicklistvalue { get; set; }

    public String city { get; set; }
    /*List<Dynamicpicklist__c> dynamicPickList=new List<Dynamicpicklist__c>();
    List<selectoption> options=new List<selectoption>(); */
    public List<selectoption> getCities(){
        List<Dynamicpicklist__c> dynamicPickList=new List<Dynamicpicklist__c>();
        List<selectoption> options=new List<selectoption>();    
        dynamicPickList = [select id,PicklistValue__c from Dynamicpicklist__c];
        system.debug('list of dynamic pick list is:'+dynamicPickList);
        //options.clear();
        options.add(new SelectOption('--None--','--None--'));
         for(integer i=1;i<dynamicPickList.size();i++)
          {
           options.add(new selectoption(dynamicPickList[i].PicklistValue__c,dynamicPickList[i].PicklistValue__c)); 
           system.debug('value is'+dynamicPickList[i].PicklistValue__c);          
          } 
         return options;
       } 
    public void saverec()
    {
     //if(newpicklistvalue!=null)
     //{
      DynamicPicklist__c newrec = new DynamicPicklist__c(PicklistValue__c=newpicklistvalue);
      insert newrec; 
     //}
      newpicklistvalue=NULL;  
   }
   }