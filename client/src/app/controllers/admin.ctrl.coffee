angular.module 'draftPlanner'
  .controller 'AdminCtrl',
    ['$auth', '$state',
    ($auth, $state) ->
      $state.go 'home' unless $auth.user.admin
    ]
