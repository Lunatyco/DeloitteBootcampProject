trigger DraftToPresentedMail on Offer__c (before update) {
    if(Trigger.isUpdate && Trigger.isBefore){
        for(Offer__c offer : Trigger.new){            
            if(Trigger.oldMap.get(offer.Id).Status__c =='Draft' && offer.Status__c=='Presented' ){
                Applicant__c applicant = [SELECT Applicant_Name__c, Email__c FROM Applicant__c WHERE Id =:offer.Applicant__c LIMIT 1];
                Application__c application = [SELECT Job_Posting__c FROM Application__c WHERE Id =:offer.Application__c LIMIT 1];
                Job_Posting__c jobPosting = [SELECT Name, Job_Description__c FROM Job_Posting__c WHERE Id =:application.Job_Posting__c LIMIT 1];
                User user = [SELECT Name FROM User WHERE Id =:offer.HR_Advisor__c LIMIT 1];                
                String mailToSend = 'Dear ' + applicant.Applicant_Name__c + ' you have been presented with the opportunity of being hired for this job ' + jobPosting.Name; 
                mailToSend += ' wich consist in ' + jobPosting.Job_Description__c + ' salary ' + offer.Salary__c;
                mailToSend += '. We expect to you to confirm your interest on this offer. \nBest Regards \n' + user.Name;
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                String[] toAddresses = new String[] {applicant.Email__c};
                mail.setToAddresses(toAddresses);
                mail.setSubject('Test Subject');                
                mail.setPlainTextBody(mailToSend);
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
            }
        }
    }
}