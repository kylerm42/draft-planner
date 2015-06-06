angular.module 'draftPlanner', ['ng', 'ngAnimate', 'ngCookies', 'ngTouch', 'ngSanitize',
                                'ngResource', 'ui.router', 'ng-token-auth', 'rails', 'ng-sortable']
  .config ($stateProvider, $urlRouterProvider, $rootScopeProvider) ->
    $stateProvider
      .state 'home',
        url:          '/',
        templateUrl:  'app/views/home.html',
        controller:   'HomeCtrl'
      .state 'sign_up',
        url:          '/sign_up',
        templateUrl:  'app/views/users/new.html',
        controller:   'UsersCtrl'
      .state 'sign_in',
        url:          '/sign_in',
        templateUrl:  'app/views/sessions/new.html',
        controller:   'SessionsCtrl'
      .state 'collections',
        abstract:     true,
        url:          '/collections',
        templateUrl:  'app/views/collections/collections.html',
        resolve:
          auth: ($auth) -> $auth.validateUser()
      .state 'collections.new',
        url:          '/new',
        templateUrl:  'app/views/collections/new.html',
        controller:   'NewCollectionsCtrl'
      .state 'collections.show',
        url:          '/:id/:position',
        templateUrl:  'app/views/collections/show.html',
        controller:   'ShowCollectionsCtrl'

    $urlRouterProvider.otherwise '/'

  .factory 'Collection', (RailsResource, railsSerializer) ->
    class Collection extends RailsResource
      @configure
        url: '/api/collections',
        name: 'collection',
        serializer: railsSerializer () ->
          this.resource 'sheets', 'Sheet'

  .factory 'Sheet', (RailsResource, railsSerializer) ->
    class Sheet extends RailsResource
      @configure
        url: '/api/collections/{{collectionId}}/{{position}}',
        name: 'sheet',
        serializer: railsSerializer () ->
          this.resource 'players', 'Player'
          this.resource 'tags', 'Tag'
          this.only 'ranks'

  .factory 'Player', (RailsResource) ->
    class Player extends RailsResource
      @configure
        url: '/api/players',
        name: 'player'

  .factory 'Tag', (RailsResource) ->
    class Tag extends RailsResource
      @configure
        url: '/api/sheets/{{sheetId}}/tags/{{id}}',
        name: 'tag'
