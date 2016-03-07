trigger noteUpdation on Note (before update,before delete) {

Profile ProfileName = [select Name from profile where id = :userinfo.getProfileId()];
if(ProfileName.Name!='System Administrator'){
if(trigger.isupdate)
{ 
  for(Note notes : trigger.new)
  {
    notes.adderror('you are not able to delete');
  }
}

if(trigger.isdelete)
{
   for(Note notes1:trigger.old)
   {
     notes1.adderror('you cant delete');
   }
}

}
}