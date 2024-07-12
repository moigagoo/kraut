import karax/[karaxdsl, vdom]

import kraut


proc render*(context: Context): VNode =
  buildHtml(tdiv):
    p:
      text "User id: " & context.urlParams["userId"]
    ul:
      li: a(href = "#/"): text "Index"
      li: a(href = "#/users/"): text "Users"

