@Realizafera.module 'GraphicApp.Base', (Base, App, Backbone, Marionette, $, _) ->

  class Base.Controller extends App.Controllers.Base

    initialize: (options = {}) ->
      { model, date } = options
      model ||= App.request 'get:graphic:entity', date

      @layout = @getLayout(model)

      @listenTo @layout, 'show', =>
        @productionsRegion(model)

      @show @layout,
        loading: true


    productionsRegion: (model) ->
      collection = model.get('productions')
      view = @getProductionsView(collection)
      @layout.productionsRegion.show(view)


    getLayout: (model) ->
      new Base.Layout { model }

    getProductionsView: (collection) ->
      new Base.ProductionsView { collection }
