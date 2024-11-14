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
        TimeEntrySelector timeEntrySelector = new TimeEntrySelector();
        

        Set<Date> startTimeEntryDate =new Set<Date>();
        Set<Date> endTimeEntryDate =new Set<Date>();
        for (Time_Entry__c timeEntryRec : (List<Time_Entry__c>) records) {
            startTimeEntryDate.add(timeEntryRec.Start__c.date());
            endTimeEntryDate.add(timeEntryRec.End__c.date());
        }

        List<Time_Entry__c> existTimeEntriesList = timeEntrySelector.getTimeEntryList(startTimeEntryDate,endTimeEntryDate);

        for(Time_Entry__c timeEntryRec : (List<Time_Entry__c>) records) {
            for(Time_Entry__c existTimeEntryRec: existTimeEntriesList) {
                if(existTimeEntryRec.Start__c <= timeEntryRec.Start__c && existTimeEntryRec.End__c >= timeEntryRec.Start__c) {
                    timeEntryRec.addError('You cannot create a time entry that overlaps with an existing one.');
                    system.debug('error: '+timeEntryRec.Start__c);
                }
                
            }
        }
           
    }
}