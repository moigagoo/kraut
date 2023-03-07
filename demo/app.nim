import karax/[karax, karaxdsl, vdom]

import kraut

import pages/[notfound, index, users, user]


const
  indexRoute = @{"/": index.render}
  userRoutes = @{"/users/": users.render, "/users/{userId}/": user.render}
  routes = indexRoute & userRoutes

let renderer = routeRenderer(routes, defaultRenderer = notfound.render)


proc render(routerData: RouterData): VNode =
  buildHtml(tdiv):
    h1: text "Header"

    renderer(routerData)


setRenderer(render)
# or just setRenderer(renderer)
# or even setRenderer(routeRenderer(routes))

