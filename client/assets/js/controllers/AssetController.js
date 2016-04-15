app.controller('AssetController', function ($scope, DataSender, $stateParams, Upload, $mdDialog, $mdMedia, FoundationApi, $timeout, $state, $q, AuthChecker) {

    $scope.previousState;
    $scope.currentState;
    $scope.$on('$stateChangeSuccess', function (ev, to, toParams, from, fromParams) {
        $scope.previousState = from.name;
        $scope.currentState = to.name;
//        console.log('Previous state:' + $scope.previousState)
//        console.log('Current state:' + $scope.currentState)
    });

    $scope.doGetAllAssets = function () {
        DataSender.post('Asset/', {
            token: AuthChecker.getToken(),
        }).then(function (data) {

            if (data) {
//                alert(data);


    console.log(data);
                $scope.assets = data.assets;
            } else {
                alert("Failure");
            }
        });
    };
    $scope.doGetAllAssetGroups = function () {
        DataSender.get('AssetGroup').then(function (data) {
            if (data) {
                return $scope.assetGroups = data;
            } else {
                alert("Failure");
            }
        });
    };
    $scope.doGetAllAssetTypes = function (id) {
        DataSender.get('AssetTypes').then(function (data) {

            alert("CALLED THIS FUNCTION");
        });
    };
    $scope.doGetAssetTypesByGroup = function () {

        $scope.grname = $stateParams.asgrtype;
        DataSender.get('AssetType/getByGroup/' + $stateParams.asgrid).then(function (data) {
            if (data) {

                $scope.assetType = data;
//                $scope.assetType.push(
//                        {
//                            "id" : 0,
//                            "name": "All"
//                        }
//                );
            } else {
                alert("Failure");
            }
        });
    };
    $scope.doGetAssetsByType = function () {

        $scope.tyname = $stateParams.astytype;

        DataSender.post('Asset/getAllByType/' + $stateParams.astyid, {
            token: AuthChecker.getToken(),
        }).then(function (data) {
            if (data) {
                $scope.assets = data;
                //alert(data);
            } else {
                alert("Failure");
            }
        });
    };

    $scope.doGetAssetsByGroup = function (id) {

        DataSender.post('Asset/getAllByGroup/' + $stateParams.asgrid, {
            token: AuthChecker.getToken(),
        }).then(function (data) {
            if (data) {
                $scope.assets = data;
            } else {
                alert("Failure");
            }
        });
    };

    $scope.doGetAsset = function (id) {
        DataSender.get('Asset/get/' + id).then(function (data) {
            if (data) {
                $scope.asset = data;
            } else {
                alert("Failure");
            }
        });
    };



    $scope.newAsset = function () {

        $scope.asset = {
            "forename": "",
            "middlename": "",
            "surname": "",
            "unique_ref_code": "",
            "address1": "",
            "address2": "",
            "Counties_id": "",
            "Countries_id": "",
            "postcode": "",
            "dob": "",
            "start_date": "",
            "AssetGroups_id": "",
            "AssetTypes_id": "",
            "image": ""
        };

        var AuditGroups = DataSender.get('AssetGroup/getGroupsWithTypes').then(function (data1) {
            $scope.AssetGroups = data1;
        });
        var Counties = DataSender.get('Helper/getCounties').then(function (data2) {
            $scope.Counties = data2;
        });
        var Countries = DataSender.get('Helper/getCountries').then(function (data3) {
            $scope.Countries = data3;
        });
        AuditGroups;
        Counties;
        Countries;
//        $scope.asset = {};
        $scope.asset.county = null;
        $scope.asset.country = {};
        $scope.asset.country.id = 229;
        $scope.asset.country.name = "United Kingdom";
    };

    $scope.doSetNewAsset = function (asset) {

        DataSender.post('Asset/new', {
            token: AuthChecker.getToken(),
            asset: asset
        }).then(function (results) {
            alert(results);
            if (results.status === "success") {
                $state.go($scope.previousState, {}, {reload: true});
                FoundationApi.publish('success-notifications', {
                    title: 'Asset Added',
                    content: 'New asset successfully added.',
                    autoclose: 2500,
                    color: "success",
                    position: "top-right",
                });
            } else {
                FoundationApi.publish('failure-notifications', {
                    title: 'Failure!',
                    content: 'There has been an error whilst trying to add your asset.',
                    autoclose: 2500,
                    color: "alert",
                    position: "top-right",
                });
            }

        });
    };
    $scope.doSetUpdateAsset = function () {};
    $scope.doSetNewGroup = function () {};
    $scope.doSetUpdateGroup = function () {};
    $scope.doSetNewType = function () {};
    $scope.doSetUpdateType = function () {};

    $scope.doRetireAsset = function (id) {
        DataSender.post("Asset/retire", {
            id: id
        }).then(
                function (results) {
                    if (results.status === "success") {
                        FoundationApi.publish('success-notifications', {
                            title: 'Asset Retired',
                            content: 'Asset ' + id + ' has successfully been retired.',
                            autoclose: 2500,
                            color: "success",
                            position: "top-right",
                        });
                        $scope.startFade = true;
                        $timeout(function () {
                            $scope.assets[id].isHidden = true;
                        }, 500);

                    } else {
                        FoundationApi.publish('failure-notifications', {
                            title: 'Failure',
                            content: 'There was an error while attempting to retire the Asset.',
                            autoclose: 2500,
                            color: "success",
                            position: "top-right",
                        });
                    }
                });
    };

    $scope.sort = function (keyname) {
        $scope.sortKey = keyname;   //set the sortKey to the param passed
        $scope.reverse = !$scope.reverse; //if true make it false and vice versa
    };


    $scope.showConfirm = function (ev, id, index) {
        // Appending dialog to document.body to cover sidenav in docs app
        var confirm = $mdDialog.confirm()
                .title('Retire Asset')
                .textContent('Are you sure you want to remove this asset?')
                .ariaLabel('Retire Asset')
                .targetEvent(ev)
                .ok('Yes')
                .cancel('No');
        $mdDialog.show(confirm).then(function () {
            $scope.doRetireAsset(id, index);
        });
    };

    $scope.showAdvanced = function (ev, asset) {

        var useFullScreen = ($mdMedia('sm') || $mdMedia('xs')) && $scope.customFullscreen;
        $mdDialog.show({
            controller: DialogController,
            templateUrl: '../../../templates/assets/partials/assign-dialog.html',
            parent: angular.element(document.body),
            targetEvent: ev,
            clickOutsideToClose: true,
            fullscreen: useFullScreen,
            scope: $scope.$new(),
            resolve: {
                asset: function () {
                    $scope.asset = asset;
                    var token = AuthChecker.getParsedToken();
                    $scope.token = token.user.id;
                    $scope.assignment = {};
                    $scope.assignment.assigned_by = token.user.id;
                    $scope.assignment.client_id = token.user.client;
                    $scope.assignment.Assets_id = asset.id;
                },
                audits: function () {
                    DataSender.post('Audit/', {
                        token: AuthChecker.getToken(),
                    }).then(function (data) {
                        if (data) {

                            return $scope.audits = data.audits;

                        } else {
                            alert("Failure");
                        }
                    });
                }
            }
        });

        $scope.$watch(function () {
            return $mdMedia('xs') || $mdMedia('sm');
        }, function (wantsFullScreen) {
            $scope.customFullscreen = (wantsFullScreen === true);
        });
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
