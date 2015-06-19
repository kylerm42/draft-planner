angular.module 'draftPlanner'
  .controller 'UsersCtrl', ['$scope', '$auth', '$state', ($scope, $auth, $state) ->

    $scope.$on 'auth:login-success', (evt, user) ->
      $state.go 'home'

    $scope.handleRegBtnClick = ->
      $('.ui.dimmer').dimmer('show')
      $auth.submitRegistration $scope.registrationForm
        .then (resp) ->
          $('.ui.dimmer').dimmer('hide')
          $state.go 'collections.new'
        .catch (resp) ->
          console.log 'registration failed'
  ]
