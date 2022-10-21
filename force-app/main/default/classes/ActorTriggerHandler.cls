/**
 * Created by yrazaq on 18/10/2022.
 */

public with sharing class ActorTriggerHandler extends TriggerHandler {
    private Map<Id, Actor__c> newActorsMap;
    private Map<Id, Actor__c> oldActorsMap;
    private static Map<Id, Movie__c> relatedMovies;

    public ActorTriggerHandler() {
        this.newActorsMap = (Map<Id, Actor__c>) Trigger.newMap;
        this.oldActorsMap = (Map<Id, Actor__c>) Trigger.oldMap;
    }
    public override void beforeDelete() {
        /**
        * @Description: The related movies are retrieved in beforeDelete instead of afterDelete because
        * the related MovieActor__c (junction) records will be already deleted while still needed
        * to find the related Movie
        **/
        relatedMovies = ActorHelper.getRelatedMovies(this.oldActorsMap);
    }
    public override void afterDelete() {
        // relatedMovies variable should be filled before deletion
        MovieHelper.updateGenderPercentage(relatedMovies);
    }
    public override void afterUndelete() {
        ActorHelper.updateRelatedMoviesGenderPercentage(this.newActorsMap);
    }
}