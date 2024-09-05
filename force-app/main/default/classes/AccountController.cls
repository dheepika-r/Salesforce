public with sharing class AccountController {

    @AuraEnabled
    public static Account checkAccountByWebsite(String website) {
        // Query to check if an account with the given website exists
        Account existingAccount = [SELECT Id, Name, Website FROM Account WHERE Website = :website LIMIT 1];
        
        // Return the existing account or null if not found
        return existingAccount;
    }
}