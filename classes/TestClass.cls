/**
 * Created by Илья on 03.12.2018.
 */
@isTest
public with sharing class TestClass {
    @isTest public static void getProductsWithIdTest(){
        description s = new description();
        List<Products_Table_Page__c> fromDescription = s.getProductsWithId();
        List<Products_Table_Page__c> OurProd = [SELECT Id, Name, Image__c, Title__c, Description__c, Cost__c, Units_Available__c FROM Products_Table_Page__c WHERE Id = :ApexPages.currentPage().getParameters().get('Id')];
        System.assertEquals(OurProd,fromDescription);
    }
    @isTest public static void saveTestInvalidLastName(){
        description w = new description();
        w.ourLastName = '';
        PageReference result = w.save();
        System.assertEquals(null,result);

    }
    @testSetup static void setup() {
        // Create common test accounts
        List<Products_Table_Page__c> testProducts = new List<Products_Table_Page__c>();
        testProducts.add(new Products_Table_Page__c(Name = 'TestProd', Units_Available__c=10, Unit_Price__c=100));
        insert testProducts;
        List<Contact> testContacts = new List<Contact>();
        for(Integer i=0;i<10;i++) {
            testContacts.add(new Contact(FirstName = 'TestName'+i, LastName = 'TestLastName'+i, Email = 'testemail'+i+'@mail.com'));
        }

        insert testContacts;

    }


@isTest public static void saveTestInvalidAmounts(){
    description x = new description();
    x.amounts = 50000;
    Products_Table_Page__c products = [SELECT Id FROM Products_Table_Page__c WHERE Name='TestProd' LIMIT 1];
    ApexPages.currentPage().getParameters().put('id', products.Id);
    PageReference results = x.save();
    System.assertEquals(null,results);
    }
    @isTest public static void saveTestValidAmountsInvaliEmail(){
        description x = new description();
        x.amounts = 5;
        x.ourLastName = 'TestLastName11';
        x.ourFirstName = 'TestName11';
        x.ourEmail = 'testemail11@mail.com';
        Products_Table_Page__c products = [SELECT Id FROM Products_Table_Page__c WHERE Name='TestProd' LIMIT 1];
        ApexPages.currentPage().getParameters().put('id', products.Id);
        PageReference results = x.save();
        Products_Table_Page__c productsAfterUpdate = [SELECT Units_Available__c FROM Products_Table_Page__c WHERE Name='TestProd' LIMIT 1];
        System.assertEquals(5,productsAfterUpdate.Units_Available__c);
        Contact insertedContact = [SELECT FirstName, LastName, Email FROM Contact WHERE Email='testemail11@mail.com' LIMIT 1];
        System.assertEquals('testemail11@mail.com',insertedContact.Email);
        System.assertEquals('TestLastName11',insertedContact.LastName);
        System.assertEquals('TestName11',insertedContact.FirstName);
    }
    @isTest public static void saveTestValidAmountsValiEmail(){
        description x = new description();
        x.amounts = 5;
        x.ourLastName = 'NormalLastName';
        x.ourFirstName = 'NormalFirstName';
        x.ourEmail = 'testemail9@mail.com';
        Products_Table_Page__c products = [SELECT Id FROM Products_Table_Page__c WHERE Name='TestProd' LIMIT 1];
        ApexPages.currentPage().getParameters().put('id', products.Id);
        PageReference results = x.save();
        Products_Table_Page__c productsAfterUpdate = [SELECT Units_Available__c FROM Products_Table_Page__c WHERE Name='TestProd' LIMIT 1];
        Contact insertedContact = [SELECT FirstName, LastName, Email FROM Contact WHERE Email='testemail9@mail.com' LIMIT 1];
        System.assertEquals('NormalLastName',insertedContact.LastName);
        System.assertEquals('NormalFirstName',insertedContact.FirstName);
        //list
        /*List<Order_Table__c> ourHopes =
        Order_Table__c insertedOrder = [SELECT Products_Page__c, Units__c, Order_Amount__c, Contact__c FROM Order_Table__c];
        System.assertEquals();*/
    }
    @isTest public static void calculateTest(){
        description d = new description();
        d.amounts = 5;
        Products_Table_Page__c products = [SELECT Id FROM Products_Table_Page__c WHERE Name='TestProd' LIMIT 1];
        ApexPages.currentPage().getParameters().put('id', products.Id);

        d.calculate();


        System.assertEquals(5000,d.TotalAmounts);
    }

}