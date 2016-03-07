public with sharing class StudentAndOffersClass {

public Id studentId;
public Student__c listOfStudentsAndOffers{get;set;}
public Student__c newListOfStudentsAndOffers{get;set;}
public List<Offer__c> offers{get;set;}
public  List<OfferWrapper> wrapperList1=new List<OfferWrapper>();
public List<Offer__c> newOffers{get;set;}
public List<Offer__c> deleteOfferList=new List<Offer__c>();
public boolean isRequired{get;set;}
public boolean isNewOffer{get;set;}
public Offer__c newOffer{get;set;}
public boolean offerDisplay{get;set;}
public boolean offerSave{get;set;}
public boolean offerDetail{get;set;}
//public boolean 

public StudentAndOffersClass(Apexpages.standardcontroller controller){

studentId=ApexPages.currentPage().getParameters().get('Id');
listOfStudentsAndOffers=[select Name,Batch__c,Email__c,Total_No_Of_Offers__c,Payment_Status__c,(select Name,Company_Name__c,Employee_Type__c,Current_Packege__c from Offers__r) from Student__c where id=:studentId]; 
offers=listOfStudentsAndOffers.Offers__r;
getWrapperList();
}
public pagereference save()
{
 upsert listOfStudentsAndOffers;
 return null;
}
public pagereference cancel()
{
 return null;
}
public pagereference getWrapperList()
{
  newListOfStudentsAndOffers=[select Name,Batch__c,Email__c,Total_No_Of_Offers__c,Payment_Status__c,(select Name,Company_Name__c,Employee_Type__c,Current_Packege__c from Offers__r) from Student__c where id=:studentId];
  newOffers=newListOfStudentsAndOffers.Offers__r;
  for(Offer__c offer:newOffers)
  {
    OfferWrapper wrapperoffer=new OfferWrapper();
    wrapperoffer.woffer=offer;
    wrapperList1.add(wrapperoffer);
    system.debug('wrapperlist values are:'+wrapperList1);
  }
  return null;
}
public List<OfferWrapper> getwrapperList1()
{
 return wrapperList1;
}
public pagereference deleteOffer()
{
 for(OfferWrapper wrp:wrapperList1)
 {
   if(wrp.selected==true)
   {
     deleteOfferList.add(wrp.woffer);
     system.debug('list of records for delete:'+deleteOfferList);
   }
   if(wrapperList1.size()<=0)
   {
   system.debug('hi reddy');
   isRequired=false;
   }
 }
 
 delete deleteOfferList;
 deleteOfferList.clear();
 newListOfStudentsAndOffers.clear();
 newOffers.clear();
 wrapperList1.clear();
 getWrapperList();
 return null;
}
public pagereference addNewOffer()
{
 isNewOffer=true;
 offerDetail = true;
 newOffer=new Offer__c();
 offerDisplay=false;
 offerSave=true;
 return null;
 }
public pagereference saveNewOffer()
 {
  newOffer.Student__c=studentId;
  insert newOffer;
  offerDisplay=false;
  offerSave=false;
  return null;
 }
public class OfferWrapper
 {
    public boolean selected{get;set;}
    public Offer__c woffer{get;set;}
 }

}