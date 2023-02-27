import karax/karax

import kraut

import pages/[index, users, user]


const routes = {
  "/": index.render,
  "/users/": users.render,
  "/users/{userId}/": user.render
}


let renderer = routeRenderer(routes)

setRenderer(renderer)

