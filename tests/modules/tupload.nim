import unittest, times, strutils, sequtils, ospaths, httpClient, ../../src/modules/upload, ../../src/modules/filetypes

suite "modules/upload":
  let token = ospaths.get_env "AS_TOKEN"
  let time = format(now(), "yyyyMMdd,HHmmss").split(",").join("_")
  let client = newHttpClient()
  let types = client.filetypes token
  teardown:
    client.close
  for path in types:
    test path & ": is failed":
      check(client.upload(token, path, "", time) == false)
    test path & ": is successful":
      let file = open "./tests/data/" & path & ".json"
      let entity = file.readAll()
      check(client.upload(token, path, entity, time) == true)

