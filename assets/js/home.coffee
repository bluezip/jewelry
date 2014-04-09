$ =jQuery;

'use strict';

app = angular.module 'HomeApp', ['ngRoute','ui.router'], ()->

app.config(['$stateProvider', '$locationProvider',() ->

]);

app.controller('Collection',($scope,$http)->
  $http.get("json/collection.json").success((data)->
    $scope.lists  = data;
  );

)

app.controller('Language',($scope,$http)->
  $http.get("json/language.json").success((data)->
    $scope.list_select  = data;
    _default = _.where($scope.list_select, {default : true});
    $scope.default_data = _default[0];
  );

  $scope.isActive = (code) ->
    code == $scope.default_data.code;
)


app.controller('Currency',($scope,$http)->
  $http.get("json/currency.json").success((data)->
    $scope.list_select  = data;

    _default = _.where($scope.list_select, {default : true});
    $scope.default_data = _default[0];
  );

  $scope.isActive = (code) ->
    code == $scope.default_data.code;
)

app.controller('Notice',($scope,$http)->
  $http.get("json/notice.json").success((data)->
    $scope.data  = data;
  );
)