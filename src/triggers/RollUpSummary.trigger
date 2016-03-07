trigger RollUpSummary on Student__c (After Insert,after delete) {
   set<id> ids = new set<id>();
   if(Trigger.isInsert){
   for(Student__c stu : Trigger.new){
       ids.add(stu.Batch__c);
   }
   }else if(Trigger.isDelete){
    for(Student__c stu : Trigger.old){
       ids.add(stu.Batch__c);
    }
   }
   List<Batch__c> batch = new List<Batch__c>();
   batch = [select id,Name,No_Of_Students__c,(select id,Name from Students__r) from Batch__c where id IN :ids];
   for(Batch__c batch1 : batch){
   integer stuSize = batch1.Students__r.size();
   system.debug('%%%%%%%%'+batch1);
       batch1.No_Of_Students__c = stuSize;
     update batch1;
   }
}