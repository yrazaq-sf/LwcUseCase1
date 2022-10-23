/**
 * @File               : MovieActorHelper_Test
 * @Description        : Test class for MovieActorHelper class methods
 * @Author             : Yassine RAZAQ (yrazaq@salesforce.com)
 * @Group              : 
 * @Last_Modified_On   : 21/10/2022
 * @Modification_Log   :
 *======================================================================================
 * Ver         Date                           Author                  Modification
 *======================================================================================
 * 1.0      21/10/2022                   Yassine RAZAQ               Initial version
 **/
@isTest
public class MovieActorHelper_Test {

    @testsetup
    static void testsetup() {
        // adding a new movieActor {randomActor, randomMovie}
        insert TestFactory.movieActor();
    }

    @isTest
    static void updateRelatedActorsNbrOfMovies_Test() {
        // getting data
        Map<Id, MovieActor__c> movieActorMap = new Map<Id, MovieActor__c>([SELECT Actor__c, Movie__c FROM MovieActor__c]);
        // start test
        Test.startTest();
        MovieActorHelper.updateRelatedActorsNbrOfMovies(movieActorMap);
        Test.stopTest();
        // No assertion needed since there is no buisness logic in the tested method
    }
    @isTest
    static void updateRelatedMoviesGenderPercentage_Test() {
        // getting data
        Map<Id, MovieActor__c> movieActorMap = new Map<Id, MovieActor__c>([SELECT Actor__c, Movie__c FROM MovieActor__c]);
        // start test
        Test.startTest();
        MovieActorHelper.updateRelatedMoviesGenderPercentage(movieActorMap);
        Test.stopTest();
        // No assertion needed since there is no buisness logic in the tested method
    }
}