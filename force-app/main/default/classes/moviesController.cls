/**
 * Created by yrazaq on 3/10/2022.
 */

public with sharing class moviesController {
    /*******************************************************************************************************
    * @author: Yassine RAZAQ (yrazaq@salesforce.com)
    * @description: Method to retreive all movie records in the org
    * @return A list of movies
    */
    @AuraEnabled(Cacheable=true)
    public static List<Movie__c> getAllMovies() {
        List<Movie__c> results = [
                SELECT Id, Name, Category__c, Description__c, IsReleased__c,
                        MaleActorsPercentage__c, FemaleActorsPercentage__c, ImageUrl__c, ReleaseDate__c
                FROM Movie__c
        ];
        return results;
    }

    /*******************************************************************************************************
    * @author: Yassine RAZAQ (yrazaq@salesforce.com)
    * @description: Inserts and returns the movies in parameter
    * @param movies: Prefilled new movie instances.
    * @return The inserted movie records
    */
    @AuraEnabled
    public static List<Movie__c> insertMovies(List<Movie__c> movies) {
        insert movies;
        return movies;
    }

    /*******************************************************************************************************
    * @author: Yassine RAZAQ (yrazaq@salesforce.com)
    * @description: Inserts and returns the movieActors in parameter
    * @param movieActors: Prefilled new movieActor instances.
    * @return The inserted movieActor records
    */
    @AuraEnabled
    public static List<MovieActor__c> insertMovieActors(List<MovieActor__c> movieActors){
        insert movieActors;
        return movieActors;
    }
}