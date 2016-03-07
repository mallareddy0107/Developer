global class deleteAccounts implements Database.Batchable<sObject>{
    global final String Query;
global Database.QueryLocator start(Database.BatchableContext BC){
    String query = 'SELECT Id,Name FROM Account';
     return Database.getQueryLocator(query);
}
global void execute(Database.BatchableContext BC,List<Account> scope){
    List <Account> lstAccount = new list<Account>();
    for(integer i = 0;i<=201;i++){
    List<Account> acc = [select id,Name from Account];
    }
    for(Account s : scope)
    {
    Account a = (Account)s;
    lstAccount.add(a);
    }
    Delete lstAccount;
}
global void finish(Database.BatchableContext BC){
    //Send an email to the User after your batch completes
    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    String[] toAddresses = new String[] {'sforce2009@gmail.com'};
    mail.setToAddresses(toAddresses);
    mail.setSubject('Apex Batch Job is done');
    mail.setPlainTextBody('The batch Apex job processed');
    Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
}

}