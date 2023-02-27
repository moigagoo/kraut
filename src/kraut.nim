import karax/[karax, karaxdsl, kbase, vdom]

import kraut/context
import kraut/private/utils


export context


type
  Renderer = proc(context: Context): VNode {.nimcall.}
  Route = tuple[pattern: string, renderer: Renderer]


proc match(hashPart: kstring, pattern: string, context: var Context): bool =
  ## Match a hash part against a pattern collecting the URL params in the process.

  result = true

  let
    hashPartComponents = ($hashPart).components
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

proc routeRenderer*(routes: openArray[Route]): proc (routerData: RouterData): VNode =
  ## Generate a dispatcher proc that calls a renderer proc based for the given hash part according to the ``routes`` table.

  var context = newContext()

  result = proc (routerData: RouterData): VNode =
    ## Try to match the current hash part against available patterns and call the matching renderer.

    buildHtml(tdiv):
      for (pattern, renderer) in routes:
        if routerData.hashPart.match(pattern, context):
          renderer(context)
          break

