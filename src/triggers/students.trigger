trigger students on Student__c (after insert,before insert)
{
Student__c  s =Trigger.new[0];
  
 Malla__Offer__c f  = new Malla__Offer__c();
 system.debug('##########' +s.id);
 f.Malla__Student__c = s.id;
 f.Malla__Company_Name__c='ssss' ;  
 f.Malla__Current_Packege__c=10000;
 //insert f;
 if(Trigger.isBefore){
     Student__c  s1 =Trigger.new[0];
     Blob exampleIv = Blob.valueOf('Example of IV123');
    Blob key = Crypto.generateAesKey(128);
    Blob data = Blob.valueOf(s1.Malla__EncryptTest__c);
    Blob encrypted = Crypto.encrypt('AES128', key, exampleIv, data);

    Blob decrypted = Crypto.decrypt('AES128', key, exampleIv, encrypted);
    String decryptedString = decrypted.toString();
    //System.assertEquals('Data to be encrypted', decryptedString);
    s1.Malla__EncryptTest__c = string.valueOf(encrypted);
    system.debug('&&&&&&&&&&&'+s1.Malla__EncryptTest__c);
    system.debug('**************'+decryptedString);
 }
 
}