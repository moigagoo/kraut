import karax/[karaxdsl, vdom]

import kraut/types


proc render*(context: Context): VNode =
  buildHtml(tdiv):
    text "User"
    text context.urlParams["userId"]

