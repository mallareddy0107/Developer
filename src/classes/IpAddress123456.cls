global class IpAddress123456{ 

  public string myIpAddress {get;set;}
     public IpAddress123456(){
     
     myIpAddress = ApexPages.currentPage().getHeaders().get('X-Salesforce-SIP');
     system.debug('******'+myIpAddress);
     }
  
}