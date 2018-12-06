/**
 * Created by Илья on 28.11.2018.
 */

public with sharing class description {
    public String ourFirstName{get;set;}
    public String ourLastName{get;set;}
    public String ourEmail{get;set;}
    public Integer amounts{get;set;}
    public Double TotalAmounts{get;set;}
    public Decimal availableMINUSamounts{get;set;}
    /*кнопка сохранить данные в бд*/
    public PageReference save() {
        if(ourLastName==''){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Error: Invalid Last Name');
            ApexPages.addMessage(myMsg);
            return null;
        }
        List<Products_Table_Page__c> prod = getProductsWithId();
        availableMINUSamounts = prod[0].Units_Available__c - amounts;
        if(availableMINUSamounts >= 0){
            prod[0].Units_Available__c = availableMINUSamounts;
            update prod;
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.CONFIRM,'Congratulations! Your order is accepted.');
            ApexPages.addMessage(myMsg);
        }else{
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Error: Too Much Unit Count.');
            ApexPages.addMessage(myMsg);
            return null;
        }
        List<Contact> existCont = [SELECT Id, FirstName, LastName, Email FROM Contact WHERE Email = :ourEmail];
        System.debug('Founded contacts: ' +existCont);
        Contact newCont = new Contact(FirstName = ourFirstName, LastName = ourLastName, Email = ourEmail);
        String Id = '';
        if(existCont.isEmpty()){
            insert newCont;
            System.debug('Inserted');
            Id = newCont.Id;
        }else{
            for (Integer i = 0; i < existCont.size(); i++){
                existCont[i].FirstName = ourFirstName;
                existCont[i].LastName = ourLastName;
            }
            Id = existCont[0].Id;
            update existCont;
            System.debug('Updated');
        }
        Order_Table__c newOrder = new Order_Table__c(Products_Page__c = prod[0].Id, Units__c = amounts, Order_Amount__c = TotalAmounts, Contact__c = Id);
        insert newOrder;
        return null;
    }
    /*Динамический подсчет стоимости*/
    public void calculate(){
        List<Products_Table_Page__c> prod = getProductsWithId();
        TotalAmounts = amounts* prod[0].Cost__c;
    }
    /*получаем данные для страницы подробного описания товаров*/
    public List<Products_Table_Page__c> getProductsWithId(){
        List<Products_Table_Page__c> products = [SELECT Id, Name, Image__c, Title__c, Description__c, Cost__c, Units_Available__c FROM Products_Table_Page__c WHERE Id = :ApexPages.currentPage().getParameters().get('Id')];
        return products;
    }

}