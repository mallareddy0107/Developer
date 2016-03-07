trigger PreventEmail on User (before update) {
    set<id> ids = new set<id>();
    if(System.isFuture())
    return;
    for ( User u : Trigger.New ) {
        
        system.debug('********'+u.username);
        ids.add(u.id);
        }
      system.debug('*******'+ids); 
      if(ids.size()>0){
          UserHelper.emailChange(ids);
      }
}