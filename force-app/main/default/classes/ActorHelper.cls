/**
 * @File               : ActorHelper
 * @Description        : Provides usefull methods related to Actor__c records
 * @Author             : Yassine RAZAQ (yrazaq@salesforce.com)
 * @Group              :
 * @Last_Modified_On   : 18/10/2022
 * @Modification_Log   :
 *======================================================================================
 * Ver         Date                           Author                  Modification
 *======================================================================================
 * 1.0      18/10/2022                      Yassine RAZAQ             Initial version
 **/
public with sharing class ActorHelper {
    /*******************************************************************************************************
    * @AUTHOR : Yassine RAZAQ (yrazaq@salesforce.com)
    * @description: Retrieve related movies and updates their gender percentage fields
    * @param actorsMap: Map of Actors used to retrive related movies
    */
    public static void updateRelatedMoviesGenderPercentage(Map<Id, Actor__c> actorsMap) {
        Map<Id, Movie__c> moviesToUpdate = getRelatedMovies(actorsMap);
        MovieHelper.updateGenderPercentage(moviesToUpdate);
    }

    /*******************************************************************************************************
    * @author: Yassine RAZAQ (yrazaq@salesforce.com)
    * @description: Updates NumberOfMovies__c field by counting related movies from junction object
    * @param actorsMap: Map of Actors used to retrive related MovieActor__c records
    */
    public static void updateNbrOfMovies(Map<Id, Actor__c> actorsMap){
        List<MovieActor__c> movieActorsList = [SELECT Actor__c FROM MovieActor__c WHERE Actor__c IN :actorsMap.keySet()];
        for (Actor__c actor : actorsMap.values()){
            actor.NumberOfMovies__c = 0;
            for (MovieActor__c movieActor : movieActorsList){
                if(movieActor.Actor__c == actor.Id){
                    actor.NumberOfMovies__c++;
                }
            }
            System.debug('@yassine: '+actor.NumberOfMovies__c);
        }
        // updating actors records (byPass trigger)
        TriggerHandler.bypass('ActorTriggerHandler');
        update actorsMap.values();
        TriggerHandler.clearBypass('ActorTriggerHandler');

    }

    /*******************************************************************************************************
    * @author: Yassine RAZAQ (yrazaq@salesforce.com)
    * @description Retrieves a map of related movies from actorsMap
    * @param actorsMap: Map of Actors used to retrive related movies
    * @return a map of related Movies
    */
    public static Map<Id, Movie__c> getRelatedMovies(Map<Id, Actor__c> actorsMap){
        Map<Id, Movie__c> relatedMovies = new Map<Id, Movie__c>();
        List<MovieActor__c> movieActorsList = [SELECT Movie__c FROM MovieActor__c WHERE Actor__c IN :actorsMap.keySet()];
        for (MovieActor__c movieActor : movieActorsList) {
            Id movieId = movieActor.Movie__c;
            relatedMovies.put(movieId, new Movie__c(Id = movieId));
        }
        return relatedMovies;
    }
}