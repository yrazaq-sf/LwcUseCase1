/**
 * @File               : ActorHelper_Test
 * @Description        : Test class for ActorHelper class methods
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
public class ActorHelper_Test {

    @testsetup
    static void testsetup() {
        // adding movies
        Movie__c movie1 = TestFactory.movie();
        Movie__c movie2 = TestFactory.movie();
        Movie__c movie3 = TestFactory.movie();
        insert new List<Movie__c>{movie1, movie2, movie3};
        // adding actors
        Actor__c actor1 = TestFactory.actor();
        Actor__c actor2 = TestFactory.actor();
        insert new List<Actor__c>{actor1, actor2};
        // adding movieActors:
        // ---> Actor1 acted in movie1
        MovieActor__c movieActor1 = new MovieActor__c(Actor__c=actor1.Id, Movie__c=movie1.Id);
        // ---> Actor2 acted in movie1 and movie2
        MovieActor__c movieActor2 = new MovieActor__c(Actor__c=actor2.Id, Movie__c=movie1.Id);
        MovieActor__c movieActor3 = new MovieActor__c(Actor__c=actor2.Id, Movie__c=movie2.Id);
        insert new List<MovieActor__c>{movieActor1, movieActor2, movieActor3};


    }
    @isTest
    static void updateRelatedMoviesGenderPercentage_Test() {
        // getting data
        Map<Id, Actor__c> actorsMap = new Map<Id, Actor__c>([SELECT Id FROM Actor__c LIMIT 2]);
        // start test
        Test.startTest();
        ActorHelper.updateRelatedMoviesGenderPercentage(actorsMap);
        Test.stopTest();
        // No assertion needed since this method is used only to call other methods.
    }

    @isTest
    static void updateNbrOfMovies_Test() {
        // getting data
        // actor1 should be related to one movie
        // actor2 should be related to two movies
        Map<Id, Actor__c> actorsMap = new Map<Id, Actor__c>([SELECT Id FROM Actor__c LIMIT 2]);
        // start test
        Test.startTest();
        ActorHelper.updateNbrOfMovies(actorsMap);
        Test.stopTest();
        // Asserting
        List<Actor__c> newActorsList = [SELECT NumberOfMovies__c FROM Actor__c];
        System.assertEquals(newActorsList[0].NumberOfMovies__c, 1);
        System.assertEquals(newActorsList[1].NumberOfMovies__c, 2);
    }

    @isTest
    static void getRelatedMovies_Test() {
        // getting data
        Map<Id, Actor__c> actorsMap = new Map<Id, Actor__c>([SELECT Id FROM Actor__c LIMIT 1]);
        // start test
        Test.startTest();
        Map<Id, Movie__c> relatedMovies = ActorHelper.getRelatedMovies(actorsMap);
        Test.stopTest();
        // Asserting
        List<MovieActor__c> relatedMovieActors = [SELECT Actor__c, Movie__c FROM MovieActor__c WHERE Actor__c IN  :actorsMap.keySet()];
        System.assert(relatedMovies.size()>0);
        for (MovieActor__c relatedMovieActor : relatedMovieActors){
            System.assertEquals(relatedMovieActor.Movie__c, relatedMovies.values()[0].Id);
        }
    }
}