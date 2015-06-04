angular.module "draftPlanner"
  .controller "ShowCollectionsCtrl",
    ['$scope', '$state', '$stateParams', 'Collection', 'Sheet', 'Player', ($scope, $state, $stateParams, Collection, Sheet, Player) ->

      $scope.updateSheet = (pos) ->
        $('.divided.list .ui.dimmer').dimmer('show')

        $scope.activePos = pos
        Sheet.get({ collectionId: $stateParams.id, position: pos }).then (sheet) ->
          $scope.sheet = sheet
          $('.divided.list .ui.dimmer').dimmer('hide')
          console.log sheet
          console.log sheet.players[0]

      $scope.updateSheet($stateParams.position.toLowerCase())

      $scope.rankSortable = {
        animation: 250,
        ghostClass: 'ghost',
        handle: '.sortable-handle'
      }

      Collection.get($stateParams.id).then (collection) ->
        $scope.collection = collection
        console.log collection
    ]
