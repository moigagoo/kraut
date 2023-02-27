import karax/[karaxdsl, vdom]

import kraut/context


proc render*(context: Context): VNode =
  buildHtml(tdiv):
    text "User id: " & context.urlParams["userId"]

