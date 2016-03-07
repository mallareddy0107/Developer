trigger shareExpenditureToStudents on Gifts_Expenditures__c (after insert,after update) {
TriggerActive__c status=TriggerActive__c.getValues('ActivateTrigger');
if(status.IsActive__c==true){
List<Student__c> listtoupdate=new List<Student__c>();
List<Student__c> stdlist=new List<Student__c>();
Gifts_Expenditures__c geList=Trigger.new[0];
//Id geid=Trigger.new[0].id;
//Id batchId=geid.Batch__r.id;
if(/*(Trigger.new[0].Share_With_All_students__c!=Trigger.old[0].Share_With_All_students__c)&&(*/Trigger.new[0].Share_With_All_students__c==true)
{
system.debug('values in trigger'+Trigger.new[0].id);
system.debug('batch id'+Trigger.new[0].Batch__r.id);
/*Batch__c batch=[select Name,(select id,Name,Additional_Fee__c from Students__r) from Batch__c where id=:Trigger.new[0].Batch__r.id];
system.debug('the batch of students are:'+batch);*/
Gifts_Expenditures__c  ge=[select id, Name,Batch__r.id,Batch__r.Name from Gifts_Expenditures__c where id=:Trigger.new[0].id];
Id batchId=ge.Batch__r.id;
system.debug('batch id is'+batchId);
Batch__c batch1=[select id,Name, (select id,Name,Additional_Fee__c from Students__r) from Batch__c where id=:batchId];
system.debug('student records are'+batch1);
stdlist=batch1.students__r;
for(Student__c stu:stdlist)
{
stu.Additional_Fee__c=((trigger.new[0].Item_Total_Cost__c)/(stdlist.size()));
listtoupdate.add(stu);
}
update listtoupdate;
}
}
}