global class CreateFriendRecords
{
  List<MyFriends__c> friendsList=new List<MyFriends__c>();
  public void createRecords()
  {
   system.debug('Hi this is from createRecords');
   for(integer i=0;i<=125;i++)
   {
     MyFriends__c friend=new MyFriends__c();
     friend.FName__c='vijay';
     friend.LName__c='patel'+ i;
     friendsList.add(friend);    
   }
   upsert friendsList;
   }
 }