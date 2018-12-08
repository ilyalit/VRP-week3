/**
 * Created by Илья on 06.12.2018.
 */

@IsTest
private class Tets_Handler_ProdtToWarhs {

    @IsTest static void testInsert100RecordsWithoutExistWarehouse() {
        List<Products_Table_Page__c> newProd = new List<Products_Table_Page__c>();
        for(Integer i=0; i<100; i++){
            Products_Table_Page__c prod = new Products_Table_Page__c(Name = 'TestProd'+i);
            newProd.add(prod);
        }
        insert new Org_Configuration__c(Period_Term__c = 7);
        insert newProd;

        List<Warehouse__c> wrhs = [SELECT Id FROM Warehouse__c];
        List<Products_Table_Page__c> allProducts = [SELECT Added_Date__c, Warehouse__c FROM Products_Table_Page__c WHERE Name LIKE '%TestProd%'];
        for(Products_Table_Page__c prod : allProducts){
            System.assertEquals(Date.today(), prod.Added_Date__c);
            System.assertEquals(wrhs[0].Id,prod.Warehouse__c);
            System.assertEquals(100, allProducts.size());
        }
    }

    @IsTest static void testInsert100RecordsWithExistWarehouse() {
        List<Products_Table_Page__c> newProd = new List<Products_Table_Page__c>();
        for(Integer i=0; i<100; i++){
            Products_Table_Page__c prod = new Products_Table_Page__c(Name = 'TestProd'+i);
            newProd.add(prod);
        }
        Date today = Date.today();
        insert new Warehouse__c(Period_Start__c = today, Period_End__c = today.addDays(7));
        insert new Org_Configuration__c(Period_Term__c = 7);
        insert newProd;

        List<Warehouse__c> wrhs = [SELECT Id FROM Warehouse__c];
        List<Products_Table_Page__c> allProducts = [SELECT Added_Date__c, Warehouse__c FROM Products_Table_Page__c WHERE Name LIKE '%TestProd%'];
        for(Products_Table_Page__c prod : allProducts){
            System.assertEquals(Date.today(), prod.Added_Date__c);
            System.assertEquals(wrhs[0].Id,prod.Warehouse__c);
            System.assertEquals(100, allProducts.size());
        }
    }

}