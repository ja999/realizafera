@Realizafera.module 'GraphicApp.List', (List, App, Backbone, Marionette, $, _) ->

  class List.GraphicWrapper extends App.Views.Shared.WrapperView
    className: 'graphic-day-wrapper col-lg-1'


  class List.GraphicsView extends App.Views.CollectionView
    className: 'row'
    itemView: List.GraphicWrapper
