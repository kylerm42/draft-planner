angular.module "draftPlanner"
  .controller "NavbarCtrl",
    ['$scope', '$rootScope', '$state', '$auth', 'loaders', 'Collection',
    ($scope, $rootScope, $state, $auth, loaders, Collection) ->

      getCollections = (id) ->
        Collection.query({ userId: id }).then(
          (cols) ->
            $rootScope.collections = cols
          (error) ->
            console.log 'failed to load collections - navbar'
            console.log error
        )

      $scope.handleSignOut = () ->
        $state.go 'home'
        $auth.signOut()

      $('.ui.dropdown').dropdown
        on: 'hover'

      # login/out event handling
      $rootScope.$on 'auth:validation-success', (evt) ->
        $rootScope.user = evt.targetScope.user

        getCollections($rootScope.user.id)

      $rootScope.$on 'auth:login-success', (evt) ->
        $rootScope.user = evt.targetScope.user

        getCollections($rootScope.user.id)

      # state change event handling
      $rootScope.$on '$stateChangeStart', (evt, toState, toParams, fromState, fromParams) ->
        console.log 'state change start'
        loaders.fabLoading()
        loaders.segmentLoading()
    ]
