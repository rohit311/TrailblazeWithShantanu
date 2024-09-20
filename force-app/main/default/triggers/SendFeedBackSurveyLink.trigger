trigger SendFeedBackSurveyLink on Training_Schedule__c (After update) {
    Set<Id> candidateIds = new set<Id>();
    for(Training_Schedule__c tsNew : Trigger.new){
        if(Trigger.oldMap.get(tsNew.Id).Status__c != tsNew.Status__c && tsNew.Status__c == 'Completed'){
            candidateIds.add(tsNew.Candidate__c);
        }
    }
    Messaging.SingleEmailMessage[] emails = new List<Messaging.SingleEmailMessage>();
    for(Candidate__c ca : [SELECT Id, Name, Email__c FROM Candidate__c WHERE Id IN :candidateIds]){
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        
        String[] toAddresses = new String[] { ca.Email__c };
        email.setToAddresses(toAddresses);
        email.setSubject('Feedback Need For Coaching Academy');
    }
}