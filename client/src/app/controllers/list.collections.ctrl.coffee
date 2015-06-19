angular.module "draftPlanner"
  .controller "ListCollectionsCtrl",
    ['$scope', '$stateParams', 'Player', 'Tag', 'collection',
    ($scope, $stateParams, Player, Tag, collection) ->

      # define base variables for the page
      defaultPositions = ['qb', 'rb', 'wr', 'te', 'k', 'def']

      if defaultPositions.indexOf($stateParams.position.toLowerCase()) != -1
        position = $stateParams.position.toLowerCase()
      else
        position = 'qb'

      sheet = null
      players = []
      addPlayers = []
      tags = []

      setBaseValues = () ->
        sheet = $.grep collection.sheets, (sht) ->
          sht.position == position.toUpperCase()
        sheet = sheet[0]
        players = sheet.players
        tags = sheet.tags

      assignTags = () ->
        $.each tags, (idx, tag) ->
          chosenOne = $.grep players.concat(addPlayers), (player) ->
            player.id == tag.playerId

          chosenOne[0].tag = tag unless chosenOne.length == 0

      sortPlayers = () ->
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

      getAddPlayers = () ->
        Player.query({ missingFromSheet: sheet.id }).then(
          (p) ->
            $.each p, (idx, player) ->
              player.tag = new Tag({
                sheetId: sheet.id
                playerId: player.id
              })
              addPlayerToDropdown(player)
              addPlayers.push player

            assignTags()

            $('#addDropdown .default.text').text('Choose a player')
            $('#addDropdown').removeClass 'disabled'
            $('#addDropdown').dropdown()
          (error) ->
            $('#addDropdown').addClass 'error'
            $('#addDropdown .default.text').text('Error loading players')
            handleError error, 'Error loading players to add'
        )

      addPlayerToDropdown = (player) ->
        $playerOption = $('<div class="item" data-value="' + player.name + '"><span class="right floated description">' +
          player.position + " - " + player.team + "</span>" + player.name + "</div>")

        $('#addDropdown .menu').append $playerOption

      # save sheets
      saveSheet = (evt) ->
        fabLoading()
        sheet.ranks = $('.item[data-player-id]').map((idx, val) -> $(val).data('player-id')).toArray()
        sheet.update().then(
          (s) ->
            fabSuccess()
          (error) ->
            handleError error, 'Error updating sheet'
        )

      # handle tag saving/updating
      saveTag = (tag) ->
        fabLoading()
        tag.save().then(
          (t) ->
            fabSuccess()
          (error) ->
            handleError error, 'Error saving tag'
        )

      fabLoading = () ->
        $('#save-button i').addClass('blue loading asterisk')
        $('#save-button i').removeClass('green checkmark')

      fabSuccess = () ->
        $('#save-button i').addClass('green checkmark')
        $('#save-button i').removeClass('blue loading asterisk')

      fabError = () ->
        $('#save-button i').addClass('red bomb')
        $('#save-button i').removeClass('green checkmark blue loading asterisk')

      handleError = (error, message) ->
        fabError()
        flash('Sorry, something blew up!', message)
        console.log error

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

      $scope.saveTag = (tag) -> saveTag(tag)

      $scope.handleTagClick = (tagName, tag, $event) ->
        tag[tagName] = !tag[tagName]
        saveTag(tag)

      $scope.getRank = (playerId) ->
        $('.item[data-player-id=' + playerId + ']').index() + 1

      $scope.removePlayer = (player) ->
        idx = $scope.sortedPlayers.indexOf(player)
        $scope.sortedPlayers.splice(idx, 1)
        addPlayers.push player

        addPlayerToDropdown(player)

        setTimeout saveSheet, 50

      $scope.addPlayer = () ->
        return unless $('#addInput').val().length > 0
        playerName = $('#addInput').val()
        player = $.grep addPlayers, (p) ->
          p.name == playerName
        player = player[0]
        player.points = parseFloat(player.points)

        idx = addPlayers.indexOf(player)
        addPlayers.splice(idx, 1)
        $scope.sortedPlayers.push(player)
        players.push player

        $('#addDropdown').dropdown('clear')

        setTimeout(
          () ->
            $('.label-tags .blue.tag').popup
              on: 'click'
              inline: true
              transition: 'fade up'
            saveSheet()
          50
        )

      setBaseValues()
      sortPlayers()
      getAddPlayers()

      setTimeout(
        () ->
          # remove loaders
          $('#collectionSegment').removeClass('loading')
          fabSuccess()

          # set ui inputs
          $('.label-tags .blue.tag').popup
            on: 'click'
            inline: true
            transition: 'fade up'
        50
      )

      # sortable options
      rankSortable = new Sortable sortedList, {
        animation: 50
        ghostClass: 'ghost'
        handle: '.sortable-handle'
        draggable: '.item'
        filter: '.removed'
        onSort: saveSheet
      }
    ]
