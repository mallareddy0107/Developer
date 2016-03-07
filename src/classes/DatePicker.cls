public class DatePicker 
{

    public String seventhdt { get; set; }

    public String sixthdt { get; set; }

    public String fifthdt { get; set; }

    public String fourthdt { get; set; }

    public String thirddt { get; set; }

    public String seconddt { get; set; }

    public string firstdt { get; set; }

    public String previous { get; set; }
    Public DatePicker(){
    
    System.debug('***********************************'+datename);
    datename=system.today();
  
    firstdt=system.today().day() + '/' + datename.month();
    seconddt=((system.today()+1).day()) + '/' + datename.month();
    thirddt=((system.today()+2).day()) + '/' + datename.month();
    fourthdt=((system.today()+3).day()) + '/' + datename.month();
    fifthdt=((system.today()+4).day()) + '/' + datename.month();
    sixthdt=((system.today()+5).day()) + '/' + datename.month();
    seventhdt=((system.today()+6).day()) + '/' + datename.month();
    }

    public void Next() {
    
       datename+=1; 
     System.debug('***********************************'+datename); 
   
    firstdt=datename.day() + '/' + datename.month();
    seconddt=((datename+1).day()) + '/' + datename.month();
    thirddt=((datename+2).day()) + '/' + datename.month();
    fourthdt=((datename+3).day()) + '/' + datename.month();
    fifthdt=((datename+4).day()) + '/' + datename.month();
    sixthdt=((datename+5).day()) + '/' + datename.month();
    seventhdt=((datename+6).day()) + '/' + datename.month();    
    }


    public void Previous() {
        datename -= 1;
        //return datename;
    System.debug('***********************************'+datename); 
   
    firstdt=datename.day() + '/' + datename.month();
    seconddt=((datename-1).day()) + '/' + datename.month();
    thirddt=((datename-2).day()) + '/' + datename.month();
    fourthdt=((datename-3).day()) + '/' + datename.month();
    fifthdt=((datename-4).day()) + '/' + datename.month();
    sixthdt=((datename-5).day()) + '/' + datename.month();
    seventhdt=((datename-6).day()) + '/' + datename.month();            
    }

public Date datename {get; set;}
}