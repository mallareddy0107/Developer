global class AccountOwnerReassignment implements 
             Database.Batchable<SObject>, Database.Stateful{
    
    User fromUser{get; set;}
    User toUser{get; set;}
    Double failedUpdates{get; set;}
 
    global AccountOwnerReassignment(User fromUser, User toUser){
        this.fromUser = fromUser;
        this.toUser = toUser;
        failedUpdates = 0;
    }
    
    global Database.queryLocator 
                    start(Database.BatchableContext ctx){
        return Database.getQueryLocator([SELECT id, name, ownerId 
                        FROM Account WHERE ownerId = :fromUser.id]);
    }
    
    global void execute(Database.BatchableContext ctx, List<Sobject>
                        scope){
        List<Account> accs = (List<Account>)scope;
        
        for(Integer i = 0; i < accs.size(); i++){
            accs[i].ownerId = toUser.id;
        }
        
        List<Database.SaveResult> dsrs = Database.update(accs, false);
        for(Database.SaveResult dsr : dsrs){
            if(!dsr.isSuccess()){
                failedUpdates++;
            }
            
        } 
    }
    
    global void finish(Database.BatchableContext ctx){
    
        AsyncApexJob a = [SELECT id, ApexClassId, 
                       JobItemsProcessed, TotalJobItems, 
                       NumberOfErrors, CreatedBy.Email 
                       FROM AsyncApexJob 
                       WHERE id = :ctx.getJobId()];
        
        String emailMessage = 'Your batch job '
             + 'AccountOwnerReassignment '
             + 'has finished.  It executed ' 
             + a.totalJobItems 
             + ' batches.  Of which, ' + a.jobitemsprocessed 
             + ' processed without any exceptions thrown and ' 
             + a.numberOfErrors +
             ' batches threw unhandled exceptions.'
             + '  Of the batches that executed without error, ' 
             + failedUpdates 
             + ' records were not updated successfully.';
        
        Messaging.SingleEmailMessage mail = 
              new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {a.createdBy.email};
        mail.setToAddresses(toAddresses);
        mail.setReplyTo('noreply@salesforce.com');
        mail.setSenderDisplayName('Batch Job Summary');
        mail.setSubject('Batch job completed');
        mail.setPlainTextBody(emailMessage);
        mail.setHtmlBody(emailMessage);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] 
                           { mail });
    }

    /*public static testmethod void testBatchAccountOwnerReassignment(){
     // Access the standard user profile  
    
        Profile p = [SELECT Id FROM profile 
                     WHERE name='Standard User']; 

    // Create the two users for the test  
    
        User fromUser = new User(alias = 'newUser1', 
            email='newuser1@testorg.com', 
            emailencodingkey='UTF-8', lastname='Testing', 
            languagelocalekey='en_US', 
            localesidkey='en_US', profileid = p.Id, 
            timezonesidkey='America/Los_Angeles', 
            username='newuser1@testorg.com');
        User toUser = new User(alias = 'newUser2', 
            email='newuser2@testorg.com', 
            emailencodingkey='UTF-8', lastname='Testing', 
            languagelocalekey='en_US', 
            localesidkey='en_US', profileid = p.Id, 
            timezonesidkey='America/Los_Angeles', 
            username='newuser2@testorg.com');
        insert fromUser;
        insert toUser;
        
        // Use the new users to create a new account  
    
        List<Account> accs = new List<Account>();
        for(integer i = 0; i < 200; i++){
            accs.add(new Account(name = 'test', 
                     ownerId = fromUser.id));
        }
        insert accs;

        // Actually start the test  
    
        Test.startTest();
        Database.executeBatch(new 
                 AccountOwnerReassignment(fromUser, 
                              toUser));
        Test.stopTest();

        // Verify the test worked  
    
        accs = [SELECT id, name FROM account 
                WHERE ownerId = :toUser.id];
        System.assert(accs.size() == 200);
    }*/
}