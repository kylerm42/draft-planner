angular.module 'draftPlanner'
  .controller 'SessionsCtrl', ['$scope', '$rootScope', '$state', '$auth', ($scope, $rootScope, $state, $auth) ->

    if !$.isEmptyObject($scope.user)
      $state.go 'home'

    $scope.handleLoginSubmit = () ->
      $auth.submitLogin($scope.loginForm).then(
        (resp) ->
          console.log 'login success'
          console.log resp
          $state.go 'home'
        (resp) ->
          console.log 'login failed'
          console.log resp
      )

    $rootScope.$on 'auth:logout-success', (evt) ->
      console.log 'signed out'
      console.log evt
      $state.go 'home'

    $scope.$on 'auth:session-expired', (evt) ->
      console.log 'session expired'
      console.log evt
      $state.go 'home'

    $scope.$on 'auth:login-success', (evt) ->
      console.log 'signed in'
      console.log evt
      $state.go 'home'
  ]
