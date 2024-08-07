import std/[strutils, uri, tables]


proc pathComponents*(path: string): seq[string] =
  ## Split a path to components.

  var cleanPath = path.split('?')[0]

  if cleanPath.startsWith('#'): cleanPath.removePrefix('#')
  if not cleanPath.startsWith('/'): cleanPath.insert("/", 0)
  if not cleanPath.endsWith('/'): cleanPath.add("/")

  cleanPath.split('/')

proc qryParams*(qryString: string): Table[string, string] =
  ## Extract key-value pairs from the query part of a path.

  result = initTable[string, string]()

  var cleanQryString = qryString

  if cleanQryString.startsWith('?'): cleanQryString.removePrefix('?')

  for key, val in decodeQuery(cleanQryString):
    result[key] = val

proc isPlaceholder*(component: string): bool =
  ## Check if the given component is a placeholder.
  
  component.startsWith('{') and component.endsWith('}')

proc placeholderName*(placeholder: string): string =
  ## Extract placeholder name from a placeholder.
  
  placeholder[1..^2]

