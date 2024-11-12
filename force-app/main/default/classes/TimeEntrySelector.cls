public with sharing class TimeEntrySelector extends fflib_sobjectSelector {
    public TimeEntrySelector() {

    }
    public List<Schema.SObjectField> getSObjectFieldList(){
        return new List<Schema.SObjectField>{
            Time_Entry__c.Id,
            Time_Entry__c.CreatedById,
            Time_Entry__c.Name,
            Time_Entry__c.Start__c,
            Time_Entry__c.End__c
        };
    }

    public Schema.SObjectType getSObjectType(){
        return Time_Entry__c.SObjectType;
    }

    public List<Time_Entry__c> getTimeEntryList(){
        fflib_queryFactory queryFactory = new fflib_queryFactory(Time_Entry__c.SObjectType);
        queryFactory.selectFields(this.getSObjectFieldList());
        queryFactory.setCondition('CreatedById = :UserInfo.getUserId()');
        System.debug(queryFactory.toSOQL());
        return (List<Time_Entry__c>) Database.query(queryFactory.toSOQL());
    }
       
    
}