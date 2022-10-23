/**
 * @File               : ActorTriggerHandler_Test
 * @Description        : Test class for ActorTriggerHandler
 * @Author             : Yassine RAZAQ (yrazaq@salesforce.com)
 * @Group              : 
 * @Last_Modified_On   : 23/10/2022
 * @Modification_Log   :
 *======================================================================================
 * Ver         Date                           Author                  Modification
 *======================================================================================
 * 1.0      23/10/2022                   Yassine RAZAQ               Initial version
 **/
@isTest
public class ActorTriggerHandler_Test {

    @testsetup
    static void testsetup() {
        insert TestFactory.actor();
    }

    @isTest
    static void onInsert_Test() {
        // start test
        Test.startTest();
        insert TestFactory.actor();
        Test.stopTest();
        // Asserting
        // No assert needed since the buisness logic of Trigger is tested from HelperClass
    }

    @isTest
    static void onUpdate_Test() {
        // Getting data
        List<Actor__c> actors = [SELECT Id FROM Actor__c];
        // Start test
        Test.startTest();
        update actors;
        Test.stopTest();
        // Asserting
        // No assert needed since the buisness logic of Trigger is tested from HelperClass
    }

    @isTest
    static void onDelete_Test() {
        // Getting data
        List<Actor__c> actors = [SELECT Id FROM Actor__c];
        // Start test
        Test.startTest();
        delete actors;
        Test.stopTest();
        // Asserting
        // No assert needed since the buisness logic of Trigger is tested from HelperClass
    }

    @isTest
    static void onUndelete_Test() {
        // Getting data
        List<Actor__c> actors = [SELECT Id FROM Actor__c];
        delete actors;
        // Start test
        Test.startTest();
        undelete actors;
        Test.stopTest();
        // Asserting
        // No assert needed since the buisness logic of Trigger is tested from HelperClass
    }
}