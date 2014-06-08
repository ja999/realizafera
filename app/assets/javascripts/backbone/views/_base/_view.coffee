@Realizafera.module "Views", (Views, App, Backbone, Marionette, $, _) ->

  _.extend Marionette.View::,

    setInstancePropertiesFor: (args...) ->
      for key, val of _.pick(@options, args...)
        @[key] = val

    templateHelpers: ->

      linkTo: (name, url, options = {}) ->
        $("<a>").attr("href", url)
          .addClass(options.className)
          .text(name)[0].outerHTML
