import unittest, ospaths, ../../src/modules/login
let id = ospaths.get_env "AS_ID"
let pass = ospaths.get_env "AS_PASS"

suite "modules/login":
  test "is successful":
    echo login(id, pass)
