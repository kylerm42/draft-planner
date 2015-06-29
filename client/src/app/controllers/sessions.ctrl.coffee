angular.module 'draftPlanner'
  .controller 'SessionsCtrl', ['$scope', '$rootScope', '$state', '$auth', 'loaders',
    ($scope, $rootScope, $state, $auth, loaders) ->

      if !$.isEmptyObject($auth.user)
        $state.go 'home'

      $scope.handleLoginSubmit = () ->
        loaders.fabLoading()
        $auth.submitLogin($scope.loginForm).then(
          (resp) ->
            $state.go 'home'
          (resp) ->
            console.log 'login failed'
            console.log resp
        )

      $scope.$on 'auth:session-expired', (evt) ->
        console.log 'session expired'
        console.log evt
        $state.go 'home'

      $scope.$on 'auth:login-success', (evt) ->
        $state.go 'home'

      loaders.pageLoaded()
  ]
