public class ActionPollerCon {
public String result {get;set;}
public boolean en {get;set;}
public Integer inc=0;
public boolean but {get;set;}
    public void ActionPollerCon () {
        but = false;
    }
    public void hitme () {
        inc++;
    }
    public pagereference act () {
        result = 'Your hit is '+inc;
        but = true;
        pagereference ref;        
        return null;
    }
}