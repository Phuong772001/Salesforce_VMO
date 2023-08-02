public with sharing class VMO_CaseTriggerHandler {
  public static Boolean test = true;
  public VMO_CaseTriggerHandler() {
  }

  public static void onBeforeUpdate(List<Case> newList, Map<Id, Case> oldMap) {
    for (Case c : newList) {
      if (c.Subject != oldMap.get(c.Id).Subject && test) {
        c.addError('Cannot update the Subject field.');
      }
    }
  }

  public static void onBeforeInsert(List<Case> newList) {
    for (Case c : newList) {
      if (String.isBlank(c.Subject)) {
        c.addError('Please input Subject !');
      } else {
        String subject = c.Subject;
        c.Subject = c.CaseNumber + ' ' + subject;
      }
    }
  }

  public static void onAfterUpdate(List<Case> newList, Map<Id, Case> oldMap) {
  }

  public static void onAfterInsert(List<Case> newList) {
    completeSubject(newList);
  }

  public static void completeSubject(List<Case> targetRecs) {
    List<Case> casesToUpdate = new List<Case>();
    for (Case c : targetRecs) {
      Case updatedCase = new Case(
        Id = c.Id,
        Subject = c.CaseNumber + ' ' + c.Subject
      );
      casesToUpdate.add(updatedCase);
    }
    test = false;
    update casesToUpdate;
  }
}
