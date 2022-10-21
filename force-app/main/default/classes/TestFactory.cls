/**
 * @File               : TestFactory
 * @Description        : Data factory for Test classes
 * @Author             : Yassine RAZAQ (yrazaq@salesforce.com)
 * @Group              : 
 * @Last_Modified_On   : 20/10/2022
 * @Modification_Log   :
 *======================================================================================
 * Ver         Date                           Author                  Modification
 *======================================================================================
 * 1.0      20/10/2022                   Yassine RAZAQ               Initial version
 **/
@IsTest
public class TestFactory {

    // movies

    @IsTest public static Movie__c movie(){
        Movie__c record = new Movie__c();
        record.Category__c = 'Horror';
        record.ReleaseDate__c = Date.today();
        return record;
    }

    // actors

    @IsTest public static Actor__c actor(){
        Actor__c record = new Actor__c();
        return record;
    }

    // movieActors

    @IsTest public static MovieActor__c movieActor(){
        Movie__c relatedMovie = movie();
        insert relatedMovie;

        Actor__c relatedActor = actor();
        insert relatedActor;

        MovieActor__c record = new MovieActor__c();
        record.Movie__c = relatedMovie.Id;
        record.Actor__c = relatedActor.Id;
        return record;
    }

// Test all methods
    @IsTest public static void test_all(){
        insert TestFactory.movie();
        insert TestFactory.actor();
        insert TestFactory.movieActor();
    }
}