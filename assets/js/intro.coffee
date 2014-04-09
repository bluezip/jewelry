$ =jQuery;

'use strict';

app = angular.module 'IntroApp', ['ngRoute','ui.router'], ()->

app.config(['$stateProvider', '$locationProvider',() ->

]);

app.controller 'Slide',($scope,$http) ->
  $http.get("json/images-intro.json").success((data)->
    $scope.images  = data
  );


app.controller 'Logo',($scope) ->


app.controller 'Language',($scope,$rootScope, $http) ->


  $http.get("json/language.json").success((data)->
    $scope.list_select  = data;
    _default = _.where($scope.list_select, {default : true});
    $scope.default_data = _default[0];

    #Setup language
    $rootScope.language = $scope.default_data.code;
    $rootScope.$emit('change_data');
  );

  $scope.isActive = (code) ->
    code == $scope.default_data.code;

  $scope.change = (data) ->
    $scope.default_data = data
    $rootScope.language = $scope.default_data.code;
    $rootScope.$emit('change_data');


app.controller 'Currency',($scope,$rootScope,$http) ->

  $http.get("json/currency.json").success((data)->
    $scope.list_select  = data;

    _default = _.where($scope.list_select, {default : true});
    $scope.default_data = _default[0];

    # Setup currency
    $rootScope.currency = $scope.default_data.code;
    $rootScope.$emit('change_data');
  );

  $scope.isActive = (code) ->
    code == $scope.default_data.code;

  $scope.change = (data) ->
    $scope.default_data = data
    $rootScope.currency = $scope.default_data.code;
    $rootScope.$emit('change_data');


app.controller 'FormSubmit',($scope,$rootScope)->
  $rootScope.$on('change_data',->
    $scope.currency = $rootScope.currency;
    $scope.language = $rootScope.language;
  );


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