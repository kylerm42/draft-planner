angular.module "draftPlanner"
  .controller "NavbarCtrl",
    ['$scope', '$rootScope', '$state', '$auth', 'Collection',
    ($scope, $rootScope, $state, $auth, Collection) ->

      $rootScope.$on 'auth:logout-success', (evt) ->
        $state.go 'home'

      $rootScope.$on 'auth:validation-success', (evt) ->
        $rootScope.user = evt.targetScope.user

        getCollections($rootScope.user.id)

      $rootScope.$on 'auth:login-success', (evt) ->
        $rootScope.user = evt.targetScope.user

        getCollections($rootScope.user.id)

      getCollections = (id) ->
        Collection.query({ userId: id }).then(
          (cols) ->
            $rootScope.collections = cols
          (error) ->
            console.log 'failed to load collections - navbar'
            console.log error
        )

      $('.ui.dropdown').dropdown
        on: 'hover'
    ]
