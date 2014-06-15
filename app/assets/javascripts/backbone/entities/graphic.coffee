@Realizafera.module "Entities.Graphic", (Graphic, App, Backbone, Marionette, $, _) ->

  class Graphic.Model extends App.Entities.Model
    url: -> Routes.graphic_path(date: @get('date').format('YYYY-MM-DD'))

    relations: [
      type: Backbone.Many
      key: 'productions'
      collectionType: 'Realizafera.Entities.Production.Collection'
    ]

    defaults:
      date: -> moment()
      productions: []

    parse: (object = {}) ->
      object.date = moment(object.date)
      super


  class Graphic.Collection extends App.Entities.Collection
    model: Graphic.Model
