/**
 * @File               : moviesController_Test
 * @Description        : Test class for moviesController methods
 * @Author             : Yassine RAZAQ (yrazaq@salesforce.com)
 * @Group              : 
 * @Last_Modified_On   : 23/10/2022
 * @Modification_Log   :
 *======================================================================================
 * Ver         Date                           Author                  Modification
 *======================================================================================
 * 1.0      23/10/2022                   Yassine RAZAQ               Initial version
 **/
@isTest
public class moviesController_Test {

    @testsetup
    static void testsetup() {
        insert TestFactory.movie();
    }

    @isTest
    static void getAlMovies_Test() {
        // getting data
        List<Movie__c> allMovies = [SELECT Id FROM Movie__c];
        // start test
        Test.startTest();
        List<Movie__c> returnedMovies = moviesController.getAllMovies();
        Test.stopTest();
        // Asserting 
        System.assertEquals(allMovies.size(), returnedMovies.size());
    }

    @isTest
    static void insertMovies_Test() {
        // setting data
        Movie__c newMovie = TestFactory.movie();
        newMovie.Name = 'New Movie';
        // start test
        Test.startTest();
        List<Movie__c> returnedMovies = moviesController.insertMovies(new List<Movie__c>{newMovie});
        Test.stopTest();
        // Asserting
        System.assertEquals(newMovie.Name, returnedMovies[0].Name);
        System.assertNotEquals(returnedMovies[0].Id, null);
    }

    @isTest
    static void insertMovieActors_Test() {
        // start test
        Test.startTest();
        List<MovieActor__c> returnedMovieActors = moviesController.insertMovieActors(new List<MovieActor__c>{TestFactory.movieActor()});
        Test.stopTest();
        // Asserting
        System.assertNotEquals(returnedMovieActors[0].Id, null);
    }
}