angular.module "draftPlanner"
  .controller "AdminDashboardCtrl",
    ['$scope', '$state', '$http', 'loaders', 'Player',
    ($scope, $state, $http, loaders, Player) ->

      setStats = (data) ->
        stats = data
        $scope.users = stats.user
        $scope.collections = stats.collection
        $scope.tags = stats.tag
        $scope.players = stats.player
        loaders.pageLoaded()

        $('#addDropdown .menu').append $playerOption

      playerSelect = (value, text, $choice) ->
        $state.go 'admin.players', { id: $choice.data('id') }

      $scope.showPlayerDropdown = () ->
        $('#edit-player-row').toggleClass('hide')
        Player.query().then(
          (p) ->
            $.each p, (idx, player) ->
              $playerOption = $("<div class='item' data-value='#{player.name}' data-id='#{player.id}'>" +
                "<span class='right floated description'>#{player.position} - #{player.team}</span>#{player.name}</div>")

              $('#edit-player-dropdown .menu').append $playerOption

            $('#edit-player-dropdown .default.text').text 'Choose a player to edit'
            $('#edit-player-dropdown').removeClass 'disabled'
            $('#edit-player-dropdown').dropdown({
              forceSelection: false,
              fullTextSearch: true,
              onChange: playerSelect
            })
          (error) ->
            $('#edit-player-dropdown').addClass 'error'
            $('#edit-player-dropdown .default.text').text('Error loading players')
            handleError error, 'Error loading players to add'
        )

      stats = null
      $http.get('/api/admin/stats').success setStats
    ]
