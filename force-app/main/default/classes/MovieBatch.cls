/**
 * @File               : MovieSchedulerHelper
 * @Description        : Usefull methods for Movie Scheduler
 * @Author             : Yassine RAZAQ (yrazaq@salesforce.com)
 * @Group              : 
 * @Last Modified On   : 24/10/2022
 * @Modification Log   :
 *======================================================================================
 * Ver         Date                           Author                  Modification
 *======================================================================================
 * 1.0      24/10/2022                   Yassine RAZAQ               Initial version
 **/

public with sharing class MovieBatch implements Database.Batchable<Movie__c>{

    public Iterable<Movie__c> start(Database.BatchableContext bc) {
        // collect the batches of records or objects to be passed to execute
        // returning only movies already released. (ReleaseDate__c <= TODAY)
        return [SELECT Id FROM Movie__c WHERE ReleaseDate__c <= TODAY];
    }

    /*******************************************************************************************************
    * @author: Yassine RAZAQ (yrazaq@salesforce.com)
    * @description: Updates the IsReleased bool field of all movies based on ReleaseDate
    * @param bc: Batchable context having details about the JOB
    * @param records: records fetched in start method
    */
    public void execute(Database.BatchableContext bc, List<Movie__c> records){
        // process each batch of records
        for(Movie__c movie : records){
            movie.IsReleased__c = true;
        }
        // updating movies
        TriggerHandler.bypass('MovieTriggerHandler');
        update records;
        TriggerHandler.clearBypass('MovieTriggerHandler');
    }

    public void finish(Database.BatchableContext bc){
        // execute any post-processing operations
    }
}