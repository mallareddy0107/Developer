public class OpportunitiesTriggerHandler{
     // Map<Id,opportunity> mapOfOpps=new Map<Id,Opportunity>();
     List<Account> listOfAccs=new List<Account>();
     public static String[] th = new String[]{'', 'Thousand', 'Million', 'Billion', 'Trillion'};
     public static String[] dg = new String[]{'Zero', 'One', 'Two', 'Three', 'Four', 'Five', 'Six', 'Seven', 'Eight', 'Nine'};
     public static String[] tn = new String[]{'Ten', 'Eleven', 'Twelve', 'Thirteen', 'Fourteen', 'Fifteen', 'Sixteen', 'Seventeen', 'Eighteen', 'Nineteen'};
     public static String[] tw = new String[]{'Twenty', 'Thirty', 'Forty', 'Fifty', 'Sixty', 'Seventy', 'Eighty', 'Ninety'};
     public static string[] nlist;
     public void opportunityTriggerMethod(Map<Id,opportunity> mapOfOpps){
        
        for(Account acc:[select id,Most_Recently_Created_Opportunity_Name__c from Account where id in :mapOfOpps.keySet()])
        {
          acc.Most_Recently_Created_Opportunity_Name__c = mapOfOpps.get(acc.id).Name;  
          listOfAccs.add(acc);
        }
       update listOfAccs;
          
     }
       /********************************************
        //Method Name : ConvertAmountToWords
        //Parameted : Decimal Amount
        //Description : To convert Amount into Words
        ************************************************/
        public static String ConvertAmountToWords(decimal amt)
        {
        string s=String.valueof(amt.setscale(2));
        integer x=s.indexOf('.');
        if (x == -1) x = s.length();
        //if (x > 15) //show error {}
        nlist = s.split('');
        nlist.remove(0);
        string str = '';
        integer sk = 0;
        for (integer i = 0; i < x; i++){
        System.debug((x-i)+'#######'+Math.mod((x - i),3));
        if (Math.mod((x - i),3) == 2)
        {
        if (nlist[i] == '1'){
        str += tn[Integer.valueof(nlist[i + 1])] + ' ';
        i++;
        sk = 1;
        } 
        else if (nlist[i] != '0')
        {
        str += tw[Integer.valueof(nlist[i])- 2] + ' ';
        sk = 1;
        }
        } 
        else if (nlist[i] != '0') {
        str += dg[Integer.valueof(nlist[i])] + ' ';
        if (Math.mod((x - i),3) == 0) str += 'hundred';
        sk = 1;
        }
        if (Math.mod((x - i),3) == 1){
        if (sk==1) str += th[(x - i - 1) / 3] + ' ';
        sk = 0;
        }
        }
        if (x != s.length()){
        integer y = s.length();
        str += 'and ';
        for (integer i = x + 1; i < y; i++) 
        {
        if (Math.mod((y - i),3) == 2)
        {
        if (nlist[i] != '0')
        {
        str += tw[Integer.valueof(nlist[i])- 2] + ' Paise Only';
        }
        else
        {
        str += dg[Integer.valueof(nlist[i])] + ' Paise Only';
        } 
        }
        }
        }
        
        return str;
        }

}