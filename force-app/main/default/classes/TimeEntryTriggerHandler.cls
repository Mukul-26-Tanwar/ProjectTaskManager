public with sharing class TimeEntryTriggerHandler extends fflib_sobjectDomain {
    public TimeEntryTriggerHandler(List<Time_Entry__c> records) {
        super(records);
    }
    
    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<SObject> records) {
            return new TimeEntryTriggerHandler(records);
        }
    }

    public override void onBeforeInsert() {
        // TimeEntryService.updateTimeEntryTotalTime(this.records);
        system.debug(records);    
    }
}