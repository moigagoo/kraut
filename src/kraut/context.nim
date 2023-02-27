import std/tables


export tables


type
  Context* = ref object of RootObj
    urlParams*: TableRef[string, string]


proc newContext*: Context =
  Context(urlParams: newTable[string, string]())

