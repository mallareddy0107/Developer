public class OnLoadController {

    public String Page {get; set;}
    public String OpenPageURL {get; set;}

    public void OnLoadController()
    {
        Page = 'mytestpage' ;
        OpenPageURL = 'https://www.google.com/?gws_rd=cr&ei=IhiYUoCsOcWdhAedlIKwDg' ;
    }

    public PageReference redirect()
    {
        
            OpenPageURL = 'http://www.youtube.com/embed/' ;
        
        if(Page == 'mpay')
        {
            OpenPageURL = 'http://www.yahoo.com/' ;
        }
        return null;
    }

}