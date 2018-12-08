trigger ProdtToWarhs on Products_Table_Page__c (before insert) {
    
        Handler_ProdtToWarhs.handlerBeforeInsert(Trigger.new);
      
}
/*List<Product_Table_Page__c> allProducts = [SELECT ALL FROM Product_Table_Page__c];
        List<Warehouse__c> allWarehouse = [SELECT ALL FROM Warehouse__c];*/
        
        //List<Warehouse__c> warhs = [SELECT ALL FROM Warehouse WHERE Product_Table_Page__c.Added_Date__c >= Warehouse__c.Period_Start__c AND Warehouse__c.Period_End__c >=Product_Table_Page__c.Added_Date__c]