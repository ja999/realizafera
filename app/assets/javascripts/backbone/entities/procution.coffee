@Realizafera.module "Entities.Production", (Production, App, Backbone, Marionette, $, _) ->

  class Production.Model extends App.Entities.Model
    urlRoot: -> Routes.productions_path()

    defaults:
      repetitive: true
      cancelled:  false
      confirmed_by_user: false

    _time: (hour, minute) -> moment { hour, minute }
    startTime: -> @_time(@get('start_hour'), @get('start_minute'))
    endTime: ->   @_time(@get('end_hour'),   @get('end_minute'))


  class Production.Collection extends App.Entities.Collection
    model: Production.Model
    url: -> Routes.productions_path()
