public with sharing class ProjectController {

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
	return item;
	}
	@AuraEnabled
 	public static List<Testcase_Step__c> getSteps(String recordId) {
 		 return [Select Id, Name, Description__c, Expected_result__c
 		 From Testcase_Step__c Where Test_Case__r.Id =: recordId];
 	}
	@AuraEnabled
 	public static String getOrder(String recordId){
		Test_Case__c item=[Select Id, order_step__c From Test_Case__c Where Test_Case__c.Id =: recordId limit 1];
		return item.order_step__c;
	}
	@AuraEnabled
	public static void setStepOrder(String recordId, String order){
		Test_Case__c item= [Select Id From Test_Case__c Where Test_Case__c.Id =: recordId limit 1];
		item.order_step__c=order;
		upsert item;
	 	}
}