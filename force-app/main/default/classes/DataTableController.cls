public with sharing class DataTableController {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts(){
        return [select Id, Name, Rating from Account];
    }

    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountsByName(String name){
        name = '%' + name + '%';
        return [select Id, Name, Rating,Website from Account where Name like :name];
    }

    @AuraEnabled
    public static void setAccountRating(String rating){
        List<Account> accounts = [select Id, Rating from Account];
        for(Account account: accounts){
            account.Rating = rating;
        }

        update accounts;
    }

    public class CompositeData{
        @AuraEnabled
        public List<Account> accounts;

        @AuraEnabled
        public List<Contact> contacts;
        
    }

    @AuraEnabled(cacheable=true)
    public static CompositeData getCompositeData(){
        CompositeData cd = new CompositeData();
        cd.accounts = [select Id, Name, Rating from Account];
        cd.contacts = [select Id, Name, Phone from Contact];

        return cd;
    }
}