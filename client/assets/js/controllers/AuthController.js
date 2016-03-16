app.controller('AuthController', function ($scope, $location, DataSender) {
    //initially set those objects to null to avoid undefined error
    $scope.login = {};
    $scope.signup = {};
    $scope.doLogin = function (user) {

        DataSender.post('Security/Login', {
            user: user
        }).then(function (results) {
            if (results.status == "success") {
                setSession(results);

                alert(sessionStorage["userInfo"]);

            } else {
                alert("Incorrect Password");
            }
        });
    };
    $scope.signup = {email: '', password: '', name: '', phone: '', address: ''};

    $scope.logout = function () {
        DataSender.get('logout').then(function (results) {

            $location.path('login');
        });
    }

    function setSession(results) {
        userInfo = {
            accessToken: results.token,
            userName: results.username
        };
        sessionStorage["userInfo"] = JSON.stringify(userInfo);
        return;

    }


});