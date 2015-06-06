angular.module "draftPlanner"
  .controller "NavbarCtrl", ['$scope', '$rootScope', '$state', 'Collection', ($scope, $rootScope, $state, Collection) ->

    Collection.query({ id: $scope.user.id }).then(
      (cols) ->
        $scope.collections = cols
      (error) ->
        console.log 'failed to load collections - navbar'
        console.log error
    )

    $rootScope.$on 'auth:logout-success', (evt) ->
      console.log 'signed out'
      console.log evt
      $state.go 'home'

    $('.ui.dropdown').dropdown
      on: 'hover'
  ]
