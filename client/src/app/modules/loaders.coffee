angular.module 'draftPlanner'
  .factory 'loaders', () ->

    {
      fabLoading: () ->
        $('#save-button i').addClass('blue loading asterisk')
        $('#save-button i').removeClass('green checkmark')

      fabSuccess: () ->
        $('#save-button i').addClass('green checkmark')
        $('#save-button i').removeClass('blue loading asterisk')
        $('#save-button').popup
          title: "You're all good!"
          content: 'Everything is saved and up to date'
          position: 'top right'
          transition: 'fade up'
          offset: '-15'
          on: 'hover'
          variation: 'small'

      fabError: () ->
        $('#save-button i').addClass('red bomb')
        $('#save-button i').removeClass('green checkmark blue loading asterisk')

      segmentLoading: () ->
        $('main-segment').addClass('loading')

      segmentClear: () ->
        $('#main-segment').removeClass('loading')

      pageLoaded: () ->
        this.fabSuccess()
        this.segmentClear()

      handleError: (error, message) ->
        this.fabError()
        flash('Sorry, something blew up!', message)
        console.log error

      # flash messages
      flash: (type, message, timeout = 0) ->
        console.log type + ': ' + message
        $('#save-button').popup
          title: type[0].toUpperCase() + type.slice(1)
          content: message
          position: 'top right'
          offset: '-15'
          transition: 'fade up'
          on: 'manual'
        $('#save-button').popup('show')

        setTimeout(
          () -> $('#save-button').popup('hide')
          timeout
        )
    }
