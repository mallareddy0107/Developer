public with sharing class OfferAjaxDemoClass {

    /*public OfferAjaxDemoClass(ApexPages.StandardController controller) {

    }*/

public Offer__c offer{get;set;}
public boolean isRequired{get;set;}//{isRequired=true;}

 public OfferAjaxDemoClass(ApexPages.StandardController controller)
 {
  offer=new Offer__c();//[select id,Name,Agency_Name_if_Contract__c,Agency_Website__c,Company_Name__c,Current_Packege__c,Employee_Type__c,Student__c from Offer__c]; //where id=:apexpages.currentpage().getParameters().get('id')]; 
  //isRequired=true;
 }
 public pagereference Save()
 {
  upsert offer;
  return null;
  }
  public pagereference cancel()
  {
   return null;
  }
  public pagereference checkrequired(){
  system.debug('hi malla');
  if(offer.Employee_Type__c=='Permanent'){
  isRequired=false;
  }
  else{
  isrequired=true;
  }
  system.debug('checkrequired:');
  return null;
  }
  }