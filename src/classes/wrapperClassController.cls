public class wrapperClassController {
 
    //Our collection of the class/wrapper objects wrapAccount
    public List<wrapAccount> wrapAccountList {get; set;}
    public List<Account> selectedAccounts{get;set;}
 
    public wrapperClassController(){
        if(wrapAccountList == null) {
            wrapAccountList = new List<wrapAccount>();
            for(Account a: [select Id, Name,BillingState, Website, Phone from Account limit 10]) {
                // As each Account is processed we create a new wrapAccount object and add it to the wrapAccountList
                wrapAccountList.add(new wrapAccount(a));
            }
        }
    }
 
    public void processSelected() {
    selectedAccounts = new List<Account>();
 
        for(wrapAccount wrapAccountObj : wrapAccountList) {
            if(wrapAccountObj.selected == true) {
                selectedAccounts.add(wrapAccountObj.acc);
            }
        }
    }
 
    // This is our wrapper/container class. In this example a wrapper class contains both the standard salesforce object Account and a Boolean value
    public class wrapAccount {
        public Account acc {get; set;}
        public Boolean selected {get; set;}
 
        public wrapAccount(Account a) {
            acc = a;
            selected = false;
        }
    }
}


/* public class wrapperClassController {

  
    //Our collection of the class/wrapper objects cContact 
    public List<cContact> contactList {get; set;}
    public List<Contact> selectedContacts{get;set;}

    //This method uses a simple SOQL query to return a List of Contacts
    public List<cContact> getContacts() {
        if(contactList == null) {
            contactList = new List<cContact>();
            for(Contact c: [select Id, Name, Email, Phone from Contact limit 2]) {
                // As each contact is processed we create a new cContact object and add it to the contactList
                contactList.add(new cContact(c));
            }
        }
        return contactList;
    }


    public pageReference processSelected() {

                //We create a new list of Contacts that we be populated only with Contacts if they are selected
        List<Contact> selectedContacts = new List<Contact>();

        //We will cycle through our list of cContacts and will check to see if the selected property is set to true, if it is we add the Contact to the selectedContacts list
        for(cContact cCon: getContacts()) {
            if(cCon.selected == true) {
                selectedContacts.add(cCon.con);
            }
        }

        // Now we have our list of selected contacts and can perform any type of logic we want, sending emails, updating a field on the Contact, etc
        System.debug('These are the selected Contacts...'+selectedContacts);
        for(Contact con: selectedContacts) {
            system.debug(con);
        }
        //contactList=null; // we need this line if we performed a write operation  because getContacts gets a fresh list now
        return null;
    }


    // This is our wrapper/container class. A container class is a class, a data structure, or an abstract data type whose instances are collections of other objects. In this example a wrapper class contains both the standard salesforce object Contact and a Boolean value
    public class cContact {
        public Contact con {get; set;}
        public Boolean selected {get; set;}

        //This is the contructor method. When we create a new cContact object we pass a Contact that is set to the con property. We also set the selected value to false
        public cContact(Contact c) {
            con = c;
            selected = false;
        }
    }
} */