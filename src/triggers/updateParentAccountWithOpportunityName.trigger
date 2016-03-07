trigger updateParentAccountWithOpportunityName on Opportunity (before insert,before update,after insert,after update,before delete,after delete) {
  Map<Id,opportunity> mapOfOpps=new Map<Id,Opportunity>();
  List<Opportunity> oppsList = new List<Opportunity>();
  public static string s1='';
  List<Opportunity> listOfOpps=new List<Opportunity>();
  listOfOpps=[select id,Name from Opportunity];
  OpportunitiesTriggerHandler handler=new OpportunitiesTriggerHandler();
  set<String> fieldSet = new Set<String>();
  for(Schema.FieldSetMember fields :Schema.SObjectType.Opportunity.fieldSets.getMap().get('Malla__TestFieldSet').getFields()){
    fieldSet.add(fields.getFieldPath());
  }
  system.debug('field set values are'+fieldSet);
  if(((trigger.isInsert) || (trigger.isUpdate)) && (trigger.isafter)){
  for(Opportunity a: trigger.new){
  system.debug('*****Sample etst*****'+a.Amount+'-----'+a.StageName);
  set<String> changedFieldSet  = new Set<String>();
    for(string s: fieldSet){
        if(a.get(s) != trigger.oldMap.get(a.Id).get(s)){
            changedFieldSet.add(s);
            oppsList.add(a);
            return;
            system.debug('inside if loop'+a.get(s)+'------'+trigger.oldMap.get(a.Id).get(s));
        }
    }
    if(changedFieldSet.size()>0){
    system.debug('inside if loop'+changedFieldSet.size());
        for(Opportunity opp:oppsList)
        {
          mapOfOpps.put(opp.Accountid,opp);
        }
        handler.opportunityTriggerMethod(mapOfOpps);
    }
    }
    
    for(opportunity opp : Trigger.old){
      system.debug('**********&&&&&&&&&&&&&'+opp.Amount+'888888'+opp.stageName);
    
    }
        
  }
  if(((trigger.isBefore) && (trigger.isinsert)) || ((trigger.isBefore) && (trigger.isUpdate)))
   {
     for(Opportunity OppIterator : trigger.new)
     {
        if(OppIterator.Amount>0)
        {
        if(OppIterator.Amount != trigger.oldmap.get(OppIterator.Id).Amount)
        OppIterator.Amount_In_Words__c=OpportunitiesTriggerHandler.ConvertAmountToWords(OppIterator.Amount);
        }
        s1=OppIterator.ps__c;
        if((s1 != null)&&(s1.contains('VB-') ) )
        {
        IF(OppIterator.revenue__c==null||OppIterator.revenue1__c==null||OppIterator.revenue2__c==null)
        OppIterator.ps__c.adderror('Malla reddy is required');
        }
        else
        IF(OppIterator.revenue__c!=null||OppIterator.revenue1__c!=null||OppIterator.revenue2__c!=null)
        OppIterator.ps__c.adderror('Subra  is required');
        
        
     }
   }
}

/*

public List<Opportunity> checkApproverFieldUpdate(List<Opportunity> opportunityListNew, Map<Id, Opportunity> oppMapOld){
        
        set<String> fieldSet = new Set<String>();
        List<Opportunity> oppNewList = new List<Opportunity>();
        set<String> changedFieldSet  = new Set<String>();
        List<Opportunity> updatedList = new List<Opportunity>();
        for(Schema.FieldSetMember fields : Schema.SObjectType.Opportunity.fieldSets.getMap().get('FieldsForRBECalculation').getFields()){
               fieldSet.add(fields.getFieldPath());
        }
        
        if(Trigger.isUpdate) {
                for(Opportunity opp: opportunityListNew) {
                   for(string s: fieldSet){
                      if(opp.get(s) != trigger.oldMap.get(opp.Id).get(s)){
                         changedFieldSet.add(s);
                         updatedList.add(opp);
                       }
                    }         
                 }
         }
        
        return updatedList;
      }
      
      
 */