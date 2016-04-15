// This service controls our auth tokens. Stored on filesystem rather than in 
// Cookies or Sessions as we can't use PHP sessions from the front end and we 
// can't rely on Sessions/Cookies when/if moved to a mobile native app. 
// Plus Session and Cookies are so old school...

app.factory("AuthChecker", ['$window',
    function ($window) { 
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
        };

        self.isAuthed = function () {

            var token = self.getToken();
            if (token) {
                var params = self.parseJwt(token);
                //Convert PHP Unix Seconds to JS Unix Milliseconds then check if expired.
                return Math.round(new Date().getTime() / 1000) <= params.exp;
            } else {
                return false;
            }
        };

        self.logout = function () {
            $window.localStorage.removeItem('jwtToken');
        };


        self.getParsedToken = function () {
            return self.parseJwt(self.getToken());
        };

        return self;
    }]);

