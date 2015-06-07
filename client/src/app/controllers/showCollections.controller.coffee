angular.module "draftPlanner"
  .controller "ShowCollectionsCtrl",
    ['$scope', '$state', '$stateParams', 'Collection', 'Sheet', 'Player', 'Tag',
    ($scope, $state, $stateParams, Collection, Sheet, Player, Tag) ->

      # define sheet for the page
      sheet = null
      collection = null

      $('#list .ui.dimmer').dimmer('show')

      # update selected position
      $scope.updatePosition = (pos) ->
        $('#list .ui.dimmer').dimmer('show')

        $scope.activePos = pos
        sheet = $.grep collection.sheets, (sht) ->
          sht.position == pos.toUpperCase()
        sheet = sheet[0]
        players = sheet.players
        tags = sheet.tags

        $.each tags, (idx, tag) ->
          chosenOne = $.grep players, (player) ->
            player.id == tag.playerId
          chosenOne[0].tag = tag

        $scope.sortedPlayers = sheet.ranks.map (id) ->
          chosenOne = $.grep players, (player) ->
            player.id == id
          chosenOne = chosenOne[0]
        $('#list .ui.dimmer').dimmer('hide')
        null

      # save sheets
      saveSheet = (evt) ->
        $('#save-button i').toggleClass('green blue checkmark asterisk loading')
        sheet.ranks = $scope.sortedPlayers.map (player) ->
          player.id
        sheet.$patch('/api/sheets/' + sheet.id).then(
          (s) ->
            $('#save-button i').toggleClass('green blue checkmark asterisk loading')
            console.log 'saved!'
          (error) ->
            console.log 'error saving sheet'
            console.log error
        )

      $scope.handleTagClick = (tagName, player, $event) ->
        $('#save-button i').toggleClass('green blue checkmark asterisk loading')
        if player.tag
          player.tag[tagName] = !player.tag[tagName]
          player.tag.update().then(
            (t) ->
              $('#save-button i').toggleClass('green blue checkmark asterisk loading')
              console.log 'tag saved!'
              console.log t
            (error) ->
              console.log 'error saving tag'
              console.log error
          )
        else
          tag = new Tag({
            playerId: player.id
            sheetId: sheet.id
          })
          tag[tagName] = true
          player.tag = tag

          tag.create().then(
            (t) ->
              $('#save-button i').toggleClass('green blue checkmark asterisk loading')
              console.log 'tag created'
              console.log t
            (error) ->
              console.log 'error creating tag'
              console.log error
          )

      # get collection
      Collection.get($stateParams.id).then(
        (col) ->
          collection = col
          $scope.collection = col
          $scope.updatePosition($stateParams.position.toLowerCase() || 'rb')

          $('#list .ui.dimmer').dimmer('hide')
        (error) ->
          console.log 'error loading collection'
          console.log error
          $state.go 'home'
      )

      # sortable options
      $scope.rankSortable = {
        animation: 50
        ghostClass: 'ghost'
        handle: '.sortable-handle'
        draggable: '.item'
        onSort: saveSheet
      }
    ]
