trigger oneStudentOneOffer on Offer__c (After insert,After delete) {
set<id> ids = new set<id>();
List<Malla__Student__c> studentsToUpdate = new List<Malla__Student__c>();
private static ID ReadonlyRecordType = Schema.SObjectType.Malla__Student__c.getRecordTypeInfosByName().get('Read-Only Layout').getRecordTypeId();
private static ID MasterRecordType = Schema.SObjectType.Malla__Student__c.getRecordTypeInfosByName().get('Master').getRecordTypeId();
for(Offer__c offer : Trigger.New){
  ids.add(offer.Student__c);
}
List<Student__c> stuList = [select id,Name,RecordTypeId , (select id,Name from Offers__r) from Student__c where id in :ids];
for(Student__c stu : stuList){
  if(stu.Offers__r.size()>=1 && stu.RecordTypeId != ReadonlyRecordType){
      stu.RecordTypeId = ReadonlyRecordType;
      studentsToUpdate.add(stu);  
  }else{
      stu.RecordTypeId = MasterRecordType;
      studentsToUpdate.add(stu);
  }
  
}
update studentsToUpdate;
}