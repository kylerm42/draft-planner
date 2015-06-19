angular.module "draftPlanner"
  .controller "HomeCtrl", ['$scope', 'Player', 'Sheet', 'Tag', ($scope, Player, Sheet, Tag) ->

    $scope.byes =
      { 'ARI': 4, 'ATL': 9, 'BAL': 11, 'BUF': 9, 'CAR': 12, 'CHI': 9, 'CIN': 4, 'CLE': 4, 'DAL': 11, 'DEN': 4, 'DET': 9,
      'GB':  9, 'HOU': 10, 'IND': 10, 'JAC': 11, 'KC':  6, 'MIA': 5, 'MIN': 10, 'NE':  10, 'NO':  6, 'NYG': 8, 'NYJ': 11,
      'OAK': 5, 'PHI': 7, 'PIT': 12, 'SD':  10, 'STL': 4, 'SF':  8, 'SEA': 4, 'TB':  7, 'TEN': 9, 'WAS': 10 }
    $scope.removedPlayers = []
    $scope.sortedPlayers = []
    $scope.ppr = 0

    Sheet.get({ id: 2 }).then (sheet) ->
      sheet.ppr = 0
      players = sheet.players
      tags = sheet.tags

      $.each tags, (idx, tag) ->
        chosenOne = $.grep players, (player) ->
          player.id == tag.playerId
        chosenOne[0].tag = tag

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

        if chosenOne.tag.removed
          $scope.removedPlayers.push chosenOne
        else
          $scope.sortedPlayers.push chosenOne

      setTimeout(
        () ->
          $('.label-tags .blue.tag').popup
            on: 'click'
            inline: true
            transition: 'fade up'
        5
      )

    $scope.handleTagClick = (tagName, tag, $event) ->
      tag[tagName] = !tag[tagName]

    $scope.showModal = (player) ->
      $scope.modalPlayer = player
      $('#player-modal').modal('show')

      player.get()

    $scope.evaluate = (number) ->
      if isNaN(number)
        0
      else
        number.toFixed(1)

    $scope.removePlayer = (player, idx) ->
      if player.tag.removed
        $scope.removedPlayers.splice(idx, 1)
        $scope.sortedPlayers.push(player)
        player.tag.removed = false
      else
        $scope.sortedPlayers.splice(idx, 1)
        $scope.removedPlayers.push(player)
        player.tag.removed = true

    # sortable options
    rankSortable = new Sortable(sortableList, {
      animation: 50
      ghostClass: 'ghost'
      handle: '.sortable-handle'
      draggable: '.item'
      filter: '.removed'
    })
  ]
