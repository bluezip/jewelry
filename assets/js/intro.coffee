$ =jQuery;

'use strict';

app = angular.module 'IntroApp', ['ngRoute','ui.router','LinkApp'], ()->

app.config(['$stateProvider', '$locationProvider',() ->

]);

# The factory for other App.
# LinkCurrency form LinkApp
app.factory('$$Currency',(ListCurrencyUrl, $http)->
  $http.get(ListCurrencyUrl);
);

# The factory for other App.
# LinkLanguage form LinkApp
app.factory('$$Language',(ListLanguageUrl,$http) ->
  $http.get(ListLanguageUrl);
);







# Image Slide
app.controller 'Slide',($scope,$http,ImageIntroUrl) ->
  $http.get(ImageIntroUrl).success((data)->
    $scope.images  = data
  );





app.controller 'Language',($scope,$rootScope,$$Language) ->

  $$Language.success((data)->
    $scope.lists  = data;
    _default      = _.where($scope.lists, {default : true});
    $scope.default_data = _default[0]; # Default data

    #Setup language default
    $rootScope.language = $scope.default_data.code;
    $rootScope.$emit('change_submit_data');
  );

  $scope.isActive = (code) ->
    code == $scope.default_data.code;

  $scope.change = (data) ->
    $scope.default_data = data
    $rootScope.language = $scope.default_data.code;
    $rootScope.$emit('change_submit_data');







app.controller 'Currency',($scope,$rootScope,$$Currency) ->

  $$Currency.success((data)->
    $scope.lists  = data
    _default = _.where($scope.lists, {default : true});
    $scope.default_data = _default[0]; # Default data

    # Setup currency default
    $rootScope.currency = $scope.default_data.code;
    $rootScope.$emit('change_submit_data');
  );

  $scope.isActive = (code) ->
    code == $scope.default_data.code;

  $scope.change = (data) ->
    $scope.default_data = data
    $rootScope.currency = $scope.default_data.code;
    $rootScope.$emit('change_submit_data');





# Form Submit to next
app.controller 'FormSubmit',($scope,$rootScope)->
  $rootScope.$on('change_submit_data',->
    $scope.currency = $rootScope.currency;
    $scope.language = $rootScope.language;
  );




# TODO: has bug when resize window
app.directive 'resizable', ($window) ->
  _delay = 0
  ($scope,$element,$attrs) ->
    $scope.initializeWindowSize = ->

      $scope.windowHeight = $window.innerHeight
      $scope.windowWidth  = $window.innerWidth

      if (_delay > 0)
        _img    = $($element).find('img')
        Img     = new Image();
        Img.src = _img.attr('src')

        _window = {
          width : $window.innerWidth
          height : $window.innerHeight
          ration : $window.innerWidth / $window.innerHeight
        }
        _images = {
          width   : Img.width
          height  : Img.height
          ration  : Img.width / Img.height
        }
        if _window.ration > _images.ration && Img.width > 0
          $("."+$attrs.class).find('img').css
            width : "#{_window.width}px"
            height : "#{_window.height}px"
            minWidth : "#{_window.width}px"

        else if _window.ration < _images.ration && Img.width > 0
          $("."+$attrs.class).find('img').css
            width : "#{_window.width}px"
            height : "#{_window.height}px"
            minHeight : "#{_window.height}px"

    $scope.initializeWindowSize();
    _delay++;

    angular.element($window).bind 'resize', ->
      $scope.initializeWindowSize()
      $scope.$apply()