public class OM_R1_OppRibbonExtension {

    private ApexPages.StandardController stdController;
    public String redirectUrl {public get; private set;}
    public Boolean shouldRedirect {public get; private set;}
    public String stageName{public get;public set;}
    private Opportunity opp;
    
    public OM_R1_OppRibbonExtension(ApexPages.StandardController stdController) {
        this.stdController = stdController;
        this.opp = (Opportunity)stdController.getRecord();
        this.stageName = this.opp.stagename;
        shouldRedirect = false;
    }
    public PageReference saveChanges() {
        try{
            this.stdController.save();
            redirectUrl = stdController.view().getUrl();
            if (!ApexPages.hasMessages()){
                shouldRedirect = true;
            }
            
            if (ApexPages.hasMessages()){
               shouldRedirect = false;
               //throw new OM_R1_ApplicationException (ApexPages.getMessages().get(0).getDetail());
               //errorMessage = 'ERROR : ' + ApexPages.getMessages().get(0).getDetail();
               for(ApexPages.Message msg:ApexPages.getMessages()){
                   ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,msg.getDetail()));
               }
            }else{
                redirectUrl = stdController.view().getUrl();
                shouldRedirect = true;
            }
            System.debug('in try : ' + shouldRedirect);
            return null;
        
        }catch(Exception e){
            ApexPages.addMessages(e);            
            return null;
        }
        
    }
    public PageReference cancelChanges() {
        this.stdController.cancel();
         redirectUrl = stdController.view().getUrl();
         shouldRedirect = true;
        return null;
    }
}