@Realizafera.module 'GraphicApp.Form', (Form, App, Backbone, Marionette, $, _) ->

  class Form.Controller extends App.Controllers.Base
    modelName: 'production'

    initialize: (options = {}) ->
      { model, date } = options

      view = @getFormView(model)
      formView = App.request 'form:wrapper', view

      for action in ['updated', 'created']
        @listenTo model, action, =>
          App.vent.trigger "#{@modelName}:#{action}", model, @region

      @listenTo formView, 'form:cancel', =>
        prefix = if model.isNew() then "new:" else ""
        App.vent.trigger "#{prefix}#{@modelName}:cancelled", model, @region

      @listenTo view, 'form:submit', (data) ->
        data.start_day = date.day()
        data.end_day = data.start_day

      @show formView

    getFormView: (model) ->
      new Form.View { model }
