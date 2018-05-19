import unittest, ospaths, asyncfile, asyncdispatch, os, ../../src/modules/update, ../../src/modules/filetypes
let token = ospaths.get_env "AS_TOKEN"
const filetype = "Personal_basicInfo"

proc main() {.async.} =
  let file = openAsync "./tests/data/" & filetype & ".json"
  let entity = await file.readAll()
  check(update(token, filetype, entity) == true)

suite "modules/update":
  test "is failed":
    check(update(token, filetype, "test") == false)
  test "is successful":
    waitFor main()

