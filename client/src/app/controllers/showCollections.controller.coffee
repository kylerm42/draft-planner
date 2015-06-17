angular.module "draftPlanner"
  .controller "ShowCollectionsCtrl",
    ['$scope', '$state', '$stateParams', 'Collection', 'Sheet', 'Player', 'Tag',
    ($scope, $state, $stateParams, Collection, Sheet, Player, Tag) ->

      # define sheet for the page
      sheet = null
      collection = null
      $scope.byes =
        { 'ARI': 4, 'ATL': 9, 'BAL': 11, 'BUF': 9, 'CAR': 12, 'CHI': 9, 'CIN': 4, 'CLE': 4, 'DAL': 11, 'DEN': 4, 'DET': 9,
        'GB':  9, 'HOU': 10, 'IND': 10, 'JAC': 11, 'KC':  6, 'MIA': 5, 'MIN': 10, 'NE':  10, 'NO':  6, 'NYG': 8, 'NYJ': 11,
        'OAK': 5, 'PHI': 7, 'PIT': 12, 'SD':  10, 'STL': 4, 'SF':  8, 'SEA': 4, 'TB':  7, 'TEN': 9, 'WAS': 10 }

      $('#list .ui.dimmer').dimmer('show')
      $('#collection-edit').popup
        on: 'click'
        inline: true
        transition: 'fade down'
        position: 'bottom left'
        offset: -10
        onHidden: (node) ->
          saveCollection(collection)
      $('#collection-ppr').dropdown
        on: 'click'
      $scope.flash = {}

      # flash messages
      flash = (type, message, timeout) ->
        console.log type + ': ' + message
        $('#save-button').popup
          title: type[0].toUpperCase() + type.slice(1)
          content: message
          position: 'top right'
          offset: '-15'
          on: 'manual'
        $('#save-button').popup('show')

        if timeout
          setTimeout(
            () -> $('#save-button').popup('hide')
            timeout
          )

      handleError = (error, message) ->
        $('#save-button i').removeClass('green checkmark blue loading asterisk')
        $('#save-button i').addClass('red x')
        flash('error', message)
        console.log error

      # save collection
      saveCollection = (collection) ->
        collection.save().then(
          (c) ->
            flash 'success', 'Settings saved', 1500
          (error) ->
            handleError error, 'Error updating collection'
        )

      # save sheets
      saveSheet = (evt) ->
        $('#save-button i').toggleClass('green blue checkmark asterisk loading')
        sheet.ranks = $('.item[data-player-id]').map((idx, val) -> $(val).data('player-id')).toArray()
        sheet.update().then(
          (s) ->
            $('#save-button i').toggleClass('green blue checkmark asterisk loading')
          (error) ->
            handleError error, 'Error updating sheet'
        )

      # handle tag saving/updating
      saveTag = (tag) ->
        $('#save-button i').toggleClass('green blue checkmark asterisk loading')
        tag.save().then(
          (t) ->
            $('#save-button i').toggleClass('green blue checkmark asterisk loading')
          (error) ->
            handleError error, 'Error saving tag'
        )

      $scope.saveTag = (tag) -> saveTag(tag)

      $scope.handleTagClick = (tagName, tag, $event) ->
        tag[tagName] = !tag[tagName]
        saveTag(tag)

      # update selected position
      $scope.updatePosition = (pos) ->
        if pos == $scope.activePos
          return

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

        $scope.sortedPlayers = []
        sheet.ranks.forEach (id) ->
          chosenOne = $.grep players, (player) ->
            if !player.tag
              player.tag = new Tag({
                sheetId: sheet.id
                playerId: player.id
              })
            player.id == id
          chosenOne = chosenOne[0]
          chosenOne.points = parseFloat(chosenOne.points)

          $scope.sortedPlayers.push chosenOne

        $('#list .ui.dimmer').dimmer('hide')

        setTimeout(
          () ->
            $('.label-tags .blue.tag').popup
              on: 'click'
              inline: true
              transition: 'fade up'
          5
        )

      $scope.showModal = (player) ->
        $scope.modalPlayer = player
        $('#player-modal').modal('show')

        player.get().then(
          (p) ->
          (error) ->
            handleError error, 'Error fetching player'
        )

      $scope.evaluate = (number) ->
        if isNaN(number)
          0
        else
          number.toFixed(1)

      $scope.removePlayer = (playerId) ->
        idx = sheet.ranks.indexOf(playerId)
        console.log idx
        sheet.ranks.splice(idx, 1)

        $('.item[data-player-id=' + playerId + ']').remove()

        saveSheet()

      $scope.getRank = (playerId) ->
        $('.item[data-player-id=' + playerId + ']').index() + 1

      # get collection
      Collection.get($stateParams.id).then(
        (col) ->
          collection = col
          $scope.collection = col
          $scope.updatePosition($stateParams.position.toLowerCase() || 'rb')

          $('#list .ui.dimmer').dimmer('hide')
        (error) ->
          handleError error, 'Error loading collection'
          $state.go 'home'
      )

      # sortable options
      $scope.rankSortable = {
        animation: 50
        ghostClass: 'ghost'
        handle: '.sortable-handle'
        draggable: '.item'
        filter: '.removed'
        onSort: saveSheet
      }
    ]
