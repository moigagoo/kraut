import karax/[karaxdsl, vdom]

import kraut/types


proc render*(context: Context): VNode =
  buildHtml(tdiv):
    text "This is index"

