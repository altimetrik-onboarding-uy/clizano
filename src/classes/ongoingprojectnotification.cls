global class ongoingprojectnotification implements Schedulable {
	global void execute(SchedulableContext sc) {
		OngoingProjects b = new OngoingProjects();
		database.executebatch(b);
	}
}