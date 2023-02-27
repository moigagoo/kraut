import karax/[karaxdsl, vdom]

import kraut/context


proc render*(context: Context): VNode =
  buildHtml(tdiv):
    text "This is index"

