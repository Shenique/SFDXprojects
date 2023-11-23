trigger AccountTrigger on Account (before update) {

    //     Set<Id> accountIdsToDeactivate = new Set<Id>();

    //     static Boolean isExecuting = false;

    //     if (!isExecuting) {
    //         isExecuting = true;

    //     for (Account account : Trigger.new) {
    //         Account oldAccount = Trigger.oldMap.get(account.Id);
    
    //         if (account.Activated__c == false && oldAccount.Activated__c == true) {
    //             accountIdsToDeactivate.add(account.Id);
    //         }
    //     }
    
    //     if (!accountIdsToDeactivate.isEmpty()) {
    //         List<Account> accountsToUpdate = new List<Account>();
    //         List<Contact> contactsToUpdate = new List<Contact>();
    
    //         for (Id accountId : accountIdsToDeactivate) {
    //             contactsToUpdate.addAll([SELECT Id, Activated__c FROM Contact WHERE AccountId = :accountId AND Activated__c = true]);
    //         }
    
    //         for (Contact contact : contactsToUpdate) {
    //             contact.Activated__c = false;
    //         }
    
    //         if (!contactsToUpdate.isEmpty()) {
    //             update contactsToUpdate;
    //         }
    //     }

    //     isExecuting = false;
    // }
}


