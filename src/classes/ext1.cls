public with sharing class ext1 {
    public static string message { get; set; }

    public ext1(ApexPages.StandardController controller) {

    }
    public void saveAccount(){
    
    system.debug('From Ext1'+ext2.test);
    }
}