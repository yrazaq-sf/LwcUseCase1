/**
 * @File               : MovieScheduler_Test
 * @Description        : Test class for MovieScheduler.
 * @Author             : Yassine RAZAQ (yrazaq@salesforce.com)
 * @Group              : 
 * @Last_Modified_On   : 24/10/2022
 * @Modification_Log   :
 *======================================================================================
 * Ver         Date                           Author                  Modification
 *======================================================================================
 * 1.0      24/10/2022                   Yassine RAZAQ               Initial version
 **/
@isTest
public class MovieScheduler_Test {

    // Dummy CRON expression: every hour.
    // Because this is a test, job executes
    // immediately after Test.stopTest().
    public static String CRON_EXP = '0 0 * * * ?';

    @testsetup
    static void testsetup() {
        Movie__c movie1 = TestFactory.movie();
        movie1.ReleaseDate__c = Date.today().addDays(-1); // yesterday
        movie1.IsReleased__c = false; // yesterday
        insert movie1;
    }

    @IsTest
    static void testScheduledJob() {

        Test.startTest();
        // Schedule the test job (runs immediatly in test)
        String jobId = System.schedule('MovieScheduler',
                CRON_EXP,
                new MovieScheduler());
        Test.stopTest();
        // No need for assertion since this scheduler runs a batch method.
        // No immediate change to check
    }


}