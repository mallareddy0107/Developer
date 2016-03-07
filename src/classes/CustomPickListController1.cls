public class CustomPickListController1 {

    public String newpicklistvalue { get; set; }

    public String city { get; set; }
    List<Dynamicpicklist__c> dynamicPickList=new List<Dynamicpicklist__c>();
    public List<selectoption> getCities(){
        dynamicPickList = [select id,PicklistValue__c from Dynamicpicklist__c];
        List<selectoption> options=new List<selectoption>();        
        system.debug('list of dynamic pick list is:'+dynamicPickList);
        //options.clear();
         options.add(new SelectOption('--None--','--None--'));
         
         for(integer i=0;i<dynamicPickList.size();i++)
          {
           system.debug('count of dynamicpicklist is:  '+dynamicPickList.size());          
           options.add(new selectoption(dynamicPickList[i].PicklistValue__c,dynamicPickList[i].PicklistValue__c)); 
           system.debug('value is'+dynamicPickList[i].PicklistValue__c);          
          } 
           system.debug('hi malla');
           system.debug('values in options are:'+options);
           return options;
       } 
    public pagereference saverec()
    {
     //if(newpicklistvalue!=null)
     //{
      if(newpicklistvalue==NULL)
      {
       system.debug('Hi Null');      
       DynamicPicklist__c newrec = new DynamicPicklist__c(PicklistValue__c='Upparapalem');
       insert newrec;       
       return null;
      } 
      else
      {  
        system.debug('Hi not Null');
        DynamicPicklist__c newrec = new DynamicPicklist__c(PicklistValue__c=newpicklistvalue);
        insert newrec;
        return null;
      }
      //newpicklistvalue=NULL;  
     }
   }