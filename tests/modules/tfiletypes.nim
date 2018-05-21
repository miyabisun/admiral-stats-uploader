import unittest, ospaths, json, httpClient, ../../src/modules/filetypes

suite "modules/filetypes":
  let token = ospaths.get_env "AS_TOKEN"
  let client = newHttpClient()
  teardown:
    client.close
  test "is failed":
    let types = client.filetypes ""
    check(types.len == 0)
  test "is successful":
    let types = client.filetypes token
    check(types.len > 0)
    check(types[0] == "Personal_basicInfo")

