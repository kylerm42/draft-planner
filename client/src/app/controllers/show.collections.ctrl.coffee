angular.module "draftPlanner"
  .controller "ShowCollectionsCtrl",
    ['$scope', '$rootScope', 'collection',
    ($scope, $rootScope, collection) ->

      # define collection for the page
      $scope.collection = collection
      $scope.byes =
        { 'ARI': 4, 'ATL': 9, 'BAL': 11, 'BUF': 9, 'CAR': 12, 'CHI': 9, 'CIN': 4, 'CLE': 4, 'DAL': 11, 'DEN': 4, 'DET': 9,
        'GB':  9, 'HOU': 10, 'IND': 10, 'JAC': 11, 'KC':  6, 'MIA': 5, 'MIN': 10, 'NE':  10, 'NO':  6, 'NYG': 8, 'NYJ': 11,
        'OAK': 5, 'PHI': 7, 'PIT': 12, 'SD':  10, 'STL': 4, 'SF':  8, 'SEA': 4, 'TB':  7, 'TEN': 9, 'WAS': 10 }

      $('#collectionSegment').addClass('loading')
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

      # save collection
      saveCollection = (collection) ->
        fabLoading()
        collection.save().then(
          (c) ->
            fabSuccess()
            flash 'success', 'Settings saved', 1500
          (error) ->
            handleError error, 'Error updating collection'
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
          (p) ->
          (error) ->
            handleError error, 'Error fetching player'
        )

      $rootScope.$on '$stateChangeStart', (evt, toState, toParams, fromState, fromParams) ->
        fabLoading()
        $('#collectionSegment').addClass('loading')
    ]
