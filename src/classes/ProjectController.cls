
public with sharing class ProjectController {
	public ProjectController() {
	}
	@AuraEnabled
	public static List<Project__c> getProjects() {
	   return [Select Id, Name, Description__c, Status__c,
		 (Select Id,Name,Title__c,User_story__c,Preconditions__c,Description__c From Test_Cases__r ORDER BY LastModifiedDate DESC)
		 From Project__c Where Status__c = 'Ongoing'];
	}
	@AuraEnabled
	public static void deleteTestCase(Test_Case__c test) {
		delete test;
	}
	@AuraEnabled
	public static Test_Case__c upsertTestCase(Test_Case__c item) {
	upsert item;
	}
}
