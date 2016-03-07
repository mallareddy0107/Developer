global class ScheduledSendMail Implements Schedulable
            {
             List<Lead> ListOfMailids=new List<Lead>();
             String[] mailIds=new List<String>();
             //system.debug('hi malla');
             /* ListOfMailids=[select Email from Lead];
             system.debug('hi reddy');
             system.debug('mail ids are:'+ListOfMailids);*/
             global void execute(SchedulableContext sc)
                {
                        system.debug('hi mallareddy');
                        sendmail();
                }
             public void sendmail()
                {
                        ListOfMailids=[select Email from Lead limit 10];
                        system.debug('hi reddy');
                        system.debug('mail ids are:'+ListOfMailids);
                        for(integer i=0;i<ListOfMailids.size();i++)
                        {
                           system.debug('mail ids size is'+ListOfMailids.size());
                           // mailIds.add(ListOfMailids[i].Email);
                            mailIds.add(ListOfMailids[i].Email);
                        }
                        system.debug('mail ids in string are:'+mailIds);
                        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                        string [] toaddress= New string[]{'mallareddy0107@gmail.com'};
                        email.setSubject('Testing Apex Scheduler-Subject');
                        email.setPlainTextBody('Testing Apex Scheduler-Body');
                        email.setToAddresses(toaddress);
                        email.setBccAddresses(mailIds);
                        Messaging.sendEmail(New Messaging.SingleEmailMessage[]{email});
                }
            }