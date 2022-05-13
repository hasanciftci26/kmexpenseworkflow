$.context.updatePayload = {
    "status": $.usertasks.usertask1.last.decision == "Approve" ? "A" : "R"
};

$.context.updateEndpoint = "/vehicle-management/KilometerExpenses(" + $.context.expenseID + ")";
