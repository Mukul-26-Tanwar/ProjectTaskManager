public with sharing class ProjectTaskService {
    
    public List<Project__c> fetchProjects(){
        ProjectSelector projectSelector = new ProjectSelector();
        List<Project__c> projectList = projectSelector.fetchProjects();
        return projectList;
    }

    public List<Task__c> fetchTasks(Id projectId){
        TaskSelector taskSelector = new TaskSelector();
        List<Task__c> taskList = taskSelector.fetchTasks(projectId);
        return taskList;
    }
}