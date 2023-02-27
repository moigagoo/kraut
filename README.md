# Kraut

**Kraut** is a router for [Karax](https://github.com/karaxnim/karax) frontend framework.


## Installation

Install Kraut with nimble:

```
$ nimble install kraut
```

Add it to your .nimble file:

```nim
require "kraut >= 1.0.0"
```

Kraut doesn't have any dependencies outside stdlib except for Karax (duh).


## Usage

First, define your routes as an array or sequence of pattern-renderer pairs.

**Pattern** is a string that Kraut uses to match against the hash part of the URI.

**Renderer** is proc that takes a single argument of type `Context` and returns a `VNode`.

**Context** is an object that holds the URL params extracted from the hash part in its `urlParams` field.

Nim offers nice syntax to define Kraut routes:

```nim
# app.nim

const routes = {
  "/": index.render,
  "/users/": users.render,
  "/users/{userId}/": user.render
}
```

In this example, `"/users/{userId}"` is a pattern and `user.render` us a renderer.

You can split your routes into groups for maintainability and even store the groups in different modules:

```nim
const
  indexRoute = @{"/": index.render}
  userRoutes = @{"/users/": users.render, "/users/{userId}/": user.render}
  routes = indexRoute & userRoutes
```

Next, define your renderers:

```nim
# user.nim
import kraut/context

proc render*(context: Context): VNode =
  buildHtml(tdiv):
    text "User id: " & context.urlParams["userId"]
```

Finally, generate the route renderer proc. It's a proc that accepts a single `RouterData` argument and returns a `VNode`. It can be passed directly to Karax's `setRenderer` proc or used inside another proc:

```nim
# app.nim
import kraut

let renderer = routerRenderer(routes)

proc render(routerData: RouterData): VNode = 
  buildHtmil(tdiv):
    h1: text "Header"

    renderer(routerData)

setRenderer(render)
```

See the complete example in the `demo` folder.


# Why you should use Kraut

1. Route definition is dead simple. You can split your definitions and can store them in a separate modules.
2. Renderer proc doesn't have to be anything special, it's just a regular proc you would use in Karax without Kraut, sans the `Context` argument.
3. Kraut is efficient. Now heavy regexes or hash maps, just iteration and string comparison that stops with the first match.

