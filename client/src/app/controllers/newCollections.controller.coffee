angular.module "draftPlanner"
  .controller "NewCollectionsCtrl", ['$scope', '$state', 'Collection', ($scope, $state, Collection) ->

    $('.ui.segment .ui.dimmer').dimmer('show')

    $scope.collection = new Collection()

    $scope.handleCollectionCreation = () ->
      $scope.collection.create().then(
        (collection) ->
          console.log 'collection created'
          $state.go 'collections.show', id: collection.id
        (error) ->
          console.log 'error creating collection'
          console.log error
      )

    Collection.query().then(
      (collections) ->
        $('.dropdown').dropdown()
        $('.ui.segment .ui.dimmer').dimmer('hide')
        $scope.collections = collections
      (error) ->
        console.log 'error loading collections'
        console.log error
    )
  ]
