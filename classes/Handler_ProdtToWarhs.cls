public with sharing class Handler_ProdtToWarhs {
    public static void handlerBeforeInsert(List<Products_Table_Page__c> newProducts){
        List<Warehouse__c> allWarehouse = [SELECT Id, Period_Start__c, Period_End__c FROM Warehouse__c];
        List<Warehouse__c> founded = new List<Warehouse__c>();
        /*Если изначально не задана дата добавления*/
        for(Products_Table_Page__c prodtableItems : newProducts){
            if (prodtableItems.Added_Date__c == null) {
                prodtableItems.Added_Date__c = Date.today();
            }
        }
        /*Поиск элементов Warehouse подходящих заданному условию*/
        for(Warehouse__c warehouseItem : allWarehouse){
            for(Products_Table_Page__c prodtableItems : newProducts){
                if(prodtableItems.Added_Date__c >= warehouseItem.Period_Start__c && warehouseItem.Period_End__c >=prodtableItems.Added_Date__c){
                    Warehouse__c war = new Warehouse__c(Id = warehouseItem.Id);
                    founded.add(war);
                }
            }
        }
        Set<Warehouse__c> newZapisSet = new Set<Warehouse__c>();
        List<Warehouse__c> newZapisList = new List<Warehouse__c>();
        List<Org_Configuration__c> periodTerm = [SELECT Period_Term__c FROM Org_Configuration__c];
        for(Products_Table_Page__c prodtableItems : newProducts) {
            /* Если нашли подходящие записи присваиваем Id первого найденного Warehouse*/
            if (!founded.isEmpty()) {
                prodtableItems.Warehouse__c = founded[0].Id;
            } else { /* Если ненашли подходящих записей то создаем ее Warehouse*/
                Warehouse__c newZap = new Warehouse__c(Name = 'Warehouse' + prodtableItems.Added_Date__c + ' ' + prodtableItems.Added_Date__c.addDays(Integer.valueOf(periodTerm[0].Period_Term__c)),
                        Period_Start__c = prodtableItems.Added_Date__c,
                        Period_End__c = prodtableItems.Added_Date__c.addDays(Integer.valueOf(periodTerm[0].Period_Term__c)));
                newZapisSet.add(newZap);
            }
        }
        if(founded.isEmpty()){
            newZapisList.addAll(newZapisSet);
            insert newZapisList;
            for(Products_Table_Page__c prodtableItems : newProducts){
                prodtableItems.Warehouse__c = newZapisList[0].Id;
            }
        }
    }
}