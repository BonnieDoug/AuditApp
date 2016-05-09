app.controller('AuditController', function ($scope, DataSender, $stateParams, $mdDialog, $mdMedia, FoundationApi, $timeout, $state, AuthChecker) {



    var date = new Date();

    $scope.status = '  ';
    $scope.customFullscreen = $mdMedia('xs') || $mdMedia('sm');

    $scope.getAudits = function () {
        DataSender.post('Audit', {
            token: AuthChecker.getToken()
        }).then(function (data) {
            if (data) {
                $scope.audits = data.audits;
            }
        });
    };
//$scope.takeAudit = [
//];
    $scope.doSaveNewAudit = function (data) {
        DataSender.post('Audit/New/', {
            token: AuthChecker.getToken(),
            data: data
        }).then(function (results) {
            if (results.status === "success") {
                $state.go('auditcp', {}, {reload: true});
                FoundationApi.publish('success-notifications', {
                    title: 'Audit Added',
                    content: 'New audit successfully added.',
                    autoclose: 2500,
                    color: "success",
                    position: "top-right",
                });
            } else {
                FoundationApi.publish('failure-notifications', {
                    title: 'Failure!',
                    content: 'There has been an error whilst trying to add your audit.',
                    autoclose: 2500,
                    color: "alert",
                    position: "top-right",
                });
            }
        });
    };
    $scope.doUpdateAudit = function (data) {
        DataSender.post('Audit/Update/', {
            token: AuthChecker.getToken(),
            data: data
        }).then(function (results) {
            if (results.status === "success") {
                $state.go('auditcp', {}, {reload: true});
                FoundationApi.publish('success-notifications', {
                    title: 'Audit Added',
                    content: 'New audit successfully added.',
                    autoclose: 2500,
                    color: "success",
                    position: "top-right",
                });
            } else {
                FoundationApi.publish('failure-notifications', {
                    title: 'Failure!',
                    content: 'There has been an error whilst trying to add your audit.',
                    autoclose: 2500,
                    color: "alert",
                    position: "top-right",
                });
            }
        });
    };
    $scope.doRetireAudit = function (id) {
        DataSender.post("Audit/retireAudit", {
            token: AuthChecker.getToken(),
            id: id
        }).then(
                function (results) {
                    if (results.status === "success") {
                        //$scope.hideRow(index);
                        FoundationApi.publish('success-notifications', {
                            title: 'Audit Retired',
                            content: 'Audit ' + id + ' has successfully been retired.',
                            autoclose: 2500,
                            color: "success",
                            position: "top-right",
                        });
                        $scope.startFade = true;
                        $timeout(function () {
                            $scope.audits[id].isHidden = true;
                        }, 500);

                    } else {
                        FoundationApi.publish('failure-notifications', {
                            title: 'Failure',
                            content: 'There was an error while attempting to retire the audit.',
                            autoclose: 2500,
                            color: "success",
                            position: "top-right",
                        });
                    }
                });
    };
    $scope.filterFunction = function (element) {
        return element.name.match(/^Ma/) ? true : false;
    };
    $scope.doTakeAudit = function () {
        
//        alert("doTakeAudit");
        DataSender.post('Audit/takeAudit/' + $stateParams.anauditid, {
            token: AuthChecker.getToken(),
        }).then(function (audit) {
            if (audit) {
                $scope.audit = audit;
                $scope.dataLoaded = true;
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
//        alert("HERE");
//        $scope.getInitialAuditData();
        $scope.dataLoaded = false;
        
        DataSender.post('Audit/getAudit/' + $stateParams.anauditid, {
            token: AuthChecker.getToken()
        }).
        
//        DataSender.get('Audit/getAudit/' + $stateParams.anauditid).
        then(function (audit) {
            if (audit) {
                $scope.audit = audit;
                $scope.audit.id = $stateParams.anauditid;
                $scope.dataLoaded = true;
            } else {
                alert("No Data Sent");
            }
        }, 200);
    };

    $scope.getInitialAuditData = function () {
        DataSender.post('Audit/initialNewAuditData/', {
            token: AuthChecker.getToken(),
        }).then(function (data) {
            if (data) {
                $scope.auditTypes = data.auditTypes;
                $scope.questionTypes = data.questionTypes;
//                $scope.questionTypeOptions = data.questionTypeOptions;
            } else {
                alert("No Data Receive");
            }
        }, 200);
    };
    
    $scope.createNewAudit = function () {
        $scope.getInitialAuditData();
        $scope.audit = {
            "name": "",
            "description": ""
        };
        $scope.audit.groups = [];
    };

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
                    "answerType": 0,
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



    $scope.showConfirm = function (ev, id, index) {
        // Appending dialog to document.body to cover sidenav in docs app
        var confirm = $mdDialog.confirm()
                .title('Retire Audit')
                .textContent('Are you sure you want to remove this audit?')
                .ariaLabel('Retire Audit')
                .targetEvent(ev)
                .ok('Yes')
                .cancel('No');
        $mdDialog.show(confirm).then(function () {
            $scope.doRetireAudit(id, index);
        });
    };


    $scope.sort = function (keyname) {
        $scope.sortKey = keyname;   //set the sortKey to the param passed
        $scope.reverse = !$scope.reverse; //if true make it false and vice versa
    };




});

app.filter('orderObjectBy', function () {
    return function (items, field, reverse) {
        var filtered = [];
        angular.forEach(items, function (item) {
            filtered.push(item);
        });
        filtered.sort(function (a, b) {

            return (parseInt(a[field]) > parseInt(b[field]) ? 1 : -1);
        });
        if (reverse)
            filtered.reverse();
        return filtered;
    };
});

function DialogController($scope, $mdDialog) {
    $scope.hide = function () {
        $mdDialog.hide();
    };

    $scope.cancel = function () {
        $mdDialog.cancel();
    };

    $scope.answer = function (answer) {
        $mdDialog.hide(answer);
    };
}
