@Realizafera.module 'GraphicApp', (GraphicApp, App, Backbone, Marionette, $, _) ->

  class GraphicApp.Router extends Marionette.AppRouter
    appRoutes:
      'week'      : 'list'


  API =
    list: ->
      new GraphicApp.List.Controller


  App.addInitializer ->
    new GraphicApp.Router
      controller: API
