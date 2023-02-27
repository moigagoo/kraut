import std/strutils


proc components*(path: string): seq[string] =
  ## Split a path to components.

  var cleanPath = path

  if cleanPath.startsWith('#'): cleanPath.removePrefix('#')
  if not cleanPath.startsWith('/'): cleanPath.insert("/", 0)
  if not cleanPath.endsWith('/'): cleanPath.add("/")

  cleanPath.split('/')

proc isPlaceholder*(component: string): bool =
  ## Check if the given component is a placeholder.
  
  component.startsWith('{') and component.endsWith('}')

proc placeholderName*(placeholder: string): string =
  ## Extract placeholder name from a placeholder.
  
  placeholder[1..^2]

