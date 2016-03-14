app.controller('AuditController', function ($scope, DataSender, $stateParams) {

    $scope.getAudits = function () {
        DataSender.get('Audit/index').then(function (audits) {
            if (audits) {
                $scope.audits = audits;
            } else {
                alert("No Data Sent");
            }
        });
    };

    $scope.doGetAudit = function () {

        DataSender.get('Audit/get/' + $stateParams.anauditid).then(function (audit) {
            if (audit) {
                $scope.audit = audit;
            } else {
                alert("No Data Sent");
            }
        });
    };


    $scope.createNewAudit = function () {
        $scope.audit = [{
                "name": "",
                "description": "",
                "auditType": {"id": ""},
            }];
        $scope.audit.groups = [];
    }

    $scope.doNewAudit = function (audit) {

        DataSender.post('Audit/New', {
            audit: audit
        }).then(function (results) {
            //if (results.status == "success") {
//                setSession(results);

            alert(results);

            //} else {
            //  alert("Incorrect Password");
            //}
        });
    };



//    $scope.number = 5;
//    $scope.getNumber = function (num) {
//        return new Array(num);
//    };

    $scope.questionType = [
        {
            "id": "1",
            "name": "Yes/No/NA"
        },
        {
            "id": "2",
            "name": "Textbox"
        },
        {
            "id": "3",
            "name": "Points"
        }
    ];

    $scope.auditType = [
        {
            "name": "Safety Audit",
            "id": "1"
        },
        {
            "name": "Legionella",
            "id": "2"
        },
        {
            "name": "Gap Analysis",
            "id": "3"
        },
        {
            "name": "Employee Appraisal",
            "id": "4"
        },
        {
            "name": "Sub Contractor Review",
            "id": "5"
        }
    ];



    $scope.addGroup = function () {
        $scope.audit.groups.push(
                {
                    "name": "Group Name",
                    "questions": []
                });
    };

    $scope.addQuestion = function (gIndex) {
        $scope.audit.groups[gIndex].questions.push(
                {
                    "placeholder": "Type question here.",
                    "question": "",
                    selectedType: {"id": '1'},
                    "answerRequired": "1",
                    "addEvidence": "0",
                    "evidenceRequired": "0",
                    "addExpiry": "0",
                    "expiryRequired": "0"
                });
    };

    $scope.removeGroup = function (index) {
        $scope.audit.groups.splice(index, 1);
    };


    $scope.removeQuestion = function (gIndex, qIndex) {

        $scope.audit.groups[gIndex].questions.splice(qIndex, 1);

    };



});


  