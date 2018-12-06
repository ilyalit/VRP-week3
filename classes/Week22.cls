public class Week22{
	public List<Products_Table_Page__c> getProducts(){
        List<Products_Table_Page__c> products = [SELECT Id, Name, Image__c, Title__c, Description__c, Cost__c FROM Products_Table_Page__c];
        return products;
    }
}