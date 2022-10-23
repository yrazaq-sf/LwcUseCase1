/**
 * @File               : MovieTriggerHandler_Test
 * @Description        : Test class for MovieTriggerHandler
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
public class MovieTriggerHandler_Test {

    @testsetup
    static void testsetup() {
        insert TestFactory.movie();
    }

    @isTest
    static void onInsert_Test() {
        // start test
        Test.startTest();
        insert TestFactory.movie();
        Test.stopTest();
        // Asserting
        // No assert needed since the buisness logic of Trigger is tested from HelperClass
    }

    @isTest
    static void onUpdate_Test() {
        // Getting data
        List<Movie__c> movies = [SELECT Id FROM Movie__c];
        // Start test
        Test.startTest();
        update movies;
        Test.stopTest();
        // Asserting
        // No assert needed since the buisness logic of Trigger is tested from HelperClass
    }

    @isTest
    static void onDelete_Test() {
        // Getting data
        List<Movie__c> movies = [SELECT Id FROM Movie__c];
        // Start test
        Test.startTest();
        delete movies;
        Test.stopTest();
        // Asserting
        // No assert needed since the buisness logic of Trigger is tested from HelperClass
    }

    @isTest
    static void onUndelete_Test() {
        // Getting data
        List<Movie__c> movies = [SELECT Id FROM Movie__c];
        delete movies;
        // Start test
        Test.startTest();
        undelete movies;
        Test.stopTest();
        // Asserting
        // No assert needed since the buisness logic of Trigger is tested from HelperClass
    }
}