/*ClassName: BuyerValues_Controller

History of changes: 
-------------------------------------------------------------------------
   Date                Developer                         Comments   
-------------------------------------------------------------------------
   14/11/2013          preeti.rathore@accenture.com     Created
   30/12/2014          shilpa.mn@accenture.com          Modified
   16/04/2015          y.a.wang@accenture.com           Modified
************************************************************************/
public class BuyerValues_Controller{

    ApexPages.StandardSetController setCon;
    List<OpportunityBuyerValue__c> BuyerValuesList;
    Id oppId = null;
  
   public static  BOOLEAN IS_CALL_FROM_SAVEAPRROVAL = false;

    public BuyerValues_Controller(ApexPages.StandardSetController controller) {
        oppId = ApexPages.currentPage().getParameters().get('Id');        
    } 
   
   public List<OpportunityBuyerValue__c> getBuyerValuesList(){                 
        ///****************************Added by Shilpa for Bug#378488 - Begin****************************///
        this.BuyerValuesList =  [select id, name, BuyerValueNm__c, ClientRankNbr__c from OpportunityBuyerValue__c 
                              where OpportunityId__c =: oppId ];
       ///****************************Added by Shilpa for Bug#378488 - End****************************//
        return this.BuyerValuesList;
    }  
    
    public pagereference  saveBuyerValues(){
        try{
          //****************************Added by y.a.wang for Bug#448364 - Begin****************************//
          this.BuyerValuesList = getChangedBuyerValues();
          //****************************Added by y.a.wang for Bug#448364 - End****************************//
            IS_CALL_FROM_SAVEAPRROVAL = true;
            update this.BuyerValuesList;
            IS_CALL_FROM_SAVEAPRROVAL = false;
            PageReference pageRef = new PageReference('/'+oppId);
            return pageRef;

        }catch(Exception e){            
            ApexPages.addMessages(e);
            IS_CALL_FROM_SAVEAPRROVAL = false;            
            return null;
        }
       
    }
    
    
    /**
     *  get all changed record on approver by stage edit all page
     *  @return updateBuyerValuesList
     */
    private List<OpportunityBuyerValue__c> getChangedBuyerValues(){
      Map<Id, OpportunityBuyerValue__c> oldBuyerValuesMap = new Map<Id, OpportunityBuyerValue__c>([select id, name, BuyerValueNm__c, ClientRankNbr__c from OpportunityBuyerValue__c where OpportunityId__c =: oppId ]);
      List<OpportunityBuyerValue__c> updateBuyerValuesList = new List<OpportunityBuyerValue__c>();
        OpportunityBuyerValue__c oldBuyerValue = null;
        for(OpportunityBuyerValue__c newBuyerValues : this.BuyerValuesList) {
          oldBuyerValue= oldBuyerValuesMap.get(newBuyerValues.id);
          if(newBuyerValues.BuyerValueNm__c != oldBuyerValue.BuyerValueNm__c
             || newBuyerValues.ClientRankNbr__c != oldBuyerValue.ClientRankNbr__c)
             
              {
             
                 updateBuyerValuesList.add(newBuyerValues);
             }
        
        }
        return updateBuyerValuesList;
    }
    
    
}