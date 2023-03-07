import karax/[karax, karaxdsl, vdom]

import kraut

import pages/notfound
import routes



let renderer = routeRenderer(routes.routes, defaultRenderer = notfound.render)


proc render(routerData: RouterData): VNode =
  buildHtml(tdiv):
    h1: text "Header"

    renderer(routerData)


setRenderer(render)
# or just setRenderer(renderer)
# or even setRenderer(routeRenderer(outes))

