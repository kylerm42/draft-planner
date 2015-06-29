angular.module 'draftPlanner'
  .controller 'CollectionsListCtrl',
    ['$scope', '$stateParams', 'loaders', 'Player', 'Tag', 'collection',
    ($scope, $stateParams, loaders, Player, Tag, collection) ->

      # define base variables for the page
      defaultPositions = ['QB', 'RB', 'WR', 'TE', 'K', 'DEF']

      if defaultPositions.indexOf($stateParams.position.toUpperCase()) != -1
        position = $stateParams.position.toUpperCase()
      else
        position = 'QB'

      sheet = null
      players = []
      unlistedPlayers = []
      tags = []

      setBaseValues = () ->
        sheet = $.grep collection.sheets, (sht) ->
          sht.position == position
        sheet = sheet[0]
        players = sheet.players
        tags = sheet.tags

      assignTags = () ->
        $.each tags, (idx, tag) ->
          chosenOne = $.grep players.concat(unlistedPlayers), (player) ->
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

      getUnlistedPlayers = () ->
        Player.query({ missingFromSheet: sheet.id }).then(
          (p) ->
            $.each p, (idx, player) ->
              player.tag = new Tag({
                sheetId: sheet.id
                playerId: player.id
              })
              addPlayerToDropdown(player)
              unlistedPlayers.push player

            assignTags()

            $('#unlisted-dropdown .default.text').text('Choose a player')
            $('#unlisted-dropdown').removeClass 'disabled'
            $('#unlisted-dropdown').dropdown({
              fullTextSearch: true
            })
          (error) ->
            $('#unlisted-dropdown').addClass 'error'
            $('#unlisted-dropdown .default.text').text('Error loading players')
            loaders.handleError error, 'Error loading players to add'
        )

      addPlayertoList = (player) ->
        console.log player
        $playerRow = $('#sortedList .item').last().clone()
        $playerRow.attr('data-player-id', player.id)
        console.log $playerRow.find('.team-logo').removeAttr('ng-src').attr('src',
          "assets/images/nfl_logos/#{player.team.toLowerCase()}.png")
        console.log $playerRow.find('.name').text(player.name)

      addPlayerToDropdown = (player) ->
        $playerOption = $("<div class='item' data-value='#{player.name}' data-player-id='#{player.id}'>" +
          "<span class='right floated description'>#{player.position} - #{player.team}</span>#{player.name}</div>")

        $('#unlisted-dropdown .menu').append $playerOption

      # save sheets
      saveSheet = (evt) ->
        loaders.fabLoading()
        sheet.ranks = $('#sortedList .item[data-player-id]').map((idx, val) -> $(val).data('player-id')).toArray()
        sheet.update().then(
          (s) ->
            loaders.fabSuccess()
          (error) ->
            loaders.handleError error, 'Error updating sheet'
        )

      # handle tag saving/updating
      saveTag = (tag) ->
        loaders.fabLoading()
        tag.save().then(
          (t) ->
            loaders.fabSuccess()
          (error) ->
            loaders.handleError error, 'Error saving tag'
        )

      $scope.saveTag = (tag) -> saveTag(tag)

      $scope.handleTagClick = (tagName, tag, $event) ->
        tag[tagName] = !tag[tagName]
        saveTag(tag)

      $scope.getRank = (playerId) ->
        $('.item[data-player-id=' + playerId + ']').index() + 1

      $scope.removePlayer = (player) ->
        idx = $scope.sortedPlayers.indexOf(player)
        $("#sortedList .item[data-player-id='#{player.id}']").remove()
        unlistedPlayers.push player

        addPlayerToDropdown(player)

        setTimeout saveSheet, 50

      $scope.addPlayer = () ->
        return unless $('#unlisted-input').val().length > 0
        playerName = $('#unlisted-input').val()
        player = $.grep unlistedPlayers, (p) ->
          p.name == playerName
        player = player[0]
        player.points = parseFloat(player.points)

        idx = unlistedPlayers.indexOf(player)
        unlistedPlayers.splice(idx, 1)
        addPlayertoList(player)

        $('#unlisted-dropdown').dropdown('clear')
        $("#unlisted-dropdown .item[data-player-id='#{player.id}']").remove()

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
      getUnlistedPlayers()

      setTimeout(
        () ->
          # set ui inputs
          $('.label-tags .blue.tag').popup
            on: 'click'
            inline: true
            transition: 'fade up'

          # remove loaders
          loaders.pageLoaded()
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
