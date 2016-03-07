@isTest


public class Test_ContactExtensionController {

public static testMethod void checkValidations() {
        Contact con=new Contact(LastName='Malla');
        insert con;
        PageReference pageRef = Page.ContactVFPage;
        Test.setCurrentPage(pageRef);
        //Contact con1=new Contact();
        ApexPages.StandardController sc = new ApexPages.standardController(con);      
        ContactExtension controller = new ContactExtension (sc);
        controller.getrecords();
        //controller.submt();
        
        controller.search();
        
        }
   }