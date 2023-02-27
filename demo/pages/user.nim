import karax/[karaxdsl, vdom]

import kraut/types


proc render*(context: Context): VNode =
  buildHtml(tdiv):
    tdiv:
      text "User"
    tdiv:
      text context.urlParams["userId"]

