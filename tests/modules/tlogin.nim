import unittest, ospaths, httpclient, ../../src/modules/login

suite "modules/login":
  let id = ospaths.get_env "AS_ID"
  let pass = ospaths.get_env "AS_PASS"
  let client = newHttpClient()
  let login_cookie = client.login(id, pass)
  teardown:
    client.close
  test "is successful":
    check(login_cookie != "")

