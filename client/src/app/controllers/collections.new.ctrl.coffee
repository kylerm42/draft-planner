angular.module "draftPlanner"
  .controller "CollectionsNewCtrl",
    ['$scope', '$rootScope', '$state', 'loaders', 'Collection',
    ($scope, $rootScope, $state, loaders, Collection) ->

      $scope.handleCollectionCreation = () ->
        $('#collectionSegment').addClass('loading')
        loaders.fabLoading()
        $scope.collection.create().then(
          (collection) ->
            $rootScope.collections.push collection
            $state.go 'collections.show.list', id: collection.id, position: 'qb'
          (error) ->
            loaders.fabError()
            console.log 'error creating collection'
            console.log error
        )

      $scope.collection = new Collection
        ppr: 0

      Collection.query().then(
        (collections) ->
          $('.dropdown').dropdown()
          $('#collectionSegment').removeClass('loading')
          loaders.pageLoaded()
          $scope.collections = collections
        (error) ->
          loaders.fabError()
          console.log 'error loading collections'
          console.log error
      )
    ]
