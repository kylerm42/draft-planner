angular.module "draftPlanner"
  .controller "NavbarCtrl", ['$scope', '$rootScope', '$state', ($scope, $rootScope, $state) ->

    $rootScope.$on 'auth:logout-success', (evt) ->
      console.log 'signed out'
      console.log evt
      $state.go 'home'

    $('.ui.dropdown').dropdown
      on: 'hover'
  ]
