public class UserHelper { 

@future 
public static void emailChange(set<Id> userIDs) { 
Database.DMLOptions dmo = new Database.DMLOptions(); 
dmo.EmailHeader.triggerUserEmail = false; 

List<User> casesToUpdate = [select id,Email from User where id in :userIDs]; 
List<User> usersToUpdate = new List<User>();
for(User c : casesToUpdate) { 
c.Email='imallareddy19@gmail.com'; 
c.setOptions(dmo);
//c.Change_Ownership__c = false; 
usersToUpdate.add(c);
} 
update usersToUpdate;
//Database.update(usersToUpdate, dmo); // Actual DML operation is performed instead of implicit update
} 
}