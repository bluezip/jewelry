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
app.controller('Gallery',($scope,$http)->
  $http.get("json/gallery.json").success((data)->
    $scope.images = data;
    $scope.default_images = $scope.images[0];
  );
  $scope.change = (img) ->
    $scope.default_images = img;
)



## popup
$('body').on('click','.link-forgot-password',->
  html = $('#forgot-password').html();
  WPopup::html(html,160);
  false
)
$('body').on('click','.link-new-customer',->
  html = $('#new-customer').html()
  WPopup::html(html,220);
  false
)

$('body').on('click','.wrapper-for-forgot-password button[type=submit]',->
  html = $('#send-email-reset').html();
  WPopup::html(html,160);
  WPopup::auto_close(2000);
  false

)

$('body').on('click','#cboxContent .close-popup',->
  WPopup::close();
)