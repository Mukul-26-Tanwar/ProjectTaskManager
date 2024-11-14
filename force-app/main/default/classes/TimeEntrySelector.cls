public with sharing class TimeEntrySelector extends fflib_sobjectSelector {
    public TimeEntrySelector() {

    }
    public List<Schema.SObjectField> getSObjectFieldList(){
        return new List<Schema.SObjectField>{
            Time_Entry__c.Id,
            Time_Entry__c.CreatedById,
            Time_Entry__c.Name,
            Time_Entry__c.Start__c,
            Time_Entry__c.End__c,
            Time_Entry__c.Description__c
        };
    }

    public Schema.SObjectType getSObjectType(){
        return Time_Entry__c.SObjectType;
    }

    public List<Time_Entry__c> getTimeEntryList(Set<Date> startTime, Set<Date> endTime){
        fflib_queryFactory queryFactory = new fflib_queryFactory(Time_Entry__c.SObjectType);
        queryFactory.selectFields(this.getSObjectFieldList());
        //why can't i use method in the setcondition method?
        Id userId = UserInfo.getUserId();
        queryFactory.setCondition('CreatedById = :userId');
        queryFactory.setCondition('DAY_ONLY(Start__c) IN :startTime OR DAY_ONLY(End__c) IN :endTime');
        System.debug(queryFactory.toSOQL());
        return (List<Time_Entry__c>) Database.query(queryFactory.toSOQL());
    }
       
    
}