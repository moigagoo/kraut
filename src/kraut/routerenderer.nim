import std/[strutils, sequtils, tables]

import karax/[karax, karaxdsl, kbase, vdom]

import types


proc components(path: kstring): seq[kstring] =
  ## Split a path to components.

  runnableExamples:
    doAssert kstring("/users/{userId}/").components == @[kstring("users"), kstring("{userId}")]
    doAssert kstring("users/{userId}").components == @[kstring("users"), kstring("{userId}")]
    doAssert kstring("#/users/123/").components == @[kstring("users"), kstring("123")]
    doAssert kstring("#users/123").components == @[kstring("users"), kstring("123")]

  var cleanPath = $path

  if cleanPath.startsWith('#'): cleanPath.removePrefix('#')
  if not cleanPath.startsWith('/'): cleanPath.insert("/", 0)
  if not cleanPath.endsWith('/'): cleanPath.add("/")

  cleanPath.split('/').mapIt(kstring(it))

proc isPlaceholder(component: kstring): bool =
  ## Check if the given component is a placeholder.
  
  runnableExamples:
    doAssert kstring("{userId}").isPlaceholder
    doAssert not kstring("users").isPlaceholder

  ($component).startsWith('{') and ($component).endsWith('}')

proc placeholderName(placeholder: kstring): kstring =
  ## Extract placeholder name from a placeholder.
  
  runnableExamples:
    doAssert placeholderName(kstring("{userId}")) == kstring("userId")

  kstring(($placeholder)[1..^2])

proc match(hashPart, pattern: kstring, context: var Context): bool =
  ## Match a hash part against a pattern collecting the URL params in the process.

  result = true

  let
    hashPartComponents = hashPart.components
    patternComponents = pattern.components

  if len(hashPartComponents) != len(patternComponents):
    return false

  for i in 0..high(hashPartComponents):
    let
      hashPartComponent = hashPartComponents[i]
      patternComponent = patternComponents[i]

    if hashPartComponent != patternComponent and not patternComponent.isPlaceholder:
      return false

    if patternComponent.isPlaceholder:
      context.urlParams[placeholderName(patternComponent)] = hashPartComponent

proc routeRenderer*(routes: seq[Route]): proc (routerData: RouterData): VNode =
  ## Generate a dispatcher proc that calls a renderer proc based for the given hash part according to the ``routes`` table.

  var context = newContext()

  result = proc (routerData: RouterData): VNode =
    ## Try to match the current hash part against available patterns and call the matching renderer.

    buildHtml(tdiv):
      for (pattern, renderer) in routes:
        if routerData.hashPart.match(pattern, context):
          renderer(context)
          break

