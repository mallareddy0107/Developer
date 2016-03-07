/*ClassName: KeyBuyerValues_Controller

History of changes: 
-------------------------------------------------------------------------
   Date                Developer                         Comments   
-------------------------------------------------------------------------
   14/11/2013          preeti.rathore@accenture.com     Created
   30/12/2014          shilpa.mn@accenture.com          Modified
   16/04/2015          y.a.wang@accenture.com           Modified
************************************************************************/
public class KeyBuyerValues_Controller{

    ApexPages.StandardSetController setCon;
    List<OpportunityKeyBuyer__c> KeyBuyerValuesList;
    Id oppId = null;
  
   public static  BOOLEAN IS_CALL_FROM_SAVEAPRROVAL = false;

    public KeyBuyerValues_Controller(ApexPages.StandardSetController controller) {
        oppId = ApexPages.currentPage().getParameters().get('Id');        
    } 
   
   public List<OpportunityKeyBuyer__c> getKeyBuyerValuesList(){                 
        ///****************************Added by Shilpa for Bug#378488 - Begin****************************///
        this.KeyBuyerValuesList =  [select id, name, KeyBuyerId__c, KeyDecisionMakerNm__c,KeyBuyerRoleNm__c,CoachNm__c,KeyBuyerRelationshipIbjectiveDesc__c from OpportunityKeyBuyer__c 
                              where OpportunityId__c =: oppId ];
       ///****************************Added by Shilpa for Bug#378488 - End****************************//
        return this.KeyBuyerValuesList;
    }  
    
    public pagereference  saveKeyBuyerValues(){
        try{
          //****************************Added by y.a.wang for Bug#448364 - Begin****************************//
          this.KeyBuyerValuesList = getChangedKeyBuyerValues();
          //****************************Added by y.a.wang for Bug#448364 - End****************************//
            IS_CALL_FROM_SAVEAPRROVAL = true;
            update this.KeyBuyerValuesList;
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
    private List<OpportunityKeyBuyer__c> getChangedKeyBuyerValues(){
      Map<Id, OpportunityKeyBuyer__c> oldKeyBuyerValuesMap = new Map<Id, OpportunityKeyBuyer__c>([select id, name, KeyBuyerId__c, KeyDecisionMakerNm__c,KeyBuyerRoleNm__c,CoachNm__c,KeyBuyerRelationshipIbjectiveDesc__c  from OpportunityKeyBuyer__c 
                              where OpportunityId__c =: oppId ]);
      List<OpportunityKeyBuyer__c> updateKeyBuyerValuesList = new List<OpportunityKeyBuyer__c>();
        OpportunityKeyBuyer__c oldKeyBuyerValue = null;
        for(OpportunityKeyBuyer__c newKeyBuyerValues : this.KeyBuyerValuesList) {
          oldKeyBuyerValue= oldKeyBuyerValuesMap.get(newKeyBuyerValues.id);
          if(   newKeyBuyerValues.KeyBuyerId__c != oldKeyBuyerValue.KeyBuyerId__c
             || newKeyBuyerValues.KeyDecisionMakerNm__c != oldKeyBuyerValue.KeyDecisionMakerNm__c
             || newKeyBuyerValues.KeyBuyerRoleNm__c != oldKeyBuyerValue.KeyBuyerRoleNm__c
             || newKeyBuyerValues.CoachNm__c != oldKeyBuyerValue.CoachNm__c
             || newKeyBuyerValues.KeyBuyerRelationshipIbjectiveDesc__c!= oldKeyBuyerValue.KeyBuyerRelationshipIbjectiveDesc__c)
             
              {
             
                 updateKeyBuyerValuesList.add(newKeyBuyerValues);
             }
        
        }
        return updateKeyBuyerValuesList;
    }
    
    
}