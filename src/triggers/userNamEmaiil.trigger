trigger userNamEmaiil on User (before insert, before update) 
{
    if(trigger.isInsert)
    {
        for(User u : trigger.new)
        {
            /*if(u.name != u.Email)
            {
                u.addError('Username and Email should be same');
            } */          
        }
    }
    else if(trigger.isUpdate)
    {    
        for(User o : trigger.old)
        {
            for(User n : trigger.new)
            {
                if(o.email != n.Email)
                {
                    n.addError('Email address cannot be changed');
                }   
            } 
        } 
    }
}