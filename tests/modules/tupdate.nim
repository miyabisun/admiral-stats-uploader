import unittest, ospaths, httpclient, ../../src/modules/update, ../../src/modules/parseoptions

suite "modules/update":
  let id = ospaths.get_env "AS_ID"
  let pass = ospaths.get_env "AS_PASS"
  let token = ospaths.get_env "AS_TOKEN"
  let client = newHttpClient()
  teardown:
    client.close
  test "is successful":
    var options = parseoptions("-i:" & id & " -p:" & pass & " -t:" & token)
    check(client.update(options) == true)

