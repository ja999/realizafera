@Realizafera.module "Entities.Production", (Production, App, Backbone, Marionette, $, _) ->

  class Production.Model extends App.Entities.Model
    urlRoot: -> Routes.productions_path()

    defaults:
      repetitive: true
      cancelled:  false
      confirmed_by_user: false


  class Production.Collection extends App.Entities.Collection
    model: Production.Model
    url: -> Routes.productions_path()
