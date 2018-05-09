({
	createTestCase : function(component, event, helper) {
		var project= component.get("v.Project");
		var testcase={
		'Project__c':project.Id,
		'Title__c': '',
		'User_story__c': '',
		'Preconditions__c': '',
		'Description__c': ''}
		var prepareFormEvent = $A.get("e.c:prepareFormEvent");
       prepareFormEvent.setParams({ "testcase": testcase });
       prepareFormEvent.fire();
	}

})
