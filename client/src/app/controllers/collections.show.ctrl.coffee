angular.module "draftPlanner"
  .controller "CollectionsShowCtrl",
    ['$scope', '$rootScope', 'loaders', 'collection',
    ($scope, $rootScope, loaders, collection) ->

      # define collection for the page
      $scope.collection = collection
      $scope.byes =
        { 'ARI': 4, 'ATL': 9, 'BAL': 11, 'BUF': 9, 'CAR': 12, 'CHI': 9, 'CIN': 4, 'CLE': 4, 'DAL': 11, 'DEN': 4, 'DET': 9,
        'GB':  9, 'HOU': 10, 'IND': 10, 'JAC': 11, 'KC':  6, 'MIA': 5, 'MIN': 10, 'NE':  10, 'NO':  6, 'NYG': 8, 'NYJ': 11,
        'OAK': 5, 'PHI': 7, 'PIT': 12, 'SD':  10, 'STL': 4, 'SF':  8, 'SEA': 4, 'TB':  7, 'TEN': 9, 'WAS': 10, 'FA': 'N/A' }

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

      # save collection
      saveCollection = (collection) ->
        loaders.fabLoading()
        collection.save().then(
          (c) ->
            loaders.fabSuccess()
            loaders.flash 'success', 'Settings saved', 1500
          (error) ->
            loaders.handleError error, 'Error updating collection'
        )

      $scope.evaluate = (number) ->
        if isNaN(number)
          0
        else
          number.toFixed(1)

      $scope.showModal = (player) ->
        $scope.modalPlayer = player
        $('#player-modal').modal('show')

        player.get().then(
          (p) -> console.log player
          (error) ->
            loaders.handleError error, 'Error fetching player'
        )
    ]
