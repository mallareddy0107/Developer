public class SimilarCasesController {
    
    public Case getCurrentCase() {
        String cid = ApexPages.currentPage().getParameters().get('cid');
        return [SELECT Id, CaseNumber, Reason, Product__c FROM Case WHERE Id = :cid];
    }
    
    public Case[] getSimilarCases() {
        Case currentCase = getCurrentCase();
        return [SELECT Id, CaseNumber, Owner.Name, Subject, Status FROM Case WHERE 
            /* CreatedDate >= LAST_N_DAYS:365 AND
            Reason = :currentCase.Reason AND
            Product__c = :currentCase.Product__c AND */
            Id = :currentCase.Id];
    }
}