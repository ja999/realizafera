@Realizafera.module 'GraphicApp', (GraphicApp, App, Backbone, Marionette, $, _) ->

  class GraphicApp.Router extends Marionette.AppRouter
    appRoutes:
      'week'      : 'list'


  API =
    list: ->
      new GraphicApp.List.Controller


    _base: (date, region, model) ->
      new GraphicApp.Base.Controller { date, region, model }

    form: (date, model, region) ->
      new GraphicApp.Form.Controller { date, model, region }


  App.addInitializer ->
    new GraphicApp.Router
      controller: API

    App.vent.on 'daily:graphic', (date, region, model) ->
      API.show(date, region, model)

    App.vent.on '_base:graphic', (date, region, model) ->
      API._base(date, region, model)

    App.vent.on 'form:production', (date, model, region) ->
      API.form(date, model, region)
