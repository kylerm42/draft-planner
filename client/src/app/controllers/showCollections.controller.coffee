angular.module "draftPlanner"
  .controller "ShowCollectionsCtrl",
    ['$scope', '$state', '$stateParams', 'Collection', 'Sheet', 'Player', ($scope, $state, $stateParams, Collection, Sheet, Player) ->

      # define sheet for the page
      sheet = null

      # get collection
      Collection.get($stateParams.id).then(
        (collection) ->
          $scope.collection = collection
        (error) ->
          console.log error
          $state.go 'home'
      )

      #update position and sheet methods
      $scope.updatePosition = (pos) ->
        $('.ui.segment .ui.dimmer').dimmer('show')

        $scope.activePos = pos
        Sheet.get({ collectionId: $stateParams.id, position: pos }).then(
          (newSheet) ->
            sheet = newSheet
            players = sheet.players
            $scope.sortedPlayers = sheet.ranks.map (id) ->
              chosenOne = $.grep players, (player) ->
                player.id == id
              chosenOne = chosenOne[0]
            $('.ui.segment .ui.dimmer').dimmer('hide')
          (error) ->
            console.log error
            $state.go 'home'
        )

      updateSheet = (evt) ->
        $('#save-button i').toggleClass('green red checkmark spinner loading')
        sheet.ranks = $scope.sortedPlayers.map (player) ->
          player.id
        sheet.$patch('/api/sheets/' + sheet.id).then (s) ->
          $('#save-button i').toggleClass('green red checkmark spinner loading')
          console.log 'saved!'

      $scope.updatePosition($stateParams.position.toLowerCase() || 'rb')

      # sortable options
      $scope.rankSortable = {
        animation: 50
        ghostClass: 'ghost'
        handle: '.sortable-handle'
        draggable: '.item'
        onSort: updateSheet
      }
    ]
