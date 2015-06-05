angular.module "draftPlanner"
  .controller "NavbarCtrl", ['$scope', ($scope) ->

    $('.ui.dropdown').dropdown
      on: 'hover'
  ]
