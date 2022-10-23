/**
 * @File               : MovieActorTriggerHandler_Test
 * @Description        : Test class for MovieActorTriggerHandler
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
public class MovieActorTriggerHandler_Test {

    @testsetup
    static void testsetup() {
        insert TestFactory.movieActor();
    }

    @isTest
    static void onInsert_Test() {
        // start test
        Test.startTest();
        insert TestFactory.movieActor();
        Test.stopTest();
        // Asserting
        // No assert needed since the buisness logic of Trigger is tested from HelperClass
    }

    @isTest
    static void onUpdate_Test() {
        // Getting data
        List<MovieActor__c> movieActors = [SELECT Id FROM MovieActor__c];
        // Start test
        Test.startTest();
        update movieActors;
        Test.stopTest();
        // Asserting
        // No assert needed since the buisness logic of Trigger is tested from HelperClass
    }

    @isTest
    static void onDelete_Test() {
        // Getting data
        List<MovieActor__c> movieActors = [SELECT Id FROM MovieActor__c];
        // Start test
        Test.startTest();
        delete movieActors;
        Test.stopTest();
        // Asserting
        // No assert needed since the buisness logic of Trigger is tested from HelperClass
    }

    @isTest
    static void onUndelete_Test() {
        // Getting data
        List<MovieActor__c> movieActors = [SELECT Id FROM MovieActor__c];
        delete movieActors;
        // Start test
        Test.startTest();
        undelete movieActors;
        Test.stopTest();
        // Asserting
        // No assert needed since the buisness logic of Trigger is tested from HelperClass
    }
}