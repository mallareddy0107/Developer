trigger UpdateField on account (before insert,before update) {

 

account[] account1 = Trigger.new;
for (account b :account1){

String mutiselectpick=b.State__c;

// Update Multi-Select Picklist field

b.AllStates__c=mutiselectpick;


   }



}