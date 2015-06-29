angular.module 'draftPlanner'
  .controller 'UsersCtrl', ['$scope', '$auth', '$state', 'loaders',
    ($scope, $auth, $state, loaders) ->

      $scope.handleRegBtnClick = ->
        loaders.fabLoading()
        $auth.submitRegistration $scope.registrationForm
          .then (resp) ->
            $('.ui.dimmer').dimmer('hide')
            $state.go 'collections.new'
          .catch (resp) ->
            console.log 'registration failed'

      $scope.$on 'auth:login-success', (evt, user) ->
        $state.go 'home'

      loaders.pageLoaded()
  ]
