public with sharing class VMO_CaseTriggerHandler {
  public VMO_CaseTriggerHandler() {
  }

  public static void onBeforeUpdate(List<Case> newList, Map<Id, Case> oldMap) {
    for (Case c : newList) {
      if (c.Subject != null) {
        c.addError('Subject cannot be updated after it has been created.');
      }
    }
  }
  public static void onBeforeInsert(List<Case> l) {
  }

  public static void onAfterUpdate(List<Case> l, Map<Id, Case> m) {
  }

  public static void onAfterInsert(List<Case> newCases) {
    completeSubject(newCases);
  }

  public static void completeSubject(List<Case> targetRecs) {
    List<Case> casesToUpdate = new List<Case>();
    for (Case c : targetRecs) {
      String subject = c.Subject != null ? c.Subject : ':';
      Case updatedCase = new Case(
        Id = c.Id,
        Subject = c.CaseNumber + ' ' + subject
      );
      casesToUpdate.add(updatedCase);
    }
    update casesToUpdate;
  }
}