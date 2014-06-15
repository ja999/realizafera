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


  class Graphic.Interface extends Marionette.Controller

    getGraphic: (date) ->
      graphic = new Graphic.Model { date }
      graphic.fetch()
      graphic

    getGraphics: ->
      start_date = moment().startOf('isoWeek')
      graphics = _.map _.range(0, 6 + 1), (index) ->
        graphic = new Graphic.Model
          date: start_date.clone().add(index, 'days')
        graphic.fetch()
        graphic
        window.graphic = graphic
      new Graphic.Collection graphics


  Graphic.on 'start', ->
    controller = new Graphic.Interface

    App.reqres.setHandler 'get:graphic:entity', (date) ->
      controller.getGraphic()

    App.reqres.setHandler 'get:graphic:entities', ->
      controller.getGraphics()


