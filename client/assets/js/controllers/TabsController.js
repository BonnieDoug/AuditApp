app.controller('TabsController', function ($scope, Upload) {
 

    $scope.max = 2;
    $scope.selectedIndex = 0;
    $scope.nextTab = function () {
        var index = ($scope.selectedIndex == $scope.max) ? 0 : $scope.selectedIndex + 1;
        $scope.selectedIndex = index;
    };

  $scope.onFileSelect = function(file) {
    Upload.upload({
        url: 'http://localhost/SolutionMVC/public/Upload/Assetimage',
        data: {file: file, username: $scope.username},
    }).then(function(resp) {
       $scope.asset.filename = resp.data;
    });
    };

});