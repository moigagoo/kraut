import std/strutils


proc components*(path: string): seq[string] =
  ## Split a path to components.

  runnableExamples:
    doAssert "/users/{userId}/".components == @["users", "{userId}"]
    doAssert "users/{userId}".components == @["users", "{userId}"]
    doAssert "#/users/123/".components == @["users", "123"]
    doAssert "#users/123".components == @["users", "123"]

  var cleanPath = path

  if cleanPath.startsWith('#'): cleanPath.removePrefix('#')
  if not cleanPath.startsWith('/'): cleanPath.insert("/", 0)
  if not cleanPath.endsWith('/'): cleanPath.add("/")

  cleanPath.split('/')

proc isPlaceholder*(component: string): bool =
  ## Check if the given component is a placeholder.
  
  runnableExamples:
    doAssert "{userId}".isPlaceholder
    doAssert not "users".isPlaceholder

  component.startsWith('{') and component.endsWith('}')

proc placeholderName*(placeholder: string): string =
  ## Extract placeholder name from a placeholder.
  
  runnableExamples:
    doAssert placeholderName("{userId}") == "userId"

  placeholder[1..^2]

