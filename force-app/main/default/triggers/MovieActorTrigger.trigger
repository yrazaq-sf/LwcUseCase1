/**
 * @File Name          : MovieActorTrigger.cls
 * @Description        : Trigger on MovieActor__c Object
 * @Author             : Yassine RAZAQ
 * @Group              : Undefined
 * @Modification Log   :
 *======================================================================================
 * Ver         Date                           Author                  Modification
 *======================================================================================
 * 1.0      18-OCT-2022                    RAZAQ Yassine	        Init with support for Trigger framework
**/
trigger MovieActorTrigger on MovieActor__c (after insert, after update, after delete, after undelete) {
    new MovieActorTriggerHandler().run();
}