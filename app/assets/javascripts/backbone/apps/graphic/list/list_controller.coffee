@Realizafera.module 'GraphicApp.List', (List, App, Backbone, Marionette, $, _) ->

  class List.Controller extends App.Controllers.Base

    initialize: (options = {}) ->
      collection = App.request 'get:graphic:entities'

      graphicsView = @getGraphicsView(collection)

      @listenTo graphicsView, 'childview:show', (wrapperView) =>
        { model, wrappedRegion } = wrapperView
        App.vent.trigger '_base:graphic', model.get('date'), wrappedRegion, model

      @show graphicsView


    getGraphicsView: (collection) ->
      new List.GraphicsView { collection }
