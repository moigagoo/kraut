import karax/[karaxdsl, vdom]

import kraut/context


proc render*(context: Context): VNode =
  buildHtml(tdiv):
    tdiv:
      text "User"
    tdiv:
      text context.urlParams["userId"]

