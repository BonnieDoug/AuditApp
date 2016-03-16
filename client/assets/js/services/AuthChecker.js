app.factory("AuthChecker", function($http, $q, $window, DataSender) {
  var userInfo;

  function login(user) {
    var deferred = $q.defer();

    DataSender.post("/Security/Login", {
      user: user
    }).then(function(result) {
      userInfo = {
        accessToken: result.data.access_token,
        userName: result.data.userName
      };
      userInfo = {
                    accessToken: results.token,
                    userName: results.username
                };
      sessionStorage["userInfo"] = JSON.stringify(userInfo);
      deferred.resolve(userInfo);
    }, function(error) {
      deferred.reject(error);
    });

    return deferred.promise;
  }

  return {
    login: login
  };
});

