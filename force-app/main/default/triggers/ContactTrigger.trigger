trigger ContactTrigger on Contact (after update) {

    Set<Id> accountIdsToDeactivate = new Set<Id>();
    Set<Id> accountIdsToActivate = new Set<Id>();

    for (Contact contact : Trigger.new) {
        if (contact.Activated__c == false && Trigger.oldMap.get(contact.Id).Activated__c == true) {
            accountIdsToDeactivate.add(contact.AccountId);
        }
    }

    for (Contact contact : Trigger.new) {
        if (contact.Activated__c == true && Trigger.oldMap.get(contact.Id).Activated__c == false) {
            accountIdsToActivate.add(contact.AccountId);
        }
    }

    if (!accountIdsToDeactivate.isEmpty()) {
        List<Account> accountsToUpdate = new List<Account>();
        List<Contact> contactsToUpdate = new List<Contact>();

        for (Id accountId : accountIdsToDeactivate) {
            accountsToUpdate.add(new Account(Id = accountId, Activated__c = false));
            contactsToUpdate.addAll([SELECT Id, Activated__c FROM Contact WHERE AccountId = :accountId AND Activated__c = true]);
        }

        for (Contact contact : contactsToUpdate) {
            contact.Activated__c = false;
        }

        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }

        if (!contactsToUpdate.isEmpty()) {
            update contactsToUpdate;
        }

    } else if (!accountIdsToActivate.isEmpty()) {
        List<Account> accountsToUpdate = new List<Account>();
        List<Contact> contactsToUpdate = new List<Contact>();

        for (Id accountId : accountIdsToActivate) {
            accountsToUpdate.add(new Account(Id = accountId, Activated__c = true));
            contactsToUpdate.addAll([SELECT Id, Activated__c FROM Contact WHERE AccountId = :accountId AND Activated__c = false]);
        }

        for (Contact contact : contactsToUpdate) {
            contact.Activated__c = true;
        }

        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }

        if (!contactsToUpdate.isEmpty()) {
            update contactsToUpdate;
        }

    }

}
