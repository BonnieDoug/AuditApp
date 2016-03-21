app.controller('AuditController', function ($scope, DataSender, $stateParams) {

    var date = new Date();

    $scope.getAudits = function () {
        DataSender.get('Audit/index').then(function (audits) {
            if (audits) {
                $scope.audits = audits;
            } else {
                alert("No Data Sent");
            }
        });
    };
//$scope.takeAudit = [
//];
    $scope.doTakeAudit = function () {
        
        $scope.doGetAudit();
        $scope.takeAudit = 
            {
                "auditor": "Doug",
                "date": $scope.DateToday,
            }
        ;
    };

    $scope.doGetAudit = function () {
               
        $scope.dataLoaded = false;
        DataSender.get('Audit/getAudit/' + $stateParams.anauditid).then(function (audit) {
            if (audit) {
                $scope.audit = audit;
                $scope.dataLoaded = true;
            } else {
                alert("No Data Sent");
            }
        }, 200);
    };


    $scope.createNewAudit = function () {
        
        DataSender.get('Audit/initialNewAuditData/').then(function (data) {
            if (data) {
                $scope.auditTypes = data.auditTypes;
                $scope.questionTypes = data.questionTypes;
//                alert(auditTypes)
            } else {
                alert("No Data Receive");
            }
        }, 200);
        
        $scope.audit = {
            "name": "",
            "description": "",
//            "auditType": {"id": ""},
        };
        $scope.audit.groups = [];
    }

    $scope.doNewAudit = function (audit) {

        DataSender.post('Audit/NewAudit', {
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

    $scope.addGroup = function () {
        $scope.audit.groups.push(
                {
                    "name": "",
                    "questions": []
                });
    };

    $scope.addQuestion = function (gIndex) {
        $scope.audit.groups[gIndex].questions.push(
                {
                    "placeholder": "Type question here.",
                    "question": " ",
                    "selectedType": {"id": 1},
                    "answerRequired": 1,
                    "addEvidence": 0,
                    "evidenceRequired": 0,
                    "addExpiry": 0,
                    "expiryRequired": 0
                });
    };

    $scope.removeGroup = function (index) {
        $scope.audit.groups.splice(index, 1);
    };


    $scope.removeQuestion = function (gIndex, qIndex) {

        $scope.audit.groups[gIndex].questions.splice(qIndex, 1);

    };

    $scope.DateToday = ('0' + date.getDate()).slice(-2) + '-' + ('0' + (date.getMonth() + 1)).slice(-2) + '-' + date.getFullYear();


$scope.clear = function(pindex, cindex) {
    alert(pindex + cindex);
    $scope.audit.groups.questions.question[pindex].answer[cindex].evidence = null;
  };
  
  
  
  

});


  