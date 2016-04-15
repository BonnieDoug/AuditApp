var app = angular.module('application');

  app.controller('MainCtrl', function($scope) {

  $scope.choices = [{id: 'choice1'}, {id: 'choice2'}];
  
  $scope.addNewChoice = function() {
    var newItemNo = $scope.choices.length+1;
    $scope.choices.push({'id':'choice'+newItemNo});
  };
    
  $scope.removeChoice = function(index) {   
    $scope.choices.splice(index, 1);
  };
  
});
