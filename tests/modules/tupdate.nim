import unittest, ospaths, ../../src/modules/update, ../../src/modules/parseoptions
let id = ospaths.get_env "AS_ID"
let pass = ospaths.get_env "AS_PASS"
let token = ospaths.get_env "AS_TOKEN"

suite "modules/update":
  test "is successful":
    var options = parseoptions("-i:" & id & " -p:" & pass & " -t:" & token)
    check(update(options) == true)

