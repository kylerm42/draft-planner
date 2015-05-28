angular.module 'draftPlanner', ['ngAnimate', 'ngCookies', 'ngTouch', 'ngSanitize', 'ngResource', 'ui.router', 'ng-token-auth']
  .config ($stateProvider, $urlRouterProvider) ->
    $stateProvider
      .state 'home',
        url: '/',
        templateUrl: 'app/views/main.html',
        controller: 'MainCtrl'
      .state 'sign_up',
        url: '/sign_up',
        templateUrl: 'app/views/users/new.html',
        controller: 'UsersCtrl'
      .state 'sign_in',
        url: '/sign_in',
        templateUrl: 'app/views/sessions/new.html',
        controller: 'SessionsCtrl'

    $urlRouterProvider.otherwise '/'

