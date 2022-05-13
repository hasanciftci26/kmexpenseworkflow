//Prepare rule service payload
var ruleServiceApproverId = "0efa90cc0ab14cb9b5850a9ef5e8541d";
var    ruleServiceRevision = "Trial"
var    ruleServiceVersion = "000001000000000000";

$.context.ruleBody = {
    "RuleServiceId": ruleServiceApproverId,
    "RuleServiceRevision": ruleServiceRevision,
    "RuleServiceVersion": ruleServiceVersion,
    "Vocabulary": [{
        "ProjectofKmExpense": {
            "ProjectID": $.context.projectID
        }
    }]
};

$.context.odataEndpoint = "/vehicle-management/KilometerExpenses(" + $.context.expenseID + ")?$expand=toProjects,toPersonnels";
