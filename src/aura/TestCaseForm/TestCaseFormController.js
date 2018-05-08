({
	handleSaveRecord: function(component, event, helper) {
		var testcase=	component.get("v.testcase");
	var action = component.get("c.upsertTestCase");
	console.log("escribe lo k tiene:");
	console.log(testcase);
	action.setParams({
						"item": testcase
				});
				action.setCallback(this, function(response){
						var state = response.getState();
						if (state === "SUCCESS") {
							 console.log("Se ha editado/insertado correctamente el testcase: " + testcase.Name);
							 console.log("trigger an update for other components listen this change");
							///trigger an update for other components listen this change.
							var updateListTC = $A.get("e.c:updateListTC");
							   updateListTC.fire();
								 	//if not work refresh list.. refresh page
							  //$A.get('e.force:refreshView').fire();
						}
						else{
						var a=action.getError();
							console.log(a[0].message);
						}
				});
$A.enqueueAction(action);
component.set("v.showForm",false);
},
			handleUpdateTestCase: function(component, event, helper){
				  var tc = event.getParam("testcase");
					component.set("v.testcase",tc);
					component.set("v.showForm",true);

			 },
			 hideForm:function(component, event, helper){
 				 component.set("v.showForm",false);
 			 }
})
