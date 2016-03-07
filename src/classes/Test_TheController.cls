@isTest
public class Test_TheController
{

public static testmethod void testMyController()
   {
        PageReference pageRef = Page.success;
        Test.setCurrentPage(pageRef);
        
        thecontroller  controller=new thecontroller();
        String nextPage = controller.save().getUrl();
        System.assertEquals('/apex/failure?error=noParam', nextPage);
        ApexPages.currentPage().getParameters().put('qp', 'yyyy');
        controller = new thecontroller(); 
        controller.setLastName('lastname');
        //controller.setFirstName('firstname');
        controller.setCompany('acme');
        controller.setEmail('firstlast@acme.com');
        nextPage = controller.save().getUrl();
       // String company1=getCompany(controller);
        //System.assertEquals('/apex/success', nextPage);
        Lead[] leads = [select email from lead where Company = 'acme'];
        System.assertEquals('firstlast@acme.com', leads[0].email);
        
        
        
        
        
        
        
    }
}