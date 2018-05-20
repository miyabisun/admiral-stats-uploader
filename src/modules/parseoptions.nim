import parseopt2

type
  asuOptions* = tuple
    id: string
    pass: string
    token: string
    autoupdate: bool

proc options*(str: string): asuOptions =
  var options = (id: "", pass: "", token: "", autoupdate: false)
  var p = initOptParser str
  for kind, key, val in p.getopt():
    case kind
    of cmdLongOption:
      case key
      of "id": options.id = val
      of "pass": options.pass = val
      of "token": options.token = val
    of cmdShortOption:
      case key
      of "i": options.id = val
      of "p": options.pass = val
      of "t": options.token = val
    else: continue
  result = options

