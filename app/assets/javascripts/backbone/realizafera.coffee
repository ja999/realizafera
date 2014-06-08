#= require_tree ./config
#= require_self
#= require_tree ./controllers
#= require_tree ./entities
#= require_tree ./views
#= require_tree ./components
#= require_tree ./apps

@Realizafera = do (Backbone, Marionette) ->

  App = new Marionette.Application

  App.on "initialize:before", (options = {}) ->
    App.environment = options.environment
    App.currentUser = options.currentUser

  # TODO: add regions e.g. header, footer
  App.addRegions
    mainRegion:     "#js-main-region"
    # headerRegion:   "#js-header-region"

  App.rootRoute = "" # TODO: set route

  App.reqres.setHandler "default:region", ->
    App.mainRegion

  App.addInitializer ->
    App.module("Entities").start()
    # App.module("HeaderApp").start()

  App.commands.setHandler "register:instance", (instance, id) ->
    App.register instance, id if App.environment is "development"

  App.commands.setHandler "unregister:instance", (instance, id) ->
    App.unregister instance, id if App.environment is "development"

  App.on "initialize:after", (options) ->
    @startHistory()
    @navigate(@rootRoute, trigger: true) unless @getCurrentRoute()

  App
