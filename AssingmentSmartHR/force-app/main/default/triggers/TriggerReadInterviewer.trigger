trigger TriggerReadInterviewer on Application__c (after insert, after update) {
    if((Trigger.isInsert || Trigger.isUpdate) && Trigger.isAfter){
        ID userId = UserInfo.getUserId();
        for(ID ApplicationID : Trigger.newMap.keySet()){
            if(Trigger.oldMap.get(ApplicationId).Interviewer_1__c != Trigger.newMap.get(ApplicationId).Interviewer_1__c){   
                ApplicationSharing.manualShareRead(ApplicationId, Trigger.newMap.get(ApplicationId).Interviewer_1__c);
                ApplicationSharing.hidePermission(ApplicationId, Trigger.oldMap.get(ApplicationId).Interviewer_1__c);
            }
            if(Trigger.oldMap.get(ApplicationId).Interviewer_2__c != Trigger.newMap.get(ApplicationId).Interviewer_2__c){
                ApplicationSharing.manualShareRead(ApplicationId, Trigger.newMap.get(ApplicationId).Interviewer_2__c);
                ApplicationSharing.hidePermission(ApplicationId, Trigger.oldMap.get(ApplicationId).Interviewer_2__c);
            }
        }
    }
}