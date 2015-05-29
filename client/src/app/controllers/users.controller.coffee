angular.module 'draftPlanner'
  .controller 'UsersCtrl', ['$scope', '$auth', '$state', ($scope, $auth, $state) ->

    $scope.$on 'auth:login-success', (evt, user) ->
      console.log evt
      console.log user
      $state.go 'home'

    $scope.handleRegBtnClick = ->
      $auth.submitRegistration $scope.registrationForm
        .then (resp) ->
          console.log 'registration success!'
        .catch (resp) ->
          console.log 'registration failed :('
  ]
