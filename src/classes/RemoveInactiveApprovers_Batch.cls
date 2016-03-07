global class RemoveInactiveApprovers_Batch implements Database.Batchable<sObject> {
    
    //private List<People__c> inActivePeople = new List<People__c>();
    private List<Competitor1__c> listOfApprovers = new List<Competitor1__c>();
   
    List<Opportunity> queryString = new List<Opportunity>();
    
      /**
      * @description       This constructor queries the soql query defined in the scheduler class .
      * @param             qString obtained from the schedulable class.
      * @return            queryString
      * @throws            NA
    */
   /* global RemoveInactiveApprovers_Batch(List<Opportunity> oppList){
            queryString =  oppList; 
    } 
   
    /**
      * @description       This method queries the soql query defined in the scheduler class and passes the List of records obtained to the execute method.
      * @param             currentScope A reference to the Database.BatchableContext object
      * @return            Database.QueryLocator
      * @throws            NA
    */
    global Iterable<sObject> start(Database.BatchableContext currentScope){ 
      List<Opportunity> listOfOpps = [Select id,Name,OM_R1_Approval_status__c from Opportunity where OM_R1_Approval_status__c != 'Approved'];
      system.debug('Hello1');
        return listOfOpps; 
    }
    
       /**
      * @description       This constructor get Dates from updateOutboundMessageClass controller
      * @param             SDate obtained from the controller class.
      * @param             EDate obtained from the controller class.
      * @param             STime obtained from the controller class.
      * @param             ETime obtained from the controller class.
      * @throws            NA
    */
    global void execute(Database.BatchableContext BC, List<Opportunity> scope)
    {
        //inActivePeople = [select Name,Employment_Status__c from People__c where Employment_Status__c = 'InActive' ];
        Competitor_Master_data__c enterpriseId = new Competitor_Master_data__c(Name = 'Malla');
        insert enterpriseId;
        List<Opportunity> ListOfOpps = [select id,Name,OM_R1_Approval_status__c from Opportunity where OM_R1_Approval_status__c = 'Pending'];
        system.debug('Hello2');
        for(opportunity opp:ListOfOpps)
        {
            List<Competitor1__c> approversByStage = [select id,Name,Opportunity_Name__c,Competitor_Master_data__r.Name from Competitor1__c where Opportunity_Name__c =: opp.id];
            for(Competitor1__c approver : approversByStage)
            {
                listOfApprovers.add(approver);
            }
            
        }
        for(Competitor1__c aprBystage:listOfApprovers)
        {
           if(aprBystage.Competitor_Master_data__r.Name == 'IBM')
           {
            system.debug('Competitor is'+aprBystage.Competitor_Master_data__c);
           aprBystage.Competitor_Master_data__c=enterpriseId.id;
           update aprBystage;
           system.debug('Approvers are'+aprBystage.Competitor_Master_data__c);
           }
            
        }
        }
        
      
       /**
      * @description       This constructor get Dates from updateOutboundMessageClass controller
      * @param             SDate obtained from the controller class.
      * @param             EDate obtained from the controller class.
      * @param             STime obtained from the controller class.
      * @param             ETime obtained from the controller class.
      * @throws            NA
    */
    global void finish(Database.BatchableContext BC)
    {
    } 
}