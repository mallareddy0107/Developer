public class Sample2
{   
  
    public Contact con = new Contact();
    //public String extId{get;set;}
    public String nam{get;set;}
    public String mail{get;set;}
    public void submt()
    {
        con.LastName= nam;
        con.Email=mail;
        insert con;
    }   
}