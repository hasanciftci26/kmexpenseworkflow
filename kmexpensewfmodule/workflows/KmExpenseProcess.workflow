{
	"contents": {
		"a7dca548-fda1-4c35-8bb9-2f5419542c41": {
			"classDefinition": "com.sap.bpm.wfs.Model",
			"id": "ndbs.wf.vehicle.kmexpenseprocess",
			"subject": "KmExpenseProcess",
			"name": "KmExpenseProcess",
			"documentation": "Workflow process of Km Expenses Approval",
			"lastIds": "62d7f4ed-4063-4c44-af8b-39050bd44926",
			"events": {
				"11a9b5ee-17c0-4159-9bbf-454dcfdcd5c3": {
					"name": "StartProcess"
				},
				"2798f4e7-bc42-4fad-a248-159095a2f40a": {
					"name": "EndProcess"
				}
			},
			"activities": {
				"b7f6fac5-cf5a-4ecf-83d7-a6778e0b2b61": {
					"name": "PrepareRuleandDataPayloads"
				},
				"5fd0c19b-1217-4098-917e-b90f280dab0d": {
					"name": "GetDataFromDatabase"
				},
				"1ddd9bd9-b1a5-4cd5-bccf-f42fe5467887": {
					"name": "DetermineApproverRuleService"
				},
				"bf9506ba-6365-41f0-a316-4e78271bb526": {
					"name": "KmExpenseApproval"
				},
				"cf2c7aa8-c574-496a-bbe8-17bcdafda2e6": {
					"name": "PrepareUpdatePayload"
				},
				"bc872a24-3b4c-4522-a439-ac2994134311": {
					"name": "UpdateStatus"
				}
			},
			"sequenceFlows": {
				"26cb0449-2533-4cbc-99a0-0e75853ba142": {
					"name": "SequenceFlow11"
				},
				"5df64202-094a-40a8-a9e6-9481fbaba4a9": {
					"name": "SequenceFlow12"
				},
				"7e004af2-14f9-4053-b267-fc15a12ff71d": {
					"name": "SequenceFlow13"
				},
				"a06ecc64-e12d-40ab-a434-6dc5a0f59cee": {
					"name": "SequenceFlow15"
				},
				"72cc685c-4552-4f3e-8e82-13c78bf0f087": {
					"name": "SequenceFlow16"
				},
				"9ede1505-4bc2-453d-9e45-8b0d7ece9eae": {
					"name": "SequenceFlow17"
				},
				"f44f61e6-3d9f-41a8-9603-8c791817a312": {
					"name": "SequenceFlow18"
				}
			},
			"diagrams": {
				"42fa7a2d-c526-4a02-b3ba-49b5168ba644": {}
			}
		},
		"11a9b5ee-17c0-4159-9bbf-454dcfdcd5c3": {
			"classDefinition": "com.sap.bpm.wfs.StartEvent",
			"id": "startevent1",
			"name": "StartProcess",
			"documentation": "This step starts the process of km expense",
			"sampleContextRefs": {
				"88cface9-d32f-4562-b536-9a1ced1f84cc": {}
			}
		},
		"2798f4e7-bc42-4fad-a248-159095a2f40a": {
			"classDefinition": "com.sap.bpm.wfs.EndEvent",
			"id": "endevent1",
			"name": "EndProcess",
			"documentation": "This step terminates the approval process.",
			"eventDefinitions": {
				"9c5e3d70-a186-4094-b932-2c8bbd7e7a3e": {}
			}
		},
		"b7f6fac5-cf5a-4ecf-83d7-a6778e0b2b61": {
			"classDefinition": "com.sap.bpm.wfs.ScriptTask",
			"reference": "/scripts/KmExpenseProcess/PreparePayloads.js",
			"id": "scripttask1",
			"name": "PrepareRuleandDataPayloads",
			"documentation": "This step prepares payload for Business Rule service and Km Expense OData payload."
		},
		"5fd0c19b-1217-4098-917e-b90f280dab0d": {
			"classDefinition": "com.sap.bpm.wfs.ServiceTask",
			"destination": "VehicleManagement",
			"path": "${context.odataEndpoint}",
			"httpMethod": "GET",
			"responseVariable": "${context.kmExpenseData}",
			"headers": [],
			"id": "servicetask2",
			"name": "GetDataFromDatabase",
			"documentation": "This step gets data of Km Expenses from database"
		},
		"1ddd9bd9-b1a5-4cd5-bccf-f42fe5467887": {
			"classDefinition": "com.sap.bpm.wfs.ServiceTask",
			"destination": "BUSINESS_RULES",
			"path": "/rest/v2/rule-services",
			"httpMethod": "POST",
			"requestVariable": "${context.ruleBody}",
			"responseVariable": "${context.approver}",
			"id": "servicetask3",
			"name": "DetermineApproverRuleService",
			"documentation": "This step determines the approver of process"
		},
		"bf9506ba-6365-41f0-a316-4e78271bb526": {
			"classDefinition": "com.sap.bpm.wfs.UserTask",
			"subject": "Km Expense Approval of Personnel: ${context.personnelNo}",
			"description": "Please take an action on Km Expense given below.",
			"priority": "MEDIUM",
			"isHiddenInLogForParticipant": false,
			"supportsForward": false,
			"userInterface": "sapui5://comsapbpmworkflow.comsapbpmwusformplayer/com.sap.bpm.wus.form.player",
			"recipientUsers": "${context.approver.Result[0].KmExpenseApprover.Approver}",
			"formReference": "/forms/KmExpenseProcess/ExpenseApproval.form",
			"userInterfaceParams": [{
				"key": "formId",
				"value": "expenseapproval"
			}, {
				"key": "formRevision",
				"value": "1.0"
			}],
			"id": "usertask1",
			"name": "KmExpenseApproval",
			"documentation": "Approval step of km expense"
		},
		"cf2c7aa8-c574-496a-bbe8-17bcdafda2e6": {
			"classDefinition": "com.sap.bpm.wfs.ScriptTask",
			"reference": "/scripts/KmExpenseProcess/PrepareUpdatePayload.js",
			"id": "scripttask2",
			"name": "PrepareUpdatePayload",
			"documentation": "This step prepares payload for updating approval status"
		},
		"26cb0449-2533-4cbc-99a0-0e75853ba142": {
			"classDefinition": "com.sap.bpm.wfs.SequenceFlow",
			"id": "sequenceflow11",
			"name": "SequenceFlow11",
			"sourceRef": "11a9b5ee-17c0-4159-9bbf-454dcfdcd5c3",
			"targetRef": "b7f6fac5-cf5a-4ecf-83d7-a6778e0b2b61"
		},
		"5df64202-094a-40a8-a9e6-9481fbaba4a9": {
			"classDefinition": "com.sap.bpm.wfs.SequenceFlow",
			"id": "sequenceflow12",
			"name": "SequenceFlow12",
			"sourceRef": "b7f6fac5-cf5a-4ecf-83d7-a6778e0b2b61",
			"targetRef": "5fd0c19b-1217-4098-917e-b90f280dab0d"
		},
		"7e004af2-14f9-4053-b267-fc15a12ff71d": {
			"classDefinition": "com.sap.bpm.wfs.SequenceFlow",
			"id": "sequenceflow13",
			"name": "SequenceFlow13",
			"sourceRef": "5fd0c19b-1217-4098-917e-b90f280dab0d",
			"targetRef": "1ddd9bd9-b1a5-4cd5-bccf-f42fe5467887"
		},
		"a06ecc64-e12d-40ab-a434-6dc5a0f59cee": {
			"classDefinition": "com.sap.bpm.wfs.SequenceFlow",
			"id": "sequenceflow15",
			"name": "SequenceFlow15",
			"sourceRef": "1ddd9bd9-b1a5-4cd5-bccf-f42fe5467887",
			"targetRef": "bf9506ba-6365-41f0-a316-4e78271bb526"
		},
		"72cc685c-4552-4f3e-8e82-13c78bf0f087": {
			"classDefinition": "com.sap.bpm.wfs.SequenceFlow",
			"id": "sequenceflow16",
			"name": "SequenceFlow16",
			"sourceRef": "bf9506ba-6365-41f0-a316-4e78271bb526",
			"targetRef": "cf2c7aa8-c574-496a-bbe8-17bcdafda2e6"
		},
		"9ede1505-4bc2-453d-9e45-8b0d7ece9eae": {
			"classDefinition": "com.sap.bpm.wfs.SequenceFlow",
			"id": "sequenceflow17",
			"name": "SequenceFlow17",
			"sourceRef": "cf2c7aa8-c574-496a-bbe8-17bcdafda2e6",
			"targetRef": "bc872a24-3b4c-4522-a439-ac2994134311"
		},
		"42fa7a2d-c526-4a02-b3ba-49b5168ba644": {
			"classDefinition": "com.sap.bpm.wfs.ui.Diagram",
			"symbols": {
				"df898b52-91e1-4778-baad-2ad9a261d30e": {},
				"53e54950-7757-4161-82c9-afa7e86cff2c": {},
				"cda2c426-0f1c-4f27-818a-c14dfb826f32": {},
				"5d5ccdce-c66e-44c5-81f1-2f0479625de5": {},
				"1f18bacf-e66a-482d-ba3b-5b0d496a91d1": {},
				"a9d6b8f7-7238-4f2a-9238-25e7c762e93e": {},
				"be71c28f-7fb1-46b5-bd81-860819df2feb": {},
				"0bef1ab8-d394-475b-aa94-ad368ee8acee": {},
				"6cbe14fd-795d-4acc-af72-b18541349325": {},
				"601aa202-b6fe-4812-b39f-4c1c09c54f96": {},
				"82e789a9-4490-4674-b52b-8474b88738f2": {},
				"bc247821-ce3a-49ff-b4aa-1e9e236df359": {},
				"cc3b60c3-b642-4fcd-bf69-7e4e0532d900": {},
				"5b8c4675-2ffa-43bf-acce-23bfa8b25840": {},
				"049aa650-5bb0-4f5b-a66f-ebd6df29a43c": {}
			}
		},
		"88cface9-d32f-4562-b536-9a1ced1f84cc": {
			"classDefinition": "com.sap.bpm.wfs.SampleContext",
			"reference": "/sample-data/KmExpenseProcess/SampleContext.json",
			"id": "default-start-context"
		},
		"9c5e3d70-a186-4094-b932-2c8bbd7e7a3e": {
			"classDefinition": "com.sap.bpm.wfs.TerminateEventDefinition",
			"id": "terminateeventdefinition2"
		},
		"df898b52-91e1-4778-baad-2ad9a261d30e": {
			"classDefinition": "com.sap.bpm.wfs.ui.StartEventSymbol",
			"x": 12,
			"y": 26,
			"width": 32,
			"height": 32,
			"object": "11a9b5ee-17c0-4159-9bbf-454dcfdcd5c3"
		},
		"53e54950-7757-4161-82c9-afa7e86cff2c": {
			"classDefinition": "com.sap.bpm.wfs.ui.EndEventSymbol",
			"x": 994,
			"y": 24.5,
			"width": 35,
			"height": 35,
			"object": "2798f4e7-bc42-4fad-a248-159095a2f40a"
		},
		"cda2c426-0f1c-4f27-818a-c14dfb826f32": {
			"classDefinition": "com.sap.bpm.wfs.ui.ScriptTaskSymbol",
			"x": 94,
			"y": 12,
			"width": 100,
			"height": 60,
			"object": "b7f6fac5-cf5a-4ecf-83d7-a6778e0b2b61"
		},
		"5d5ccdce-c66e-44c5-81f1-2f0479625de5": {
			"classDefinition": "com.sap.bpm.wfs.ui.ServiceTaskSymbol",
			"x": 244,
			"y": 12,
			"width": 100,
			"height": 60,
			"object": "5fd0c19b-1217-4098-917e-b90f280dab0d"
		},
		"1f18bacf-e66a-482d-ba3b-5b0d496a91d1": {
			"classDefinition": "com.sap.bpm.wfs.ui.ServiceTaskSymbol",
			"x": 394,
			"y": 12,
			"width": 100,
			"height": 60,
			"object": "1ddd9bd9-b1a5-4cd5-bccf-f42fe5467887"
		},
		"a9d6b8f7-7238-4f2a-9238-25e7c762e93e": {
			"classDefinition": "com.sap.bpm.wfs.ui.SequenceFlowSymbol",
			"points": "44,42 94,42",
			"sourceSymbol": "df898b52-91e1-4778-baad-2ad9a261d30e",
			"targetSymbol": "cda2c426-0f1c-4f27-818a-c14dfb826f32",
			"object": "26cb0449-2533-4cbc-99a0-0e75853ba142"
		},
		"be71c28f-7fb1-46b5-bd81-860819df2feb": {
			"classDefinition": "com.sap.bpm.wfs.ui.SequenceFlowSymbol",
			"points": "194,42 244,42",
			"sourceSymbol": "cda2c426-0f1c-4f27-818a-c14dfb826f32",
			"targetSymbol": "5d5ccdce-c66e-44c5-81f1-2f0479625de5",
			"object": "5df64202-094a-40a8-a9e6-9481fbaba4a9"
		},
		"0bef1ab8-d394-475b-aa94-ad368ee8acee": {
			"classDefinition": "com.sap.bpm.wfs.ui.SequenceFlowSymbol",
			"points": "344,42 394,42",
			"sourceSymbol": "5d5ccdce-c66e-44c5-81f1-2f0479625de5",
			"targetSymbol": "1f18bacf-e66a-482d-ba3b-5b0d496a91d1",
			"object": "7e004af2-14f9-4053-b267-fc15a12ff71d"
		},
		"6cbe14fd-795d-4acc-af72-b18541349325": {
			"classDefinition": "com.sap.bpm.wfs.ui.SequenceFlowSymbol",
			"points": "494,42 544,42",
			"sourceSymbol": "1f18bacf-e66a-482d-ba3b-5b0d496a91d1",
			"targetSymbol": "601aa202-b6fe-4812-b39f-4c1c09c54f96",
			"object": "a06ecc64-e12d-40ab-a434-6dc5a0f59cee"
		},
		"601aa202-b6fe-4812-b39f-4c1c09c54f96": {
			"classDefinition": "com.sap.bpm.wfs.ui.UserTaskSymbol",
			"x": 544,
			"y": 12,
			"width": 100,
			"height": 60,
			"object": "bf9506ba-6365-41f0-a316-4e78271bb526"
		},
		"82e789a9-4490-4674-b52b-8474b88738f2": {
			"classDefinition": "com.sap.bpm.wfs.ui.SequenceFlowSymbol",
			"points": "644,42 694,42",
			"sourceSymbol": "601aa202-b6fe-4812-b39f-4c1c09c54f96",
			"targetSymbol": "bc247821-ce3a-49ff-b4aa-1e9e236df359",
			"object": "72cc685c-4552-4f3e-8e82-13c78bf0f087"
		},
		"bc247821-ce3a-49ff-b4aa-1e9e236df359": {
			"classDefinition": "com.sap.bpm.wfs.ui.ScriptTaskSymbol",
			"x": 694,
			"y": 12,
			"width": 100,
			"height": 60,
			"object": "cf2c7aa8-c574-496a-bbe8-17bcdafda2e6"
		},
		"cc3b60c3-b642-4fcd-bf69-7e4e0532d900": {
			"classDefinition": "com.sap.bpm.wfs.ui.SequenceFlowSymbol",
			"points": "794,42 844,42",
			"sourceSymbol": "bc247821-ce3a-49ff-b4aa-1e9e236df359",
			"targetSymbol": "5b8c4675-2ffa-43bf-acce-23bfa8b25840",
			"object": "9ede1505-4bc2-453d-9e45-8b0d7ece9eae"
		},
		"62d7f4ed-4063-4c44-af8b-39050bd44926": {
			"classDefinition": "com.sap.bpm.wfs.LastIDs",
			"terminateeventdefinition": 2,
			"sequenceflow": 18,
			"startevent": 1,
			"endevent": 1,
			"usertask": 1,
			"servicetask": 4,
			"scripttask": 2
		},
		"bc872a24-3b4c-4522-a439-ac2994134311": {
			"classDefinition": "com.sap.bpm.wfs.ServiceTask",
			"destination": "VehicleManagement",
			"path": "${context.updateEndpoint}",
			"httpMethod": "PATCH",
			"requestVariable": "${context.updatePayload}",
			"responseVariable": "${context.updateResponse}",
			"id": "servicetask4",
			"name": "UpdateStatus",
			"documentation": "This step updates the status of km expense approval in database"
		},
		"5b8c4675-2ffa-43bf-acce-23bfa8b25840": {
			"classDefinition": "com.sap.bpm.wfs.ui.ServiceTaskSymbol",
			"x": 844,
			"y": 12,
			"width": 100,
			"height": 60,
			"object": "bc872a24-3b4c-4522-a439-ac2994134311"
		},
		"f44f61e6-3d9f-41a8-9603-8c791817a312": {
			"classDefinition": "com.sap.bpm.wfs.SequenceFlow",
			"id": "sequenceflow18",
			"name": "SequenceFlow18",
			"sourceRef": "bc872a24-3b4c-4522-a439-ac2994134311",
			"targetRef": "2798f4e7-bc42-4fad-a248-159095a2f40a"
		},
		"049aa650-5bb0-4f5b-a66f-ebd6df29a43c": {
			"classDefinition": "com.sap.bpm.wfs.ui.SequenceFlowSymbol",
			"points": "944,42 994,42",
			"sourceSymbol": "5b8c4675-2ffa-43bf-acce-23bfa8b25840",
			"targetSymbol": "53e54950-7757-4161-82c9-afa7e86cff2c",
			"object": "f44f61e6-3d9f-41a8-9603-8c791817a312"
		}
	}
}