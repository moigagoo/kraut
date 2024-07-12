import karax/[karaxdsl, vdom]

import kraut


proc render*(context: Context): VNode =
  buildHtml(tdiv):
    h1: text "Not found"

