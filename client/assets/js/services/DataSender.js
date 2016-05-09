app.factory("DataSender", ['$http', '$state', 'AuthChecker',
    function ($http, $state, AuthChecker) { // This service connects to our REST API

//        var serviceBase = 'http://localhost/SolutionMVC/public/';

        //Config for Sandbox
        var serviceBase = 'http://doug.portal.solutionhost.co.uk/apps/Audit/SolutionMVC/public/';

        var obj = {};
        obj.get = function (q) {
            return $http.get(serviceBase + q).then(function successCallback(response) {
                return response.data;
            }, function errorCallback(response) {
                $state.go('otherwise', {}, {reload: true});
            });
        };
        obj.post = function (q, object) {
            return $http.post(serviceBase + q, object).then(function successCallback(response) {
//                alert(response.data.token);
            if(response.data.token){
//                alert(response.data.token);
                AuthChecker.saveToken(response.data.token);
            }else{
//                alert("Still got here ???" + response.data.token);
            }
                return response.data;
            }, function errorCallback(response) {                
                if (response.status === 401) {
                    $state.go('login', {}, {reload: true});
                } else {
                    $state.go('otherwise', {}, {reload: true});
                }
            });
        };
        obj.put = function (q, object) {
            return $http.put(serviceBase + q, object).then(function successCallback(response) {
                return response.data;
            }, function errorCallback(response) {
                $state.go('otherwise', {}, {reload: true});
            });
        };
        obj.delete = function (q) {
            return $http.delete(serviceBase + q).then(function successCallback(response) {
                return response.data;
            }, function errorCallback(response) {
                $state.go('otherwise', {}, {reload: true});
            });
        };

        return obj;
    }]);