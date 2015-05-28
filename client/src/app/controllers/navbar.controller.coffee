angular.module "draftPlanner"
  .controller "NavbarCtrl", ['$scope', ($scope) ->
    $scope.date = new Date()
  ]
