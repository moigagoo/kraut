import karax/[karaxdsl, vdom]

import kraut/context


proc render*(context: Context): VNode =
  buildHtml(tdiv):
    p:
      text "This is index"
    ul:
      li: a(href = "#/users/"): text "Users"

