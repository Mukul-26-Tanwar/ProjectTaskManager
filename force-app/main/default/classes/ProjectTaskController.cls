public with sharing class ProjectTaskController {
    public ProjectTaskController() {

    }
    @AuraEnabled(cacheable=true)
    public static List<Project__c> fetchProjects(){
        ProjectTaskService projectTaskService = new ProjectTaskService();
        List<Project__c> projectList = projectTaskService.fetchProjects();
        return projectList;
    }

    @AuraEnabled(cacheable=true)
    public static List<Task__c> fetchTasks(Id projectId){
        ProjectTaskService projectTaskService = new ProjectTaskService();
        List<Task__c> projectList = projectTaskService.fetchTasks(projectId);
        return projectList;
    }
}