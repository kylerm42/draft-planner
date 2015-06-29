angular.module "draftPlanner"
  .controller "AdminPlayersCtrl",
    ['$scope', '$auth', '$state', '$stateParams', '$http', 'loaders', 'Player',
    ($scope, $auth, $state, $stateParams, $http, loaders, Player) ->

      $scope.teams = [
        'ARI', 'ATL', 'BAL', 'BUF', 'CAR', 'CHI', 'CIN', 'CLE', 'DAL', 'DEN', 'DET',
        'GB', 'HOU', 'IND', 'JAC', 'KC', 'MIA', 'MIN', 'NE', 'NO', 'NYG', 'NYJ',
        'OAK', 'PHI', 'PIT', 'SD', 'STL', 'SF', 'SEA', 'TB', 'TEN', 'WAS', 'FA'
      ]

      statAttrs = [
        'passYards', 'passTds', 'passInts', 'passComp', 'passAtt', 'fumLost', 'twoPtConv', 'fumRecTd', 'rushAtt',
        'rushYards', 'rushTds', 'receptions', 'recYards', 'recTds', 'madePat', 'missPat', 'madeUnder20', 'missUnder20',
        'made20s', 'miss20s', 'made30s', 'miss30s', 'made40s', 'miss40s', 'made50Plus', 'miss50Plus',
        'sacks', 'interceptions', 'fumRec', 'safeties', 'defTds', 'returnTds', 'ptsAllowed'
      ]

      $scope.updatePoints = () ->
        s = $scope.player.stats
        $scope.player.points = (s.passYards / 25) + (s.passTds * 4) + (s.passInts * -2) + (s.fumLost * -2) + (s.twoPtConv * 2) +
                               (s.fumRecTd * 6) + (s.rushYards / 10) + (s.rushTds * 6) + (s.recYards / 10) + (s.recTds * 6) +
                               (s.madePat * 1) + (s.missPat * -1) + (s.madeUnder20 * 3) + (s.missUnder20 * -1) + (s.made20s * 3) +
                               (s.miss20s * -1) + (s.made30s * 3) + (s.miss30s * -1) + (s.made40s * 4) +
                               (s.miss40s * -1) + (s.made50Plus * 5) + (s.miss50Plus * -1) + (s.sacks * 1) +
                               (s.interceptions * 2) + (s.fumRec * 2) + (s.safeties * 2) + (s.defTds * 6) + (s.returnTds * 6) +
                               (s.ptsAllowed / 16)

        $scope.player.points = $scope.player.points.toFixed(2)

      $scope.handlePlayerSubmit = () ->
        loaders.fabLoading()
        player = $scope.player

        if player.id
          player.$patch("/api/admin/players/#{player.id}").then(
            (p) -> $state.go 'admin.dashboard'
          )
        else
          player.$post('/api/admin/players/').then(
            (p) -> $state.go 'admin.dashboard'
          )

      initializeComponents = () ->
        $('#position-dropdown').dropdown()
        $('#team-dropdown').dropdown()
        loaders.pageLoaded()

      setStats = (player) ->
        stats = {}
        player.stats = {} if player.stats == undefined
        $.each statAttrs, (idx, stat) ->
          stats[stat] = 0

        player.stats = $.extend stats, player.stats

      if $stateParams.id == 'new'
        $scope.player = new Player
        setStats($scope.player)

        $scope.updatePoints()
        setTimeout initializeComponents, 5
      else
        player = new Player id: $stateParams.id
        player.get().then(
          (p) ->
            p.points = parseFloat(player.points)
            setStats(p)
            $scope.player = p
            setTimeout initializeComponents, 5
          (error) ->
            handleError error, 'Error fetching player'
        )

    ]
