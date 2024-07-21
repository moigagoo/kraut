import std/tables

import karax/vdom


export tables


type
  Renderer* = proc(context: Context): VNode {.nimcall.}
  Route* = tuple[pattern: string, renderer: Renderer]
  Context* = object of RootObj
    urlParams*: Table[string, string]
    qryParams*: Table[string, string]

