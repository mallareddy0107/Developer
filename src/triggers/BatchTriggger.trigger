trigger BatchTriggger on Batch__c (before insert,before update,after insert,after update) {

List<Batch__c> listOfBatches=new List<Batch__c>();
List<student__c> listOfStudents=new List<student__c>();
set<id> setOfIds=new Set<id>();
List<Student__c> ListToUpdateStudents=new List<Student__c>();
/*for(Batch__c bat:Trigger.new)
{
  setOfIds.add(bat.id);
  }*/

//listOfBatches=[select id,Name,Batch_Fee__c,(select id,ExpectedFee__c,Fee_Status__c from Students__r) from Batch__c];
//listOfStudents=listOfBatches.Students__r;
for(Batch__c batch:Trigger.new)
{
 setOfIds.add(batch.id);
}
 listOfBatches=[select id,Name,Batch_Fee__c,(select id,ExpectedFee__c,Fee_Status__c from Students__r) from Batch__c where id =:setOfIds];
if(Trigger.isAfter)
{
if(trigger.isInsert || trigger.isUpdate)
{
 for(Batch__c bat:listOfBatches)
 {
  listOfStudents=bat.Students__r;
 for(Student__c std:listOfStudents)
 {
   if(std.Fee_Status__c!='Paid')
   {
    std.ExpectedFee__c=bat.Batch_Fee__c;
   }
    ListToUpdateStudents.add(std);
 }
 update ListToUpdateStudents;
} 
}
}
if(Trigger.isBefore)
{
for(Batch__c batch1:Trigger.new)
{
 if(batch1.Batch_Fee__c<15000)
 {
   batch1.addError('Enter or add Batch fee only above 15000');
   batch1.Batch_Fee__c.addError('Enter above 15000');
 }
if(batch1.Technology__c=='Salesforce')
{
 batch1.Faculty_Name__c='Shankar Rao';
}
}
}
}