public class dataTableCon {

    public dataTableCon(ApexPages.StandardController controller) {
       this.proj = (Account)controller.getSubject();
  
        this.delivers = [ SELECT 
      d.Name, 
      d.LastModifiedDate, d.LastModifiedById, 
      d.Email__c, d.Id, d.SLAExpirationDate__c, d.CreatedDate, d.CreatedById, 
      d.Website, d.AccountNumber, d.AllStates__c
      FROM 
      Account d
      WHERE 
      d.id= :proj.id ];
 }
 
 // Action Method called from page button
 public pagereference saveChanges() { 
  upsert this.delivers;
  return null;
 }
 
 // Action Method called from page link
 public pagereference newDeliverable() { 
  Account d = new Account();
  d.id=this.proj.id; 
  delivers.add( d );
  return null;
 }
 
 // public Getter to provide table headers 
 public string[] getheaders() { return new string [] 
  {'Name','AccountNumber','AllStates__c','Email__c', 'SLAExpirationDate__c'} ; }
 
 // public Getter to list project deliverables
 public Account[] getDeliverables() { 
  return this.delivers; 
 } 
 
 // class variables
 Account proj;
 Account[] delivers; 
}