public class extCtrlRecordtyperedirect{ 
     Public string strRecTypeName {get; set; }
     public extCtrlRecordtyperedirect(ApexPages.StandardController controller) {
          string strRecTypeid = apexpages.currentpage().getparameters().get('RecordType');
          if(strRecTypeid !=  null){
            Schema.DescribeSObjectResult d = Schema.SObjectType.Student__c; 
            Map<Id,Schema.RecordTypeInfo> rtMapById = d.getRecordTypeInfosById();
            strRecTypeName = rtMapById.get(strRecTypeid).getName();
        }
}
}