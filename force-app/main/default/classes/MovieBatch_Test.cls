/**
 * @File               : MovieSchedulerHelper_Test
 * @Description        : Test class for MovieSchedulerHelper.
 * @Author             : Yassine RAZAQ (yrazaq@salesforce.com)
 * @Group              : 
 * @Last_Modified_On   : 24/10/2022
 * @Modification_Log   :
 *======================================================================================
 * Ver         Date                           Author                  Modification
 *======================================================================================
 * 1.0      24/10/2022                   Yassine RAZAQ               Initial version
 **/
@IsTest
public class MovieBatch_Test {

    @TestSetup
    static void testsetup() {
        Movie__c movie1 = TestFactory.movie();
        movie1.ReleaseDate__c = Date.today().addDays(-1); // yesterday
        movie1.IsReleased__c = false; // yesterday
        insert movie1;
    }

    @IsTest
    static void method_Test() {
        // start Test
        Test.startTest();
        Id batchId = Database.executeBatch(new MovieBatch());
        Test.stopTest();
        // assertion
        System.assertEquals(1, 1);
        // retriving updated movies
        List<Movie__c> updatedMovies = [SELECT IsReleased__c FROM Movie__c];
        // The first movie has a release date of yesterday. So IsReleased should be true
        System.assertEquals(updatedMovies[0].IsReleased__c, true);
    }

}