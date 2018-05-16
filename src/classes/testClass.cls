@isTest
private class testClass {

	@isTest static void test_method_getProjects() {
		Project__c a= new Project__c(Name='TEST',Status__c = 'Ongoing');
		insert a;
		for(Integer i = 0; i < 5; i++){
			Test_Case__c tc= new Test_Case__c(Title__c='TEST'+i ,Preconditions__c='NOTHING',Description__c='Description',User_story__c = 'www.someuserstorie.com',Project__c=a.Id);
			insert tc;
		}
		System.assertEquals(1,ProjectController.getProjects().size());
		// Implement test code System.assertEquals()
	}

	@isTest static void test_method_deleteTestCase() {
		Project__c p= new Project__c(Name='TEST1',Status__c = 'Ongoing');
		insert p;
		for(Integer i = 0; i < 5; i++){
			Test_Case__c tc= new Test_Case__c(Title__c='TEST'+i ,Preconditions__c='NOTHING',Description__c='Description',User_story__c = 'www.someuserstorie.com',Project__c=p.Id);
			insert tc;
		}
		List<Test_Case__c> a = [Select Id from Test_Case__c where Title__c = 'TEST0'];

		ProjectController.deleteTestCase(a[0]);
		List<Test_Case__c> listtc =[Select Id from Test_Case__c];
		System.assertEquals(4,listtc.size());

		// Implement test code
	}

	@isTest static void test_method_upsertTestCase() {
		Project__c p= new Project__c(Name='TEST1',Status__c = 'Ongoing');
		insert p;
		for(Integer i = 0; i < 5; i++){
			Test_Case__c tc= new Test_Case__c(Title__c='TEST'+i ,Preconditions__c='NOTHING',Description__c='Description',User_story__c = 'www.someuserstorie.com',Project__c=p.Id);
			insert tc;
		}
		List<Test_Case__c> a = [Select Id from Test_Case__c where Title__c = 'TEST0'];
		a[0].Title__c='A';
		a[0].Preconditions__c='A';
		a[0].Description__c='A';
		a[0].User_story__c='as.as.as';

		ProjectController.upsertTestCase(a[0]);
		List<Test_Case__c> listtc =[Select Id from Test_Case__c where Title__c= 'A' AND Description__c='A' and User_story__c='as.as.as'];
		System.assertEquals(1,listtc.size());

		// Implement test code
	}
	@isTest static void test_method_getSteps() {
		Project__c p= new Project__c(Name='TEST1',Status__c = 'Ongoing');
		insert p;
		Test_Case__c tc= new Test_Case__c(Title__c='TEST' ,Preconditions__c='NOTHING',Description__c='Description',User_story__c = 'www.someuserstorie.com',Project__c=p.Id);
			insert tc;
			List<Testcase_Step__c> tcs=new List<Testcase_Step__c> ();
			for(Integer j = 0; j < 5; j++){
				Testcase_Step__c tcss= new Testcase_Step__c(Description__c='Description'+j, Expected_result__c	 = 'good',Test_Case__c= tc.Id);
				tcs.add(tcss);
			}
			insert tcs;

		List<Test_Case__c> testcase = [Select Id from Test_Case__c where Title__c = 'TEST'];
		String recordId=testcase[0].Id;
		List<Testcase_Step__c>listtcs=ProjectController.getSteps(recordId);
		System.assertEquals(5,listtcs.size());

		// Implement test code
	}
	@isTest static void test_method_getOrder(){
		Project__c p= new Project__c(Name='TEST1',Status__c = 'Ongoing');
		insert p;
		Test_Case__c tc= new Test_Case__c(Title__c='TEST' ,order_step__c='a,b,c,1,2,3,4,5',Preconditions__c='NOTHING',Description__c='Description',User_story__c = 'www.someuserstorie.com',Project__c=p.Id);
		insert tc;
		System.assertEquals('a,b,c,1,2,3,4,5',ProjectController.getOrder(tc.Id));

	}
	@isTest static void test_method_setStepOrder(){
		Project__c p= new Project__c(Name='TEST1',Status__c = 'Ongoing');
		insert p;
		Test_Case__c tc= new Test_Case__c(Title__c='TEST' ,order_step__c='',Preconditions__c='NOTHING',Description__c='Description',User_story__c = 'www.someuserstorie.com',Project__c=p.Id);
		insert tc;
		ProjectController.setStepOrder(tc.Id,'a,b,c,1,2,3,4,5');
		System.assertEquals('a,b,c,1,2,3,4,5',ProjectController.getOrder(tc.Id));
	}






}