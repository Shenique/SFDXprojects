trigger AccountTrigger on Account (after update) {

        Set<Id> accountIdsToDeactivate = new Set<Id>();
        Set<Id> accountIdsToActivate = new Set<Id>();

        for (Account account : Trigger.new) {
            Account oldAccount = Trigger.oldMap.get(account.Id);
            if (account.Activated__c == false && oldAccount.Activated__c == true) {
                accountIdsToDeactivate.add(account.Id);
            }
        }

        for (Account account : Trigger.new) {
            Account oldAccount = Trigger.oldMap.get(account.Id);
            if (account.Activated__c == true && oldAccount.Activated__c == false) {
                accountIdsToActivate.add(account.Id);
            }
        }
    
        if (!accountIdsToDeactivate.isEmpty()) {
            List<Account> accountsToUpdate = new List<Account>();
            List<Contact> contactsToUpdate = new List<Contact>();
    
            for (Id accountId : accountIdsToDeactivate) {
                contactsToUpdate.addAll([SELECT Id, Activated__c FROM Contact WHERE AccountId = :accountId AND Activated__c = true]);
            }
    
            for (Contact contact : contactsToUpdate) {
                contact.Activated__c = false;
            }
    
            if (contactsToUpdate.size() > 0) {
                update contactsToUpdate;
            }
        } else if (!accountIdsToActivate.isEmpty()) {
            List<Account> accountsToUpdate = new List<Account>();
            List<Contact> contactsToUpdate = new List<Contact>();
    
            for (Id accountId : accountIdsToActivate) {
                contactsToUpdate.addAll([SELECT Id, Activated__c FROM Contact WHERE AccountId = :accountId AND Activated__c = false]);
            }
    
            for (Contact contact : contactsToUpdate) {
                contact.Activated__c = true;
            }
    
            if (contactsToUpdate.size() > 0) {
                update contactsToUpdate;
            }
        }

}


