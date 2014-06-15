@Realizafera.module 'Views.Shared', (Shared, App, Backbone, Marionette, $, _) ->

  class Shared.WrapperView extends App.Views.Layout
    template: 'shared/wrapper'

    regions:
      wrappedRegion: '.js-wrapped-region'

