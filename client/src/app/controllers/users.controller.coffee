angular.module 'draftPlanner'
  .controller 'UsersCtrl', ['$scope', '$auth', ($scope, $auth) ->
    $scope.handleRegButtonClick = ->
      $auth.submitRegistration $scope.registrationForm
        .then (resp) ->
          console.log 'success!'
        .catch (resp) ->
          console.log 'failed :('
  ]
