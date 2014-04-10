$ =jQuery;

'use strict';

app = angular.module 'HomeApp', ['ngRoute','ui.router'], ()->

app.config(['$stateProvider', '$locationProvider','$urlRouterProvider',($stateProvider,$locationProvider,$urlRouterProvider) ->
  $urlRouterProvider.otherwise('/');
  $stateProvider
    .state('home',{
      url : "/",
      views : {
        left  : {
          templateUrl : 'template/menu-one.html',
        }
        right : {
          templateUrl : 'template/gallery.html',
        }
      }
    });
]);



app.controller('Collection',($scope,$http,$location)->
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
app.controller('Gallery',($scope,$http,$rootScope,$location)->
  _current_image  = 0;
  _count_image    = 0;
  _loop = 0;
  $http.get("json/gallery.json").success((data)->
    $scope.images = data;
    $scope.default_images = $scope.images[_current_image ];
    _count_image = $scope.images.length;
  );
  $scope.change = (img,$index) ->
    _current_image = $index;
    _loop = 0
    completeHandler = ->
      $scope.$apply(->
        $scope.default_images = img;
      )
    TweenLite.to($('.screen'), .5, { opacity:.9,backgroundPosition:'+2048px center', onComplete:completeHandler});
    TweenLite.to($('.screen') , .5, { opacity:1,delay:.5,backgroundPosition:'0px center',});

    false;



  setInterval(->
    if _loop != 0
      _current_image++;
      if(_count_image <= _current_image )
        _current_image = 0;
      completeHandler = ->
        $scope.$apply(->
          $scope.default_images = $scope.images[_current_image]
        )
      TweenLite.to($('.screen'), .5, { opacity:.9,backgroundPosition:'+2048px center', onComplete:completeHandler});
      TweenLite.to($('.screen') , .5, { opacity:1,delay:.5,backgroundPosition:'0px center',});
    _loop++;
  ,5000)
); #End gallery

app.controller('LeftMenu',($scope)->
  $scope.open  = ->
    $('.menu-list').removeClass('hidden-xs');
    $('.open-close .plus').addClass('hidden');
    updateHandler = ->
      $('.slide-left .main-nav').addClass('bg-write');
      $('.open-close .minus').removeClass('hidden');
    TweenLite.to($('.menu-list'), .5, {left:'-=200px',onUpdate:updateHandler()});
    TweenLite.to($('.menu-list') , 1, {left:'0px',delay:.5});

  $scope.close  = ->
    $('.open-close .minus').addClass('hidden');
    $('.menu-list').addClass('hidden-xs');
    updateHandler = ->
      $('.slide-left .main-nav').removeClass('bg-write');
      $('.open-close .plus').removeClass('hidden');

    TweenLite.to($('.menu-list'), 1, {left:'-=200px'});
    TweenLite.to($('.menu-list'),.5,{left:'0px',onUpdate:updateHandler(),delay:1});

);


## popup
$('body').on('click','.link-forgot-password',->
  html = $('#forgot-password').html();
  WPopup::html(html,160);
  false;
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