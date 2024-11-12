trigger TimeEntryTrigger on Time_Entry__c (before insert) {

    fflib_sobjectDomain.triggerHandler(TimeEntryTriggerHandler.class);
} 