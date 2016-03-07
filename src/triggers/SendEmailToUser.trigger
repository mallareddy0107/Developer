trigger SendEmailToUser on Account (before update,after insert, after update) {

if(Trigger.isBefore){
if(Trigger.isUpdate){ 

//helper class for single email but bulk messages
HelperContactTrigger.sendEmail(trigger.newMap,trigger.oldMap);
}
}
}