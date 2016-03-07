public class Sample
{ 
    public List<contact> listofcontacts{get;set;}
    public string enteredcontact{get;set;}
    List<Contact> records;
    //listofcontacts=new List<Contact>();
    public List<Contact> getrecords(){
      system.debug('values are'+listofcontacts);
      return listofcontacts;
      }
    public pagereference search() {
     
     //listofcontacts=[select id,Name,LastName,Phone,Email from contact];
     //Contact contact1=new Contact();
     listofcontacts=[select Name,LastName,Email,Phone from Contact where Name=:enteredcontact];
     system.debug('contact is'+listofcontacts);
        
        return null;
    }
     
    public Contact con = new Contact();
    //public String extId{get;set;}
    public String nam{get;set;}
    public String mail{get;set;}
    public string tmail{get;set;}
    public void submt()
    {
        con.LastName= nam;
        con.Email=mail;
        con.Test_Email__c=tmail;
        insert con;
    }   
}






/*

<apex:page controller="consearch">
   <apex:form >
   <apex:pageMessage severity="error" strength="2"  summary="Error:" detail="{!errorMessage}"  rendered="{!errorMessage != null}"/>
   <table>
   <tr>
   <td>Contact: </td>
   <td><apex:inputtext value="{!name}" required="true"/></td>
   <td></td>
   <td><apex:commandButton action="{!search}" value="Go"/>
   </td>
   </tr>
   </table>
   <apex:pageBlock rendered="{!name != null}" >
   <apex:pageBlockSection title="Contact Details" rendered="{!errorMessage == null}">
   <apex:pageBlockTable value="{!records}" var="rec">
   <apex:column value="{!rec.Name}" headerValue="Name"/>
   <apex:column value="{!rec.Email}" headerValue="Email"/>
   <apex:column value="{!rec.Phone}" headerValue="Phone"/>
   </apex:pageBlockTable>
   </apex:pageBlockSection>
   </apex:pageBlock>
   </apex:form>
</apex:page>


*/

/*


public class consearch {
public String name{ get ; set;}
List<Contact> records;
List<Contact> templi;
public String msg {get; set; }
public transient String errorMessage { get; set; }
String s { get; set; } 
    public List<Contact> getrecords(){
      return records;
      }
      public consearch(){
       records = new List<Contact>();
    }
    public PageReference search() {
      s = '%' + name + '%';
       if(name.length()==0){
          errorMessage = 'Please enter a Contact Name';
         }
      records  =[select Name,Email,Phone from Contact  where name like:s OR Email like:s OR Phone like:s ];
       if(records !=null && records.size() ==0){
           errorMessage = 'CONTACT NOT fOUND !';
         }
     return null;
   }
}


*/