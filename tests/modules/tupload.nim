import unittest, times, strutils, sequtils, ospaths, ../../src/modules/upload, ../../src/modules/filetypes

suite "modules/upload":
  let token = ospaths.get_env "AS_TOKEN"
  let time = format(now(), "yyyyMMdd,HHmmss").split(",").join("_")
  let types = filetypes(token)
  for path in types:
    test path & ": is failed":
      check(upload(token, path, "", time) == false)
    test path & ": is successful":
      let file = open "./tests/data/" & path & ".json"
      let entity = file.readAll()
      check(upload(token, path, entity, time) == true)

