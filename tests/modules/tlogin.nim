import unittest, ospaths, ../../src/modules/login

suite "modules/login":
  let id = ospaths.get_env "AS_ID"
  let pass = ospaths.get_env "AS_PASS"
  let login_cookie = login(id, pass)
  test "is successful":
    check(login_cookie != "")

