@Realizafera.module 'GraphicApp.Base', (Base, App, Backbone, Marionette, $, _) ->

  class Base.Layout extends App.Views.Layout
    template: 'graphic/_base/layout'
    className: 'graphic-day'

    regions:
      productionsRegion: '.js-region-productions'


  class Base.ProductionView extends App.Views.ItemView
    template: 'graphic/_base/production'


  class Base.ProductionsEmptyView extends App.Views.ItemView
    template: 'graphic/_base/productions_empty'


  class Base.ProductionsView extends App.Views.CompositeView
    template: 'graphic/_base/productions'
    itemView: Base.ProductionView
    itemViewContainer: '.js-container-productions'
    emptyView: Base.ProductionsEmptyView
