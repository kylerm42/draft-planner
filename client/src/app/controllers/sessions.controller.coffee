angular.module 'draftPlanner'
  .controller 'SessionsCtrl', ['$scope', '$state', ($scope, $state) ->

    if !$.isEmptyObject($scope.user)
      $state.go 'home'

    $scope.$on 'auth:login-success', (evt, user) ->
      console.log evt
      console.log user
      $state.go 'home'
  ]
