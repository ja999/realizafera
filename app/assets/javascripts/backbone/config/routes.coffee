do ->
  # TODO: add custom routes-functions here
  routes = {}

  _(routes).chain().keys().each (route) ->
    Routes[route + "_path"] = routes[route]
