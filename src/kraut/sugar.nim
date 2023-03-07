import std/[macros, sequtils]


macro routes*(body: untyped): untyped =
  ##[ Generate routes table from a list of patterns and module names.

  The referenced modules must satisfy two conditions:
  - be in `pages` directory
  - export `render(context: Context): VNode` proc
  
  The table is stored in an exported `routes` constant that can be passed to `routeRenderer` proc.
  ]##
  
  var
    patternDefs: seq[NimNode]
    moduleNames: seq[NimNode]

  for routeDef in body:
    routeDef.expectKind(nnkCall)

    routeDef[0].expectKind(nnkStrLit)
    routeDef[1][0].expectKind(nnkIdent)

    patternDefs.add routeDef[0]
    moduleNames.add routeDef[1][0]

  var
    moduleBracket = newNimNode(nnkBracket)
    routeTable = newNimNode(nnkTableConstr)
    
  for moduleName in moduleNames:
    moduleBracket.add moduleName

  for (patternDef, moduleName) in zip(patternDefs, moduleNames):
    routeTable.add(
      newColonExpr(
        patternDef,
        newDotExpr(
          moduleName,
          ident "render"
        )
      )
    )


  let
    importStmt = newNimNode(nnkImportStmt).add(
      infix(
        ident "pages",
        "/", 
        moduleBracket
      )
    )
    constSection = newNimNode(nnkConstSection).add(
      newNimNode(nnkConstDef).add(
        postfix(
          ident "routes",
          "*"
        ),
        newEmptyNode(),
        routeTable
      ) 
    )

  result = newStmtList(
    importStmt,
    constSection
  )

