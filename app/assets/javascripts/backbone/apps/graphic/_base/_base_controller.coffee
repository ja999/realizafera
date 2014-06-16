@Realizafera.module 'GraphicApp.Base', (Base, App, Backbone, Marionette, $, _) ->

  class Base.Controller extends App.Controllers.Base

    initialize: (options = {}) ->
      { model, @date } = options
      model ||= App.request 'get:graphic:entity', @date

      @layout = @getLayout(model)


      @listenTo @layout, 'show', =>
        @productionsRegion(model)

      @show @layout,
        loading: true


    productionsRegion: (model) ->
      collection = model.get('productions')
      view = @getProductionsView(collection)

      # show for wrapper
      @listenTo view, 'childview:show', (wrapperView) =>
        { model, wrappedRegion } = wrapperView
        return unless model.isEntity
        if model.isNew()
          @showForm(model, wrappedRegion)
        else
          @showModel(model, wrappedRegion)

      # remove
      @listenTo view, 'childview:remove:button:clicked', (wrapperView) =>
        { model } = wrapperView
        if confirm "Are you sure you want to delete this?"
          model.destroy
            error: -> alert("You can't remove that!")

      # add
      @listenTo view, 'add:production:clicked', =>
        collection.add({})

      # edit
      @listenTo view, 'childview:edit:button:clicked', (wrapperView) =>
        { model, wrappedRegion } = wrapperView
        @showForm(model, wrappedRegion)

      # close form
      @listenTo App.vent, 'production:cancelled production:updated production:created', (model, region) =>
        @showModel(model, region)

      # close new form
      @listenTo App.vent, 'new:production:cancelled', (model) =>
        model.destroy()

      @layout.productionsRegion.show(view)


    showModel: (model, region) ->
      if region?
        view = @getProductionView(model)
        region.show view

    showForm: (model, region) ->
      App.vent.trigger 'form:production', @date, model, region


    getLayout: (model) ->
      new Base.Layout { model }

    getProductionsView: (collection) ->
      new Base.ProductionsView { collection }

    getProductionView: (model) ->
      new Base.ProductionView { model }
