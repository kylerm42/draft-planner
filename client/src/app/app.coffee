angular.module 'draftPlanner', ['ng', 'ngAnimate', 'ngCookies', 'ngTouch', 'ngSanitize',
                                'ngResource', 'ui.router', 'ng-token-auth', 'rails',
                                'ng-sortable']
  .config ($stateProvider, $urlRouterProvider, $rootScopeProvider, $authProvider) ->

    console.log "You must be special kind of person if you are looking in here. I like it. I'm Kyle, and I'm a web developer who is
      actually looking for a full time position at a company where I can build a long term career. I love Ruby, Rails and back end
      development, but front end development is growing on me as well. This site was built mainly with AngularJS accessing a Rails
      API. If you're interested in chatting with me, send me an email at \"kylerm 42 at gmail . com\".gsub(/at/, '@').delete(' ')"

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
        templateUrl:  'app/views/collections/base.html',
        resolve:
          auth: ($auth) -> $auth.validateUser()
      .state 'collections.new',
        url:          '/new',
        templateUrl:  'app/views/collections/new.html',
        controller:   'CollectionsNewCtrl'
      .state 'collections.show',
        abstract:     true
        url:          '/:id',
        templateUrl:  'app/views/collections/show.html',
        controller:   'CollectionsShowCtrl',
        resolve:
          collection: ['$stateParams', 'Collection', ($stateParams, Collection) ->
            Collection.get($stateParams.id).then(
              (col) ->
                collection = col
            )
          ]
      .state 'collections.show.list',
        url:          '/:position',
        templateUrl:  'app/views/collections/list.html'
        controller:   'CollectionsListCtrl'
      .state 'admin',
        abstract:     true,
        url:          '/admin',
        templateUrl:  'app/views/admin/base.html',
        controller:   'AdminCtrl',
        resolve:
          auth: ($auth) ->
            $auth.validateUser().then (u) ->
      .state 'admin.dashboard',
        url:          '/dashboard',
        templateUrl:  'app/views/admin/dashboard.html'
        controller:   'AdminDashboardCtrl'
      .state 'admin.players',
        url:          '/players/:id',
        templateUrl:  'app/views/admin/players.html',
        controller:   'AdminPlayersCtrl'

    $urlRouterProvider.otherwise '/'

  .factory 'Collection', (RailsResource, railsSerializer) ->
    class Collection extends RailsResource
      @configure
        url: '/api/collections',
        name: 'collection',
        serializer: railsSerializer () ->
          this.resource 'sheets', 'Sheet'
          this.only 'name', 'ppr', 'dup_id'

  .factory 'Sheet', (RailsResource, railsSerializer) ->
    class Sheet extends RailsResource
      @configure
        url: '/api/sheets',
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

Array.prototype.move = (from, to) ->
  tmp = this[from]

  if from < to
    for i in [from..to]
      this[i] = this[i + 1]

  else
    for i in [from..to]
      this[i] = this[i - 1]

  this[to] = tmp
