import std/strformat
import karax/[karaxdsl, kbase, vdom]

import kraut


proc render*(context: Context): VNode =
  buildHtml(tdiv):
    p:
      text "This is users page"
    ul:
      for key, val in context.qryParams:
        li: text key & " = " & val
    ul:
      for userId in ["123", "456", "789"]:
        li: a(href = kstring fmt"#/users/{userId}/"): text fmt"User {userId}"

