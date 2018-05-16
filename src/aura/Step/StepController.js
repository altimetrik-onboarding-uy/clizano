({
	editRecord : function(component, event, helper) {
		var editRecordEvent = $A.get("e.force:editRecord");
     editRecordEvent.setParams({
          "recordId": component.get("v.item.Id")
    });
     editRecordEvent.fire();
		}
})