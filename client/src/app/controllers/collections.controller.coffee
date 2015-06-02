angular.module "draftPlanner"
  .controller "NewCollectionsCtrl", ['$scope', '$state', 'Collection', ($scope, $state, Collection) ->

    $scope.collection = new Collection()

    $scope.handleCollectionCreation = () ->
      $scope.collection.create().then (collection) ->
        $state.go 'collections.show', id: collection.id

    Collection.query({ default: true })
      .then (collections) ->
        console.log collections
        $scope.collections = collections
        $('.dropdown').dropdown()
  ]
