({
    handleDeleteRecord: function(component, event, helper) {
			var action = component.get("c.deleteTestCase");
			var testcase = component.get("v.TestCase");
			action.setParams({
		            "test": testcase
		        });
		        action.setCallback(this, function(response){
		            var state = response.getState();
		            if (state === "SUCCESS") {
                  ///trigger an update for other components listen this change.
                  var updateListTC = $A.get("e.c:updateListTC");
                     updateListTC.fire();
                      //if not work refresh list.. refresh page
                    //$A.get('e.force:refreshView').fire();
		            }
		        });
	$A.enqueueAction(action);
},
editTestCase2: function(component,event,helper){
  	var testcase = component.get("v.TestCase");
    var prepareFormEvent = $A.get("e.c:prepareFormEvent");
       prepareFormEvent.setParams({ "testcase": testcase });
       prepareFormEvent.fire();
}
})
