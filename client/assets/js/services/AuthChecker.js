app.factory("AuthChecker", ['$http', '$window',
    function ($http, $window) { // This service connects to our REST API

        var self = {};
        self.parseJwt = function (token) {
            var base64Url = token.split('.')[1];
            var base64 = base64Url.replace('-', '+').replace('_', '/');
            return JSON.parse($window.atob(base64));
        };
        self.saveToken = function (token) {
            $window.localStorage['jwtToken'] = token;
        };
        self.getToken = function () {
            return $window.localStorage['jwtToken'];
        };
        self.handleRequest = function (res) {
            var token = res.data ? res.data.token : null;
            if (token) {
                console.log('JWT:', token);
            }
            return res.data.message;
        }

        self.isAuthed = function () {
           
            var token = self.getToken();
            if (token) {
                var params = self.parseJwt(token);
                return Math.round(new Date().getTime() / 1000) <= params.exp;
            } else {
                return false;
            }
        }

        self.logout = function () {
            $window.localStorage.removeItem('jwtToken');
        }


        self.getParsedToken = function(){
            return self.parseJwt(self.getToken());
        }

        return self;
    }]);

