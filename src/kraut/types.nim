import std/tables

import karax/vdom


export tables


type
  Renderer* = proc(context: Context): VNode {.nimcall.}
  Route* = tuple[pattern: string, renderer: Renderer]
  Context* = object of RootObj
    urlParams*: TableRef[string, string]
    qryParams*: TableRef[string, string]

