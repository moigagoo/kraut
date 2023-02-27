# Kraut

**Kraut** is a router for [Karax](https://github.com/karaxnim/karax) frontend framework.


## Installation

Install Kraut with nimble:

```
$ nimble install kraut
```

Add it to your .nimble file:

```
require "kraut >= 1.0.0"
```

Kraut doesn't have any dependencies outside stdlib except for Karax (duh).


## Usage

First, define your routes as an array or sequence of pattern-renderer pairs.

**Pattern** is a string that Kraut uses to match against the hash part of the URI.

**Renderer** is proc that takes a single argument of type `Context` and returns a `VNode`.

**Context** is an object that holds the URL params extracted from the hash part in its `urlParams` field.

Nim offers nice syntax to define Kraut routes:

```
const routes = {
  "/": index.render,
  "/users/": users.render,
  "/users/{userId}/": user.render
}
```

In this example, `"/users/{userId}"` is a pattern and `user.render` us a renderer.

Next, define your renderers:

```
# user.nim

proc render*(context: Context): VNode =
  buildHtml(tdiv):
    text "User id: " & context.urlParams["userId"]
```

Finally, generate the route renderer proc. It's a proc that accepts a single `RouterData` argument and returns a `VNode`. It can be passed directly to Karax's `setRenderer` proc or used inside another proc:

```
setRenderer(routerRenderer(routes))
```

or

```
let renderer = routerRenderer(routes)

proc render(routerData: RouterData): VNode = 
  buildHtmil(tdiv):
    h1: text "Header"

    renderer(routerData)

setRenderer(render)
```

See the complete example in the `demo` folder.


# Why you should use Kraut

1. Route definition is dead simple.
2. Renderer proc doesn't have to be anything special, it's just a regular proc you would use in Karax without Kraut, sans the `Context` argument.
3. Kraut is efficient. Now heavy regexes or hash maps, just iteration and string comparison that stops with the first match.

