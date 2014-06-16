@Realizafera.module 'GraphicApp', (GraphicApp, App, Backbone, Marionette, $, _) ->

  class GraphicApp.Router extends Marionette.AppRouter
    appRoutes:
      'week'      : 'list'


  API =
    list: ->
      new GraphicApp.List.Controller


    _base: (date, region, model) ->
      new GraphicApp.Base.Controller { date, region, model }


  App.addInitializer ->
    new GraphicApp.Router
      controller: API

    App.vent.on '_base:graphic', (date, region, model) ->
      API._base(date, region, model)
