@isTest
private class TestScheduledJobOffer {
    
    // Dummy CRON expression: midnight on March 15.
    // Because this is a test, job executes
    // immediately after Test.stopTest().
    public static String CRON_EXP = '0 0 0 15 3 ? 2022';
    static testmethod void testScheduledJob() {
        
        Applicant__c applicant = new Applicant__c();
        applicant.Applicant_Name__c = 'Jose Lopez';
        applicant.Email__c = 'asds@asdsad.cl';
        applicant.Phone__c = '991987333';        
        insert applicant;
       
        List<Offer__c> offers = new List<Offer__c>();
        for (Integer i=0; i<10; i++) {
            Offer__c offer = new Offer__c(
                Applicant__c = applicant.Id,                
                Name = 'Test ' + i,
                Status__c = 'Accepted'                
            );
            offers.add(offer);
        }
        insert offers;

        
        Test.startTest();
        String jobId = System.schedule('Nightly Job', CRON_EXP, new ScheduledJobOffer());
        Test.stopTest();
        
        System.assertEquals(offers.size(), 10, 'Offers Created');
        
    }
}