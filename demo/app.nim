import karax/[karax, karaxdsl, vdom]

import kraut

import pages/[index, users, user]


const routes = {
  "/": index.render,
  "/users/": users.render,
  "/users/{userId}/": user.render
}

let renderer = routeRenderer(routes)


proc render(routerData: RouterData): VNode =
  buildHtml(tdiv):
    h1: text "Header"

    renderer(routerData)


setRenderer(render)
# or just setRenderer(renderer)
# or even setRenderer(routeRenderer(routes))

