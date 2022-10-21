/**
 * @File Name          : ActorTrigger.cls
 * @Description        : Trigger on Actor__c Object
 * @Author             : Yassine RAZAQ (yrazaq@salesforce.com)
 * @Group              : Undefined
 * @Modification Log   :
 *======================================================================================
 * Ver         Date                           Author                  Modification
 *======================================================================================
 * 1.0      18-OCT-2022                    RAZAQ Yassine	        Init with support for Trigger framework
**/

trigger ActorTrigger on Actor__c (after insert, after update, before delete, after delete, after undelete) {
        new ActorTriggerHandler().run();
}