public class ContactExtension {
    public Contact con{get;set;}
    List<Contact> records;
    public string enteredcontact{get;set;}
    public List<contact> listofcontacts{get;set;}
    public ContactExtension(ApexPages.StandardController controller) {
     con=new Contact();         
    }
    public void submt()
    {
      
      insert con;
      
    }  
    
    public pagereference search() {
    
     listofcontacts=[select Name,LastName,Email,Phone from Contact where Name=:enteredcontact];
     system.debug('contact is'+listofcontacts);
     return null;
    }
    
    public List<Contact> getrecords(){
      system.debug('values are'+listofcontacts);
      return listofcontacts;
      }

}