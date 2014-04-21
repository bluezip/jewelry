#Return Url only

'use strict';

app = angular.module 'LinkApp', [], ()->

# List all currency
app.factory('ListCurrencyUrl',->
  'json/list-currency.json'
)

# List all language
app.factory('ListLanguageUrl',->
  'json/list-language.json'
)

# Image Intro
app.factory('ImageIntroUrl',->
  'json/images-intro.json'
)