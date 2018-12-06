public class Week22{
	public List<Products_Table_Page__c> getProducts(){
        List<Products_Table_Page__c> products = [SELECT Id, Name, Image__c, Title__c, Description__c, Cost__c FROM Products_Table_Page__c];
        return products;
    }

    /*public PageReference setParams(){
        PageReference page = Page.week22;

        page.getParameters().put('id=', a);
        page.setRedirect(true);
        return page;
    }*/
   /* public PageReference redirectToDescription(){
        PageReference actFuncPage = Page.Description;
        actFuncPage.setRedirect(true);
        return actFuncPage;
    }*/

    /*public List<Products_Table_Page__c> products{get; set;}

    public Week22(String id){
        products=Database.query('SELECT Id, Name, Image__c, Title__c, Description__c, Cost__c '+'FROM Products_Table_Page__c ' + 'WHERE Id =' +id);
        image = products[1];
        //return products;
            }*/
   /* public List<Products_Table_Page__c> getProductsWithId(){
        List<Products_Table_Page__c> products = [SELECT Name, Image__c, Title__c, Description__c, Cost__c FROM Products_Table_Page__c WHERE Id='a036F00001CjhKE'];//Database.query('SELECT Id, Name, Image__c, Title__c, Description__c, Cost__c '+'FROM Products_Table_Page__c ' + 'WHERE Id =' +'a036F00001CjhKE');
        return products;
    }*/

}