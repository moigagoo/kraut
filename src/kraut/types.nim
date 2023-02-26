import std/tables

import karax/[kbase, vdom]


export tables


type
  Context* = ref object of RootObj
    urlParams*: TableRef[kstring, kstring]
    qryParams*: TableRef[kstring, kstring]
  Renderer* = proc(context: Context): VNode {.nimcall.}
  Route* = tuple[pattern: kstring, renderer: Renderer]


proc newContext*: Context =
  Context(urlParams: newTable[kstring, kstring](), qryParams: newTable[kstring, kstring]())

