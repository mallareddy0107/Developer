/*ClassName:CompetitorValues_Controller

History of changes: 
-------------------------------------------------------------------------
   Date                Developer                         Comments   
-------------------------------------------------------------------------
   14/11/2013          preeti.rathore@accenture.com     Created
   30/12/2014          shilpa.mn@accenture.com          Modified
   16/04/2015          y.a.wang@accenture.com           Modified
************************************************************************/
public class CompetitorValues_Controller{

    ApexPages.StandardSetController setCon;
    List<OM_R1_Competitor__c> CompetitorsList;
    Id oppId = null;
  
   public static  BOOLEAN IS_CALL_FROM_SAVEAPRROVAL = false;

    public CompetitorValues_Controller(ApexPages.StandardSetController controller) {
        oppId = ApexPages.currentPage().getParameters().get('Id');        
    } 
   
   public List<OM_R1_Competitor__c> getCompetitorsList(){                 
        ///****************************Added by Shilpa for Bug#378488 - Begin****************************///
        this.CompetitorsList =  [select id, name, Competitor__c, OtherCompetitors__c,OM_R1_Strengths__c,OM_R1_Weaknesses__c,AccentureStrategyToWinDesc__c,CompetitorStrategyToWinDesc__c from OM_R1_Competitor__c 
                              where OM_R1_Opportunity__c =: oppId ];
       ///****************************Added by Shilpa for Bug#378488 - End****************************//
        return this.CompetitorsList;
    }  
    
    public pagereference  saveCompetitorValues(){
        try{
          //****************************Added by y.a.wang for Bug#448364 - Begin****************************//
          this.CompetitorsList = getChangedCompetitorValues();
          //****************************Added by y.a.wang for Bug#448364 - End****************************//
            IS_CALL_FROM_SAVEAPRROVAL = true;
            update this.CompetitorsList;
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
    private List<OM_R1_Competitor__c> getChangedCompetitorValues(){
      Map<Id, OM_R1_Competitor__c> oldCompetitorsMap = new Map<Id, OM_R1_Competitor__c>([select id, name, Competitor__c, OtherCompetitors__c,OM_R1_Strengths__c,OM_R1_Weaknesses__c,AccentureStrategyToWinDesc__c,CompetitorStrategyToWinDesc__c from OM_R1_Competitor__c 
                              where OM_R1_Opportunity__c =: oppId ]);
      List<OM_R1_Competitor__c> updateCompetitorsList = new List<OM_R1_Competitor__c>();
        OM_R1_Competitor__c oldCompetitorValue = null;
        for(OM_R1_Competitor__c newCompetitorValues : this.CompetitorsList) {
          oldCompetitorValue= oldCompetitorsMap.get(newCompetitorValues.id);
          if(   newCompetitorValues.Competitor__c != oldCompetitorValue.Competitor__c
             || newCompetitorValues.OtherCompetitors__c != oldCompetitorValue.OtherCompetitors__c
             || newCompetitorValues.OM_R1_Strengths__c != oldCompetitorValue.OM_R1_Strengths__c
             || newCompetitorValues.OM_R1_Weaknesses__c != oldCompetitorValue.OM_R1_Weaknesses__c
             || newCompetitorValues.AccentureStrategyToWinDesc__c!= oldCompetitorValue.AccentureStrategyToWinDesc__c
             || newCompetitorValues.CompetitorStrategyToWinDesc__c!= oldCompetitorValue.CompetitorStrategyToWinDesc__c)
             
              {
             
                 updateCompetitorsList.add(newCompetitorValues);
             }
        
        }
        return updateCompetitorsList;
    }
    
    
}