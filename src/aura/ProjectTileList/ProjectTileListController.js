({
	myAction : function(component, event, helper) {
		var action = component.get("c.getProjects");

action.setCallback(this, function(data) {
	 if (data.getState() === "SUCCESS") {
    	component.set("v.ProjectList", data.getReturnValue());
		}
	else {
				 console.log("Failed with state: " + data.getState());
				}
		});
$A.enqueueAction(action);
	}
})
