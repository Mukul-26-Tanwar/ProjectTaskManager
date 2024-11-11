public with sharing class TaskSelector extends fflib_sobjectSelector{
    public TaskSelector() {

    }

    public List<Schema.SObjectField> getSObjectFieldList(){
        return new List<Schema.SObjectField>{
            Task__c.Id,
            Task__c.CreatedById,
            Task__c.Name
        };
    }
    

    public Schema.SObjectType getSObjectType(){
        return Task__c.SObjectType;
    }

    public List<Task__c> fetchTasks(Id projectId){
        String query = String.format('SELECT {0} FROM {1}  WHERE Id IN (SELECT ParentId FROM Task__Share) AND Project__c = :projectId', 
                    new List<String>{
                        getFieldListString(),
                        getSObjectName()
                    });
        List<Task__c> tasks = Database.query(query);
        return tasks;
    }
}