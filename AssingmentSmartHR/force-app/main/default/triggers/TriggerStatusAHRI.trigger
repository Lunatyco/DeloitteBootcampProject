trigger TriggerStatusAHRI on Application__c (before update) {
    if(Trigger.isUpdate && Trigger.isBefore){
        ID userId = UserInfo.getUserId();
        for(Application__c application : Trigger.new){ 
            if(Trigger.oldMap.get(application.Id).Status__c != 'HR Interview' && application.Status__c == 'HR Interview'){
            application.Recruitment_Advisor__c = userId;
            }
        }
    }
}