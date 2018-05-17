({
			allowDrop: function(component, event, helper) {
	        event.preventDefault();
	    },

	    onDrop: function(component, event, helper) {
	        event.preventDefault();
	        var OnDroppingEvent = component.getEvent('OnDroppingEvent');
	        OnDroppingEvent.setParams({
	            'index': component.get('v.index'),
	            'item': JSON.parse(event.dataTransfer.getData('text'))
	        });
	        OnDroppingEvent.fire();

	    },
})