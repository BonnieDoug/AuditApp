app.controller('AuthController', function ($scope, $location, DataSender, $window, AuthChecker, $state, FoundationApi) {


    //initially set those objects to null to avoid undefined error
    $scope.login = {};
    $scope.signup = {};

    $scope.isAuthed = AuthChecker.isAuthed();

    $scope.doLogin = function (user) {

        DataSender.post('Security/Login', {
            user: user
        }).then(function (results) {
            if (results.status == "success") {

                AuthChecker.saveToken(results.token);

                $state.go('home', {}, {reload: true});
                FoundationApi.publish('success-notifications', {
                    title: 'Logged In',
                    content: 'You have been logged in.',
                    autoclose: 2500,
                    color: "success",
                    position: "top-right",
                });

            } else {

            }
        });
    };
    $scope.signup = {email: '', password: '', name: '', phone: '', address: ''};

    $scope.doLogout = function () {
        AuthChecker.logout();
        $state.go('login', {}, {reload: true});
        FoundationApi.publish('success-notifications', {
            title: 'Logged Out!',
            content: 'You have been logged out.',
            autoclose: 2500,
            color: "success",
            position: "top-right",
        });
    }

//    function setSession(results) {
//        userInfo = {
//            accessToken: results.token,
//            userName: results.username
//        };
//        sessionStorage["userInfo"] = JSON.stringify(userInfo);
//        return;
//
//    }


});