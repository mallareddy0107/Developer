public with sharing class ext2 {
public static string test = '';
public ext2(ApexPages.StandardController controller) {

}

public string getext1message() {
    return ext1.message;
}
public void saveAccount(){ 
    test = 'hello'; 
    system.debug('From Ext2');
}
}