/**
 * @File               : 
 * @Description        : 
 * @Author             : Yassine RAZAQ (yrazaq@salesforce.com)
 * @Group              : 
 * @Last Modified On   : 20/10/2022
 * @Modification Log   :
 *======================================================================================
 * Ver         Date                           Author                  Modification
 *======================================================================================
 * 1.0      20/10/2022                   Yassine RAZAQ               Initial version
 **/
trigger MovieTrigger on Movie__c (before delete, after insert, after update, after delete, after undelete) {
    new MovieTriggerHandler().run();
}