/**
 * @File               : MovieTriggerHandler
 * @Description        : Trigger Handler for Trigger on Movie__c Object
 * @Author             : Yassine RAZAQ (yrazaq@salesforce.com)
 * @Group              :
 * @Last_Modified_On   : 20/10/2022
 * @Modification_Log   :
 *======================================================================================
 * Ver         Date                           Author                  Modification
 *======================================================================================
 * 1.0      20/10/2022                   Yassine RAZAQ               Initial version
 **/
public class MovieTriggerHandler extends TriggerHandler {
    private static Map<Id, Actor__c> relatedActors;

    private Map<Id, Movie__c> newMovies;
    private Map<Id, Movie__c> oldMovies;

    public MovieTriggerHandler() {
        this.newMovies = (Map<Id, Movie__c>) Trigger.newMap;
        this.oldMovies = (Map<Id, Movie__c>) Trigger.oldMap;
    }

    public override void beforeDelete() {
        /**
        * @Description: The related actors are retrieved in beforeDelete instead of afterDelete because
        * the related MovieActor__c (junction) records will be already deleted while still needed
        * to find the related Actors
        **/
        relatedActors = MovieHelper.getRelatedActors(this.oldMovies);
    }
    public override void afterDelete() {
        ActorHelper.updateNbrOfMovies(relatedActors);
    }
    public override void afterUndelete() {
        MovieHelper.updateRelatedActorsNumberOfMovies(this.newMovies);
    }

}