/**
 * Created by yrazaq on 18/10/2022.
 */

public with sharing class MovieActorTriggerHandler extends TriggerHandler {
    private Map<Id, MovieActor__c> newMovieActorsMap;
    private Map<Id, MovieActor__c> oldMovieActorsMap;

    public MovieActorTriggerHandler() {
        this.newMovieActorsMap = (Map<Id, MovieActor__c>) Trigger.newMap;
        this.oldMovieActorsMap = (Map<Id, MovieActor__c>) Trigger.oldMap;
    }
    public override void afterInsert() {
        MovieActorHelper.updateRelatedMoviesGenderPercentage(this.newMovieActorsMap);
        MovieActorHelper.updateRelatedActorsNbrOfMovies(this.newMovieActorsMap);
    }
    public override void afterDelete() {
        MovieActorHelper.updateRelatedMoviesGenderPercentage(this.oldMovieActorsMap);
        MovieActorHelper.updateRelatedActorsNbrOfMovies(this.oldMovieActorsMap);
    }
    public override void afterUndelete() {
        MovieActorHelper.updateRelatedMoviesGenderPercentage(this.newMovieActorsMap);
        MovieActorHelper.updateRelatedActorsNbrOfMovies(this.newMovieActorsMap);
    }
}