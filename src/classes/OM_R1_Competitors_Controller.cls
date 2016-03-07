public class OM_R1_Competitors_Controller{
    public Boolean disabl{get;set;}
    ApexPages.StandardSetController setCon;
    List<Competitor1__c> competitorList{get;set;}
    Id oppId = null;
    String paramString;
    List<string> params = new List<String>();
    List<String> compIds = new List<String>();
    public OM_R1_Competitors_Controller(ApexPages.StandardSetController controller) {
        PageReference testRef = ApexPages.currentPage();
        Map<String,String> m = testRef.getParameters();
        system.debug('hello malla'+testRef.getParameters());
        String s = m.get('id');
        this.paramString=s;
        system.debug('Hi malla'+this.paramString);
        this.params = s.split(',');
        system.debug('Hi everyone'+this.params[0]);
        oppId = this.params[0]; 
        for(integer j = 1; j < this.params.size(); j++){
          compIds.add(this.params[j]);
        }      
    } 
   
   public List<Competitor1__c> getCompetitorList(){
        
        if(compIds.size() != 0){
          this.competitorList=  [select id, name, Opportunity_Name__r.Name,Competitor_Value__c, Test_competitor__c from Competitor1__c
                              where id IN :compIds];
        }else{
        this.competitorList=  [select id, name, Opportunity_Name__r.Name,Competitor_Value__c, Test_competitor__c from Competitor1__c
                              where Opportunity_Name__c =: oppId];
        }
        return this.competitorList;
    }  
    
    public pagereference  saveCompetitors(){
        disabl = true;
        try{
            this.competitorList = getChangedCompetitors();
            update this.competitorList;

            PageReference pageRef = new PageReference('/'+oppId);
            return pageRef;

        }catch(Exception e){            
            ApexPages.addMessages(e);      
            return null;
        }
       
    }
    
   public pagereference  cancelCompetitors(){
         PageReference pageRef = new PageReference('/'+oppId);
         return pageRef;
   }
    /**
     *  get all changed record on Competitor edit all page
     *  @return updateCompetitorsList
     */
    private List<Competitor1__c> getChangedCompetitors(){
        Map<Id, Competitor1__c> oldCompetitorMap = new Map<Id, Competitor1__c>([select id, name, Opportunity_Name__r.Name, Test_competitor__c,Competitor_Value__c from Competitor1__c where Opportunity_Name__c =: oppId limit :Limits.getLimitQueryRows()]);
        List<Competitor1__c> updateCompetitorsList = new List<Competitor1__c>();
        Competitor1__c oldCompetitor = null;
        for(Competitor1__c newCompetitor : this.competitorList) {
            oldCompetitor = oldCompetitorMap.get(newCompetitor.id);
            if(newCompetitor.Test_competitor__c != oldCompetitor .Test_competitor__c
               || newCompetitor.Competitor_Value__c != oldCompetitor .Competitor_Value__c) {
               
                    updateCompetitorsList.add(newCompetitor);
               }
        
        }
        return updateCompetitorsList;
    }
    
}