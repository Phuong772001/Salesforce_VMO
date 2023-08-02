private with sharing class VMO_CaseTriggerHandler {
  private static Boolean checkActive = true;
  private static void onBeforeUpdate(List<Case> newList, Map<Id, Case> oldMap) {
    for (Case c : newList) {
      if (c.Subject != oldMap.get(c.Id).Subject && checkActive) {
        VMO_CommonConstant.UPDATE_SUBJECT_FALSE;
      }
    }
  }
  private static void onBeforeInsert(List<Case> newList) {
    for (Case c : newList) {
      if (String.isBlank(c.Subject)) {
        VMO_CommonConstant.SUBEJCT_FALSE;
      }
    }
  }
  private static void onAfterUpdate(List<Case> newList, Map<Id, Case> oldMap) {
  }
  private static void onAfterInsert(List<Case> newList) {
    completeSubject(newList);
  }
  private static void completeSubject(List<Case> targetRecs) {
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
