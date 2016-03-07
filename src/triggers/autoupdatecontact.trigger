trigger autoupdatecontact on Account (after insert) {

List<contact> conList = new List<contact>();
if(trigger.isInsert)
{
for(account a:trigger.new)
{
if(a.Name != '')
{
conList.add(new contact(lastname = a.Name,accountId = a.Id));
}
}
if(conList !=null)
{
insert conList;
}
}

}