angular.module 'draftPlanner', ['ngAnimate', 'ngCookies', 'ngTouch', 'ngSanitize', 'ngResource', 'ui.router', 'ng-token-auth']
  .config ($stateProvider, $urlRouterProvider) ->
    $stateProvider
      .state 'home',
        url: '/',
        templateUrl: 'app/views/main.html',
        controller: 'MainCtrl'

    $urlRouterProvider.otherwise '/'

