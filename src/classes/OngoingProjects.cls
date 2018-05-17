global class OngoingProjects implements Database.Batchable<sObject> {
	global OngoingProjects() {

	}

	global Database.QueryLocator start(Database.BatchableContext BC) {
		  String type='Ongoing';
		return Database.getQueryLocator([SELECT Id,Alias,Email FROM User where Id in (Select OwnerId from Project__c Where Status__c = :type)]);
	}

   	global void execute(Database.BatchableContext BC, List<User> ownerlist) {
//list to store each ongoing projects owner
			List<Project__c> projectlistAux=new List<Project__c>();
	//list to store every single mail that we want to send
				Messaging.SingleEmailMessage[] messages =   new List<Messaging.SingleEmailMessage> {};
//list with all Ongoing projects
			List<Project__c> projectlist=[Select Id, Name, OwnerId,Description__c, Status__c,
 		 (Select Id From Test_Cases__r) From Project__c Where Status__c = 'Ongoing'];
			for(Integer i = 0; i < ownerlist.size(); i++){
					for(Integer j = 0; j < projectlist.size(); j++){
								if (ownerlist[i].Id==projectlist[j].OwnerId){
									projectlistAux.Add(projectlist[j]);
								}
					}
				if(projectlistAux.size()>=1){
					Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
					//address and owner info on  ownerlist[i] and then
					message.toAddresses = new list<String>{ownerlist[i].Email};
					message.optOutPolicy = 'FILTER';
						//generic Headers..
					message.subject = 'Your daily Projects Summary - ' + date.today();
					message.plainTextBody = 'Hello dear ' + ownerlist[i].Alias + '. Here you are some useful info about Ongoing Projects that you own: ';

						for(Integer k = 0; k < projectlistAux.size(); k++){
							message.plainTextBody+= projectlistAux[k].Name + ':' +  '\n' ;
							message.plainTextBody+='Project Status: ' +projectlistAux[k].Status__c  +  '\n' ;
							message.plainTextBody+='Test Cases Amount: ' +projectlistAux[k].Test_Cases__r.size()  +  '\n' ;
							message.plainTextBody+='\n' ;
							message.plainTextBody+='\n' ;
					   	message.plainTextBody+='\n' ;
						}
							//Add email to LIST.
						messages.add(message);
					}
			}
			//send email list
			Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
			if (results[0].success) {
			 System.debug('The Ongoing Projects Summary was sent successfully.');
	 			} else {
				System.debug('The Ongoing Projects Summary failed to send: ' + results[0].errors[0].message);
			}
	}

	global void finish(Database.BatchableContext BC) {

	}

}