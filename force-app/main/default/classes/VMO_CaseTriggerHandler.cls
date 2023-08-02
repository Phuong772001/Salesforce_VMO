public with sharing class VMO_CaseTriggerHandler {
  private static Boolean checkActive = true;
  public static void onBeforeUpdate(List<Case> newList, Map<Id, Case> oldMap) {
    for (Case c : newList) {
      if (c.Subject != oldMap.get(c.Id).Subject && checkActive) {
        c.addError(VMO_CommonConstant.UPDATE_SUBJECT_FALSE);
      }
    }
  }
  public static void onBeforeInsert(List<Case> newList) {
    for (Case c : newList) {
      if (String.isBlank(c.Subject)) {
        c.addError(VMO_CommonConstant.SUBEJCT_FALSE);
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
    checkActive = false;
    update casesToUpdate;
  }
}
