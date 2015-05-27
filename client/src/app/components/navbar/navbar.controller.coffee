angular.module "draftPlanner"
  .controller "NavbarCtrl", ($scope) ->
    $scope.date = new Date()
