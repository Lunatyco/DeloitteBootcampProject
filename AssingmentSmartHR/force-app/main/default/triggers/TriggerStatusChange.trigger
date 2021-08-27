trigger TriggerStatusChange on Application__c (after update) {
    if(Trigger.isUpdate && Trigger.isAfter){
        List<Offer__c> offers = new List<Offer__C>();
        for(Application__c application : Trigger.new){
            if(application.Status__c == 'Selected'){ 
                Offer__c newOffer = new Offer__c();
                newOffer.Application__c = application.Id;
                newOffer.Applicant__c = application.Applicant__c;
                newOffer.Salary__c = (application.Salary_Min__c + application.Salary_Max__c)/2; 
                newOffer.Status__c = 'Draft';
				newOffer.HR_Advisor__c = application.Recruitment_Advisor__c;
                offers.add(newOffer);
            }
        }
        insert offers;
    }
}