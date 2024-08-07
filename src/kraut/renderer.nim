import karax/[karax, karaxdsl, kbase, vdom]

import types, utils


export types


proc match(hashPart: kstring, pattern: string, context: var Context): bool =
  ## Match a hash part against a pattern collecting the URL params in the process.

  result = true

  let
    hashPartComponents = ($hashPart).pathComponents
    patternComponents = pattern.pathComponents

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

proc routeRenderer*(routes: openArray[Route], defaultRenderer: Renderer = nil): proc (routerData: RouterData): VNode =
  ## Generate a dispatcher proc that calls a renderer proc based for the given hash part according to the ``routes`` table.

  let routes = @routes

  var context: Context

  result = proc (routerData: RouterData): VNode =
    ## Try to match the current hash part against available patterns and call the matching renderer.

    var renderer = defaultRenderer

    for route in routes:
      if routerData.hashPart.match(route.pattern, context):
        context.qryParams = ($routerData.queryString).qryParams
        renderer = route.renderer

        break

    buildHtml(tdiv):
      renderer(context)

