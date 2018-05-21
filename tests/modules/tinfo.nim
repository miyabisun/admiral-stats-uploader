import unittest, ospaths, strutils, sequtils, httpclient, ../../src/modules/info, ../../src/modules/login, ../../src/modules/filetypes

suite "modules/info":
  let id = ospaths.get_env "AS_ID"
  let pass = ospaths.get_env "AS_PASS"
  let token = ospaths.get_env "AS_TOKEN"
  let cookie = login(id, pass)
  let client = newHttpClient()
  let types = client.filetypes token
  teardown:
    client.close
  for path in types:
    test path & ": successful":
      var result = client.info(path.split("_").join("/"), cookie, true)
      check(result != "")

