import std/[strutils, tables]


proc pathComponents*(path: string): seq[string] =
  ## Split a path to components.

  var cleanPath = path.split('?')[0]

  if cleanPath.startsWith('#'): cleanPath.removePrefix('#')
  if not cleanPath.startsWith('/'): cleanPath.insert("/", 0)
  if not cleanPath.endsWith('/'): cleanPath.add("/")

  cleanPath.split('/')

proc qryParams*(path: string): TableRef[string, string] =
  ## Extract key-value pairs from the query part of a path.

  result = newTable[string, string]()

  if len(path.split('?')) < 2:
    return result

  let qry = path.split('?')[1]

  for component in qry.split('&'):
    let
      key = component.split('=')[0]
      val = component.split('=')[1]

    result[key] = val

proc isPlaceholder*(component: string): bool =
  ## Check if the given component is a placeholder.
  
  component.startsWith('{') and component.endsWith('}')

proc placeholderName*(placeholder: string): string =
  ## Extract placeholder name from a placeholder.
  
  placeholder[1..^2]

