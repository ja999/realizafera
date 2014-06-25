@Realizafera.module 'GraphicApp.Base', (Base, App, Backbone, Marionette, $, _) ->

  class Base.Layout extends App.Views.Layout
    template: 'graphic/_base/layout'
    className: 'graphic-day'

    regions:
      productionsRegion: '.js-region-productions'


  class Base.ProductionView extends App.Views.ItemView
    template: 'graphic/_base/production'

    timeFormat: (time) -> time.format('HH:mm')

    timeFormatted: ->
      startTime = @timeFormat(@model.startTime())
      endTime   = @timeFormat(@model.endTime())
      [startTime, endTime].join(' - ')

    serializeData: ->
      _.extend super, { timeFormatted: @timeFormatted() }


  class Base.ProductionsEmptyView extends App.Views.ItemView
    template: 'graphic/_base/productions_empty'


  class Base.WrapperView extends App.Views.Shared.WrapperView
    triggers:
      'click .js-remove-production' : 'remove:button:clicked'


  class Base.ProductionsView extends App.Views.CompositeView
    template: 'graphic/_base/productions'
    itemView: Base.WrapperView
    itemViewContainer: '.js-container-productions'
    emptyView: Base.ProductionsEmptyView

    triggers:
      'click .js-add-production' : 'add:production:clicked'
