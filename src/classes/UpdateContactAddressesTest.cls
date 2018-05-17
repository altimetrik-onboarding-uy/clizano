@isTest
private class UpdateContactAddressesTest {
    @testSetup
    static void setup() {
			Project__c a= new Project__c(Name='TEST CC',Status__c = 'Ongoing');
			insert a;
			for(Integer i = 0; i < 5; i++){
				Test_Case__c tc= new Test_Case__c(Title__c='TEST'+i ,Preconditions__c='NOTHING',Description__c='Description',User_story__c = 'www.someuserstorie.com',Project__c=a.Id);
				insert tc;
			}
    }

    static testmethod void test() {
        Test.startTest();
        OngoingProjects op = new OngoingProjects();
        Id batchId = Database.executeBatch(op);
        Test.stopTest();
        // after the testing stops, assert records were updated properly
        System.assertEquals(1, [SELECT COUNT() FROM AsyncApexJob WHERE ID = :batchId ]);
    }

}