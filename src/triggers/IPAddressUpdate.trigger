trigger IPAddressUpdate on Tracking__c (after insert) {
public String ipAddress;
Map<String, String> mapHeaders = ApexPages.currentPage().getHeaders(); 
       if(mapHeaders != null) {

            ipAddress = mapHeaders.get('True-Client-IP');
            if(ipAddress == null){
                ipAddress = mapHeaders.get('X-Salesforce-SIP');
            }
        }
//public string myIPAddress = ApexPages.currentPage().getHeaders().get('X-Salesforce-SIP');
system.debug('hello malla'+ipAddress);

for(Tracking__c track:trigger.new)
{
  track.IP_Address__c = ipAddress;
  update track;
  system.debug('###########'+track.IP_Address__c);
}

}