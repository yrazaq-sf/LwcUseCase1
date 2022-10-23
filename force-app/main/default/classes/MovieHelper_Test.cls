/**
 * @File               : MovieHelper_Test
 * @Description        : Test class for MovieHelper class methods
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
public class MovieHelper_Test {

    @testsetup
    static void testsetup() {
        // adding movies
        Movie__c movie1 =  TestFactory.movie();
        Movie__c movie2 =  TestFactory.movie();
        insert new List<Movie__c>{movie1, movie2};
        // adding actors
        Actor__c actor1 = TestFactory.actor();
        actor1.Gender__c = 'Male';
        Actor__c actor2 = TestFactory.actor();
        actor2.Gender__c = 'FeMale';
        insert new List<Actor__c>{actor1, actor2};
        // adding movieActors
        MovieActor__c movieActor1 = new MovieActor__c(Movie__c=movie1.Id, Actor__c=actor1.Id);
        MovieActor__c movieActor2 = new MovieActor__c(Movie__c=movie1.Id, Actor__c=actor2.Id);
        insert new List<MovieActor__c>{movieActor1, movieActor2};

    }

    @IsTest
    static void updateRelatedActorsNumberOfMovies_Test(){
        // getting data
        Map<Id, Movie__c> moviesMap = new Map<Id, Movie__c>([SELECT Id FROM Movie__c]);
        // start test
        Test.startTest();
        MovieHelper.updateRelatedActorsNumberOfMovies(moviesMap);
        Test.stopTest();
        // Asserting
        // No assertion needed since there is no buisness logic in the tested method
    }

    @isTest
    static void getRelatedActors_Test() {
        // getting data
        Map<Id, Movie__c> moviesMap = new Map<Id, Movie__c>([SELECT Id FROM Movie__c LIMIT 1]);
        // start test
        Test.startTest();
        Map<Id, Actor__c> relatedActors =  MovieHelper.getRelatedActors(moviesMap);
        Test.stopTest();
        // Asserting
        // The retrived movie has 2 actor. The returned map size should be 2
        System.assertEquals(relatedActors.values().size(), 2);
    }

    @IsTest
    static void updateGenderPercentage_Test(){
        // getting data
        Map<Id, Movie__c> moviesMap = new Map<Id, Movie__c>([SELECT Id FROM Movie__c]);
        // start test
        Test.startTest();
        MovieHelper.updateGenderPercentage(moviesMap);
        Test.stopTest();

        // Asserting
        // Retreiving the movie
        List<Movie__c> updatedMovies = [SELECT MaleActorsPercentage__c, FemaleActorsPercentage__c FROM Movie__c];
        // The first movie has 2 actor {1 male + 1 female}.
        // So the MalePercentage should be updated to 50%.
        // And the FemalePercentage should be updated to 50%
        System.assertEquals(updatedMovies[0].FemaleActorsPercentage__c, 50);
        System.assertEquals(updatedMovies[0].MaleActorsPercentage__c, 50);
        // The second movie has no actors. So both rates should be 0%
        System.assertEquals(updatedMovies[1].FemaleActorsPercentage__c, 0);
        System.assertEquals(updatedMovies[1].MaleActorsPercentage__c, 0);
    }
}