angular.module "draftPlanner"
  .controller "NewCollectionsCtrl",
    ['$scope', '$rootScope', '$state', 'Collection',
    ($scope, $rootScope, $state, Collection) ->

      fabLoading = () ->
        $('#save-button i').addClass('blue loading asterisk')
        $('#save-button i').removeClass('green checkmark')

      fabSuccess = () ->
        $('#save-button i').addClass('green checkmark')
        $('#save-button i').removeClass('blue loading asterisk')

      fabError = () ->
        $('#save-button i').addClass('red bomb')
        $('#save-button i').removeClass('green checkmark blue loading asterisk')

      $scope.handleCollectionCreation = () ->
        $('#collectionSegment').addClass('loading')
        fabLoading()
        $scope.collection.create().then(
          (collection) ->
            $rootScope.collections.push collection
            $state.go 'collections.show.list', id: collection.id, position: 'qb'
          (error) ->
            fabError()
            console.log 'error creating collection'
            console.log error
        )

      $('#collectionSegment').addClass('loading')
      fabLoading()

      $scope.collection = new Collection
        ppr: 0

      Collection.query().then(
        (collections) ->
          $('.dropdown').dropdown()
          $('#collectionSegment').removeClass('loading')
          fabSuccess()
          $scope.collections = collections
        (error) ->
          fabError()
          console.log 'error loading collections'
          console.log error
      )
    ]
