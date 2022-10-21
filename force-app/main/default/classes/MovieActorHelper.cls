/**
 * @File               : ActorHelper
 * @Description        : Provides usefull methods related to MovieActor__c records
 * @Author             : Yassine RAZAQ (yrazaq@salesforce.com)
 * @Group              :
 * @Last_Modified_On   : 18/10/2022
 * @Modification_Log   :
 *======================================================================================
 * Ver         Date                           Author                  Modification
 *======================================================================================
 * 1.0      18/10/2022                      Yassine RAZAQ             Initial version
 **/
public with sharing class MovieActorHelper {
    /*******************************************************************************************************
    * @author: Yassine RAZAQ (yrazaq@salesforce.com)
    * @description: Method used to update gender Percentages of the related movies.
    * Useful in DML of MovieActor__c records since it impacts the gender percentage of a movie record.
    * @param movieActorsMap : A map of targeted MovieActor__c records
    */
    public static void updateRelatedMoviesGenderPercentage(Map<Id, MovieActor__c> movieActorsMap) {
        Map<Id, Movie__c> moviesToUpdate = getRelatedMovies(movieActorsMap);
        MovieHelper.updateGenderPercentage(moviesToUpdate);
    }

    /*******************************************************************************************************
    * @author: Yassine RAZAQ (yrazaq@salesforce.com)
    * @description: Method used to update the number of movies of the related actors.
    * Useful in DML of MovieActor__c records since it impacts the numberOfMovies of an actor record.
    * @param movieActorsMap : A map of targeted MovieActor__c records
    */
    public static void updateRelatedActorsNbrOfMovies(Map<Id, MovieActor__c> movieActorsMap){
        Map<Id, Actor__c> actorsToUpdate = getRelatedActors(movieActorsMap);
        ActorHelper.updateNbrOfMovies(actorsToUpdate);
    }

    // ================================================================ \\
    // ======================== private methods ======================= \\
    // ================================================================ \\

    /*******************************************************************************************************
    * @author: Yassine RAZAQ (yrazaq@salesforce.com)
    * @description: Gets the Movies related to 1 or multiple MovieActor__c records
    * @param movieActorsMap: A map of targeted movieActor__c records
    * @return Map<Id, Movie__c>, a map of movies related to the MovieActor__c map passed in param
    */
    private static Map<Id, Movie__c> getRelatedMovies(Map<Id, MovieActor__c> movieActorsMap){
        Map<Id, Movie__c> relatedMovies = new Map<Id, Movie__c>();
        for (MovieActor__c movieActor : movieActorsMap.values()){
            Id movieId = movieActor.Movie__c;
            relatedMovies.put(movieId, new Movie__c(Id=movieId));
        }
        return relatedMovies;
    }

    /*******************************************************************************************************
    * @author: Yassine RAZAQ (yrazaq@salesforce.com)
    * @description: Gets the Actors related to 1 or multiple MovieActor__c records
    * @param movieActorsMap: A map of targeted movieActor__c records
    * @return Map<Id, Actor__c>, a map of Actors related MovieActor__c map passed in param
    */
    private static Map<Id, Actor__c> getRelatedActors(Map<Id, MovieActor__c> movieActorsMap){
        Map<Id, Actor__c> relatedActors = new Map<Id, Actor__c>();
        for (MovieActor__c movieActor : movieActorsMap.values()){
            Id actorId = movieActor.Actor__c;
            relatedActors.put(actorId, new Actor__c(Id=actorId));
        }
        return relatedActors;
    }
}