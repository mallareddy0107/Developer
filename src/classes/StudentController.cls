public with sharing class StudentController {
public List<Student__c> stuList;
public Id stuId = null;
public StudentController(){
    stuId = ApexPages.CurrentPage().getParameters().get('id');
    system.debug('**********'+stuId);
}
public List<Student__c> getstuList(){
    this.stuList = [select id,Name from Student__c where id =: stuId];
    system.debug('**********'+stuList);
    return this.stuList;
}
}