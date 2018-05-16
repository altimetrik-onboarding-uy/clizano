({
	handleSaveRecord: function(component, event, helper) {
		var testcase=	component.get("v.testcase");
	var action = component.get("c.upsertTestCase");
	action.setParams({
						"item": testcase
				});
				action.setCallback(this, function(response){
						var state = response.getState();
						if (state === "SUCCESS") {
							 console.log("trigger an update for other components listen this change");
							///trigger an update for other components listen this change.
							var updateListTC = $A.get("e.c:updateListTC");
								updateListTC.setParams({"testcase": testcase});
							   updateListTC.fire();
								 	//if not work refresh list.. refresh page
							  //$A.get('e.force:refreshView').fire();
						}
				});
$A.enqueueAction(action);
component.set("v.showForm",false);
},
			handleUpdateTestCase: function(component, event, helper){
				  var tc = event.getParam("testcase");
					var project=	component.get("v.project");
					if(tc.Project__c==project.Id){
						component.set("v.testcase",tc);
						component.set("v.showForm",true);
					}else{
							component.set("v.showForm",false);
					}
			 },
			 hideForm:function(component, event, helper){
				 var tc = event.getParam("testcase");
				var project=	component.get("v.project");
				if(tc.Project__c==project.Id){
 				 component.set("v.showForm",false);
 			 }
		 }
})