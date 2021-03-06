angular.module 'draftPlanner'
  .controller 'HomeCtrl', ['$scope', 'loaders', 'Player', 'Sheet', 'Tag',
    ($scope, loaders, Player, Sheet, Tag) ->

      $scope.ppr = 0
      $scope.byes = {
        'ARI': 4, 'ATL': 9, 'BAL': 11, 'BUF': 9, 'CAR': 12, 'CHI': 9, 'CIN': 4, 'CLE': 4, 'DAL': 11, 'DEN': 4, 'DET': 9,
        'GB':  9, 'HOU': 10, 'IND': 10, 'JAC': 11, 'KC':  6, 'MIA': 5, 'MIN': 10, 'NE':  10, 'NO':  6, 'NYG': 8, 'NYJ': 11,
        'OAK': 5, 'PHI': 7, 'PIT': 12, 'SD':  10, 'STL': 4, 'SF':  8, 'SEA': 4, 'TB':  7, 'TEN': 9, 'WAS': 10
      }

      sheet = null
      players = []
      unlistedPlayers = []
      tags = []

      setBaseValues = () ->
        Sheet.get({ id: 2 }).then (s) ->
          sheet = s
          players = sheet.players
          tags = sheet.tags
          sortPlayers()
          getUnlistedPlayers()

      assignTags = () ->
        $.each tags, (idx, tag) ->
          chosenOne = $.grep players.concat(unlistedPlayers), (player) ->
            player.id == tag.playerId

          chosenOne[0].tag = tag unless chosenOne.length == 0

      sortPlayers = () ->
        $scope.sortedPlayers = []
        sheet.ranks.slice(0, 40).forEach (id) ->
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

      addPlayerToDropdown = (player) ->
        $playerOption = $("<div class='item' data-value='#{player.name}' data-player-id='#{player.id}'>" +
          "<span class='right floated description'>#{player.position} - #{player.team}</span>#{player.name}</div>")

        $('#unlisted-dropdown .menu').append $playerOption

      $scope.handleTagClick = (tagName, tag, $event) ->
        tag[tagName] = !tag[tagName]

      $scope.getRank = (playerId) ->
        $('.item[data-player-id=' + playerId + ']').index() + 1

      $scope.removePlayer = (player) ->
        console.log $scope.sortedPlayers
        idx = $scope.sortedPlayers.indexOf(player)
        $scope.sortedPlayers.splice(idx, 1)
        console.log idx
        console.log $scope.sortedPlayers
        #$("#sortedList .item[data-player-id='#{player.id}']").remove()
        addPlayerToDropdown(player)
        unlistedPlayers.push player

      $scope.addPlayer = () ->
        return unless $('#unlisted-input').val().length > 0
        playerName = $('#unlisted-input').val()
        player = $.grep unlistedPlayers, (p) ->
          p.name == playerName
        player = player[0]
        player.points = parseFloat(player.points)

        idx = unlistedPlayers.indexOf(player)
        unlistedPlayers.splice(idx, 1)
        $scope.sortedPlayers.push(player)
        players.push player

        $('#unlisted-dropdown').dropdown('clear')
        $("#unlisted-dropdown .item[data-player-id='#{player.id}']").remove()

        setTimeout(
          () ->
            $('.label-tags .blue.tag').popup
              on: 'click'
              inline: true
              transition: 'fade up'
          50
        )

      setBaseValues()

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
      }
  ]
