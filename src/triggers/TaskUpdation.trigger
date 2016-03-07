trigger TaskUpdation on Contact (after insert, after update) {
  Task task;
  //User loggeduser = [select id,Name from user where id =: Userinfo.getUser()];
  set<id> ids = new Set<Id>();
  for(Contact con : Trigger.New)
  {
      ids.add(con.id);
  }
  
  List<Task> taskstoDelete = [select id,Type,Whoid from Task where whoId In :ids];
  List<Task> taskstoUpdate = new List<Task>();
  List<Task> taskstoDelete1 = new List<Task>();
  for(Contact con:Trigger.new)
  {
   if(con.LeadSource == 'Web')
   {
     task = new Task();
     task.OwnerId = UserInfo.getUserId();
     task.Subject = 'Email';
     task.Priority = 'Normal';
     task.Status = 'In  Progress';
     task.WhoId = con.id;
     taskstoUpdate.add(task);
    }
    if(con.LeadSource == 'Phone Inquiry')
    {
      taskstoDelete1.addAll(taskstoDelete);
    }
    }
    insert taskstoUpdate;
    delete taskstoDelete1;
}