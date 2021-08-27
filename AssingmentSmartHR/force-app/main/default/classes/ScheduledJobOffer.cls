global class ScheduledJobOffer implements Schedulable{
    global void execute(SchedulableContext ctx){
        List<Contact> contacts = new List<Contact>();
        Set<ID> applicantIds = new Set<ID>();
        List<Offer__c> offers = [SELECT Status__c, Applicant__c FROM Offer__c WHERE Status__c = 'Accepted' LIMIT 200];
        for(Offer__c offer : offers){
            applicantIds.add(offer.Applicant__c);
        }
        List<Applicant__c> applicants = [SELECT Id, Applicant_Name__c, Phone__c, Email__c FROM Applicant__c WHERE Id in :applicantIds];
        for(Applicant__c applicant : applicants){
            Contact newContact = new Contact();
            String[] fullName = applicant.Applicant_Name__c.Split(' ');
            newContact.FirstName = fullName[0];            
            newContact.LastName = fullName[1];
            newContact.Phone = applicant.Phone__c;
            newContact.Email = applicant.Email__c;
            contacts.Add(newContact);
        }
        upsert contacts;
    }
}