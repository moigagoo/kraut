import karax/[karax, kbase, ]

import kraut

import pages/[index, users, user]


const routes = {
  kstring("/"): index.render,
  kstring("/users/"): users.render,
  kstring("/users/{userId}"): user.render
}


let renderer = routeRenderer(routes)

setRenderer(renderer)

