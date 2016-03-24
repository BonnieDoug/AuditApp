app.controller('AuditController', function ($scope, DataSender, $stateParams) {

    var date = new Date();

    $scope.getAudits = function () {
        DataSender.get('Audit').then(function (data) {
            if (data) {
                $scope.audits = data.audits;
            } else {
                alert("No Data Sent");
            }
        });
    };
//$scope.takeAudit = [
//];
    $scope.doSaveNewAudit = function(data){
        DataSender.post('Audit/saveAudit/', {
            data: data
        }).then(function (results) {
//            if (results.status === "success") {
                
                alert(results);

//            } else {
//                alert("No data sent?");
//            }
        });
    }

$scope.filterFunction = function(element) {
    alert("HEHRR");
    return element.name.match(/^Ma/) ? true : false;
  };

    $scope.doTakeAudit = function () {

        DataSender.get('Audit/takeAudit/' + $stateParams.anauditid).then(function (audit) {
            if (audit) {
                
                
                
                $scope.audit = audit;
                $scope.dataLoaded = true;
            } else {
                alert("No Data Sent");
            }
        }, 200);

        $scope.takeAudit =
                {
                    "auditor": "Doug",
                    "date": $scope.DateToday,
                }
        ;
    };

    $scope.doGetAudit = function () {
        $scope.getInitialAuditData();
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




    $scope.getInitialAuditData = function () {
        DataSender.get('Audit/initialNewAuditData/').then(function (data) {
            if (data) {

                //alert(data);

                $scope.auditTypes = data.auditTypes;
                $scope.questionTypes = data.questionTypes;
                $scope.questionTypeOptions = data.questionTypeOptions;
//                alert(auditTypes)
            } else {
                alert("No Data Receive");
            }
        }, 200);

    },
            $scope.createNewAudit = function () {
                $scope.getInitialAuditData();
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
                    "question": "",
                    "answerRequired": 1,
                    "addEvidence": 0,
                    "evidenceRequired": 0,
                    "addExpiry": 0,
                    "expiryRequired": 0,
                    "answerType" : 0,
                });
    };

    $scope.removeGroup = function (index) {
        $scope.audit.groups.splice(index, 1);
    };


    $scope.removeQuestion = function (gIndex, qIndex) {

        $scope.audit.groups[gIndex].questions.splice(qIndex, 1);

    };

    $scope.DateToday = ('0' + date.getDate()).slice(-2) + '-' + ('0' + (date.getMonth() + 1)).slice(-2) + '-' + date.getFullYear();


    $scope.clear = function (pindex, cindex) {
        alert(pindex + cindex);
        $scope.audit.groups.questions.question[pindex].answer[cindex].evidence = null;
    };





});

app.filter('orderObjectBy', function() {
  return function(items, field, reverse) {
    var filtered = [];
    angular.forEach(items, function(item) {
      filtered.push(item);
    });
    filtered.sort(function (a, b) {
        
      return (parseInt(a[field]) > parseInt(b[field]) ? 1 : -1);
    });
    if(reverse) filtered.reverse();
    return filtered;
  };
});


  