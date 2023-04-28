/**
 * @File               : MovieScheduler
 * @Description        : Scheduler class for Movie records
 * @Author             : Yassine RAZAQ (yrazaq@salesforce.com)
 * @Group              : 
 * @Last Modified On   : 24/10/2022
 * @Modification Log   :
 *======================================================================================
 * Ver         Date                           Author                  Modification
 *======================================================================================
 * 1.0      24/10/2022                   Yassine RAZAQ               Initial version
 **/
public with sharing class MovieScheduler implements Schedulable {
    //  ========== to start job using apex ==========
    // MovieScheduler job = new MovieScheduler();
    // String job_cron = '20 30 8 10 2 ?';
    // String jobID = System.schedule('MovieScheduler', job_cron, job);
    public void execute(SchedulableContext ctx) {
        Id batchId = Database.executeBatch(new MovieBatch());
    }
}