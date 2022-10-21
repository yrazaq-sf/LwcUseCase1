/**
 * @File               : ActorHelper
 * @Description        : Provides usefull methods related to Movie__c records
 * @Author             : Yassine RAZAQ (yrazaq@salesforce.com)
 * @Group              :
 * @Last_Modified_On   : 18/10/2022
 * @Modification_Log   :
 *======================================================================================
 * Ver         Date                           Author                  Modification
 *======================================================================================
 * 1.0      18/10/2022                      Yassine RAZAQ             Initial version
 **/
public with sharing class MovieHelper {

    /*******************************************************************************************************
    * @author: Yassine RAZAQ (yrazaq@salesforce.com)
    * @description: The method takes a map of Movies and updates 'Gender Percentage' fields based of the
    * number of males and females of this movie.
    * @param movies: Movies targeted to update their Gender percentages
    * @details:
    * =====================================================================================================
    * || To write readable bulikified code, the goal was to fill a map that contains the Id               ||
    * || of a Movie (in the key) and a List<Id> of the related actors (in the value) 'Map<Id, List<Id>>'. ||
    * || When this map is filled, it will be easier to calculate the number actors (males, females).      ||
    * || That will be possible by looping threw the movies and getting actor gender info using            ||
    * || actors.get(actorId).Gender__c                                                                    ||
    * =====================================================================================================
    */
    public static void updateGenderPercentage(Map<Id, Movie__c> movies) {
        List<Id> actorsIds = new List<Id>();
        Map<Id, List<Id>> movieActorsListMap = new Map<Id, List<Id>>();
        Map<Id, MovieActor__c> relatedMovieActors = new Map<ID, MovieActor__c>([SELECT Movie__c, Actor__c FROM MovieActor__c WHERE Movie__c IN :movies.keySet()]);
        // looping threw the related MovieActors to fill the movieActorsList map {key: Movie Id, value: List of acotrs Ids}
        for (MovieActor__c relatedMovieActor : relatedMovieActors.values()) {
            List<Id> actorsList = new List<Id>();
            if (movieActorsListMap.get(relatedMovieActor.Movie__c) == null) {
                actorsList.add(relatedMovieActor.Actor__c);
            } else {
                actorsList = movieActorsListMap.get(relatedMovieActor.Movie__c);
                actorsList.add(relatedMovieActor.Actor__c);
            }
            // populating the map of Ids
            movieActorsListMap.put(relatedMovieActor.Movie__c, actorsList);
            // storing actor Ids
            actorsIds.add(relatedMovieActor.Actor__c);
        }
        // getting all related actors
        Map<Id, Actor__c> allRelatedActors = new Map<ID, Actor__c>([SELECT Gender__c FROM Actor__c WHERE Id IN :actorsIds]);
        // looping threw movies to define gender percentages
        for (Id movieId : movies.keySet()) {
            // checking if movie has a MovieActor__c record
            if (movieActorsListMap.get(movieId) != null) {
                Integer nbrOfMales = 0;
                Integer nbrOfFemales = 0;
                // nbrOfActors always >0 because we are looping from the junction object (where Actor field is required)
                // nbrOfActors is a decimal because in apex Integer/Integer always equals 0
                Decimal nbrOfActors = movieActorsListMap.get(movieId).size();
                for (Id actorId : movieActorsListMap.get(movieId)) {
                    String gender = allRelatedActors.get(actorId).Gender__c;
                    nbrOfMales = (gender == 'Male') ? nbrOfMales + 1 : nbrOfMales;
                    nbrOfFemales = (gender == 'Female') ? nbrOfFemales + 1 : nbrOfFemales;
                }
                System.debug('@yassine: men: '+nbrOfMales+' || women: '+nbrOfFemales+' || all: '+nbrOfActors);
                System.debug('@yassine: men div: '+(nbrOfMales/nbrOfActors));
                movies.get(movieId).MaleActorsPercentage__c = ((nbrOfMales/nbrOfActors)*100).intValue();
                movies.get(movieId).FemaleActorsPercentage__c = ((nbrOfFemales/nbrOfActors)*100).intValue();
                System.debug('@yassine: men%: '+movies.get(movieId).MaleActorsPercentage__c+' || women%: '+movies.get(movieId).FemaleActorsPercentage__c+' || all: 100%');
            }else {
                movies.get(movieId).MaleActorsPercentage__c = 0;
                movies.get(movieId).FemaleActorsPercentage__c = 0;
            }
        }
        // updating movies (byPass movieTriggerHandler)
        TriggerHandler.bypass('MovieTriggerHandler');
        update movies.values();
        TriggerHandler.clearBypass('MovieTriggerHandler');
    }

    public static void updateRelatedActorsNumberOfMovies(Map<Id, Movie__c> movies){
        Map<Id, Actor__c> relatedActorsMap = getRelatedActors(movies);
        ActorHelper.updateNbrOfMovies(relatedActorsMap);
    }

    /*******************************************************************************************************
    * @author: Yassine RAZAQ (yrazaq@salesforce.com)
    * @description: Retreives related records from junction object MovieActor__c
    * @param moviesMap: Targeted movies
    * @return Map<Id, Actor__c> a map of related Actors
    */
    public static Map<Id, Actor__c> getRelatedActors(Map<Id, Movie__c> moviesMap) {
        Map<Id, Actor__c> relatedActors = new Map<Id, Actor__c>();
        List<MovieActor__c> movieActorsList = [SELECT Actor__c FROM MovieActor__c WHERE Movie__c IN :moviesMap.keySet()];
        for (MovieActor__c movieActor : movieActorsList) {
            Id actorId = movieActor.Actor__c;
            relatedActors.put(actorId, new Actor__c(Id =actorId ));
        }
        return relatedActors;
    }

}