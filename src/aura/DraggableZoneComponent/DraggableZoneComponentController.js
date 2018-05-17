({
	doInit : function(component, event, helper) {
		//obtaining and setting itemsList
					var recordId= component.get("v.recordId");
					var action = component.get("c.getSteps");
				action.setParams({'recordId':recordId});
				action.setCallback(this, function(data) {
				 if (data.getState() === "SUCCESS") {
						component.set("v.itemslist", data.getReturnValue());

					}
				else {
							
							}
					});
				$A.enqueueAction(action);
//obtaining and setting order
			var action2 = component.get("c.getOrder");
			action2.setParams({'recordId':recordId});
			action2.setCallback(this, function(data) {
			 if (data.getState() === "SUCCESS") {
					component.set("v.order", data.getReturnValue());
//sorting stuff code
					  console.log("Asignated order ");
						var order= component.get("v.order");
						var itemslist= component.get("v.itemslist");

						if(order==null || order==''){
							order='';
							for (var i = 0; i < itemslist.length; i++) {
								order+=itemslist[i].Id;//ItS ID,
								if(i!=itemslist.length-1)
										order+=',';
							}

						}
						var arrayOrder=order.split(',');
						var orderList=[];
						for (var i = 0; i < arrayOrder.length; i++) {
							orderList[i]=(itemslist.find(a=>a.Id==arrayOrder[i]));
						}
						component.set("v.itemslist", orderList);
						component.set("v.order", order);
				}
			else {

						}
				});
			$A.enqueueAction(action2);
			},

			jsLoaded: function(component,event,helper){
				var j$ = jQuery.noConflict();
				j$("#sortable").sortable({
				  update: function( event, ui ) {
						//lets build this order:
				var sortedIDs = j$( "#sortable" ).sortable( "toArray" );

				//calling function to setOrder.. setStepOrder
				var recordId= component.get("v.recordId");
				component.set("v.order", sortedIDs);

				var action = component.get("c.setStepOrder");
				action.setParams({'recordId':recordId,'order':sortedIDs.toString()});

			action.setCallback(this, function(data) {
			 if (data.getState() === "SUCCESS") {

				}
			else {

						}
				});
			$A.enqueueAction(action);
					}
				});
				j$("#sortable").disableSelection();
	      // j$(document).ready(function(){
				// 	//document ready code
	      // });

			},
			createRecord : function (component, event, helper) {
    var createRecordEvent = $A.get("e.force:createRecord");
    createRecordEvent.setParams({
        "entityApiName": "Testcase_Step__c"
    });
    createRecordEvent.fire();
}

})