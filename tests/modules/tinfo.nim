import unittest, ospaths, ../../src/modules/info, ../../src/modules/login
let id = ospaths.get_env "AS_ID"
let pass = ospaths.get_env "AS_PASS"

suite "modules/info":
  let cookie = login(id, pass)
  test "successful":
    var result = info("Personal/basicInfo", cookie)
    echo result
    check(result != "")

