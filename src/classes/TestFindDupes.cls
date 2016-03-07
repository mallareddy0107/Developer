@isTest 
public class TestFindDupes {
    static testMethod void testDupes() {

       // Let's create our records from scratch!
       Contact c   = new Contact();
       c.FirstName = 'Stephen';
       c.LastName  = 'Curry';
       c.Email     = 'stephcurry@gsw.com';
       insert c;
       
       // Now let's create a dupe lead
       Lead dupeLead      = new Lead();
       dupeLead.FirstName = 'Steph';
       dupeLead.LastName  = 'Curry';
       dupeLead.Company   = 'Golden State Warriors';
       dupeLead.Email     = 'stephcurry@gsw.com';
       
       // This is a special way of doing "risky" things
       try {
           insert dupeLead;
       } catch (Exception e) { 
           System.debug('An error happened, as predicted!');
       }
       
       // Now we try to find our dupe lead, by email
       List<Lead> dupes = [SELECT Id FROM Lead 
                      WHERE Email = 'stephcurry@gsw.com'];
       System.assertEquals(0, dupes.size());
      
       // Now we "break" our trigger by inserting a non-dupe
       Lead legitLead      = new Lead();
       legitLead.FirstName = 'David';
       legitLead.LastName  = 'Lee';
       legitLead.Company   = 'Golden State Warriors';
       legitLead.Email     = 'dlee@gsw.com';
       insert legitLead;

       // Now we try to find our legit lead, by email
       List<Lead> legits = [SELECT Id FROM Lead 
                               WHERE Email = 'dlee@gsw.com'];
       System.assertEquals(1, legits.size());

    }
}