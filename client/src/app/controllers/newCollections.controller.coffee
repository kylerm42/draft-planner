angular.module "draftPlanner"
  .controller "NewCollectionsCtrl", ['$scope', '$rootScope', '$state', 'Collection', ($scope, $rootScope, $state, Collection) ->

    $('.ui.segment .ui.dimmer').dimmer('show')

    $scope.collection = new Collection
      ppr: 0

    $scope.handleCollectionCreation = () ->
      $('.ui.segment .ui.dimmer').dimmer('show')
      $scope.collection.create().then(
        (collection) ->
          $('.ui.segment .ui.dimmer').dimmer('hide')
          $rootScope.collections.push collection
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
