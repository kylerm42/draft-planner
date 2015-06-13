angular.module 'draftPlanner'
  .controller 'UsersCtrl', ['$scope', '$auth', '$state', ($scope, $auth, $state) ->

    $scope.$on 'auth:login-success', (evt, user) ->
      $state.go 'home'

    $scope.handleRegBtnClick = ->
      $auth.submitRegistration $scope.registrationForm
        .then (resp) ->
          $state.go 'collections.new'
        .catch (resp) ->
          console.log 'registration failed'
  ]
