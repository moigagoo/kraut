import std/tables


export tables


type
  Context* = ref object of RootObj
    urlParams*: TableRef[string, string]
    qryParams*: TableRef[string, string]


proc newContext*: Context =
  Context(
    urlParams: newTable[string, string](),
    qryParams: newTable[string, string]()
  )

