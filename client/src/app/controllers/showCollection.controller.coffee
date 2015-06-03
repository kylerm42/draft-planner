angular.module "draftPlanner"
  .controller "ShowCollectionsCtrl", ['$scope', '$state', '$stateParams', 'Collection', ($scope, $state, $stateParams, Collection) ->

    $scope.positions = ['qb', 'rb', 'wr', 'te', 'def', 'k']
    $scope.activePos = $stateParams.pos
    $("a.item[data-pos='" + $stateParams.pos + "']").addClass('active')

    Collection.get($stateParams.id).then (collection) ->
      $scope.collection = collection
      console.log collection
  ]
