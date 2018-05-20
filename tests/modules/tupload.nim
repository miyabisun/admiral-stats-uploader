import unittest, ospaths, ../../src/modules/upload, ../../src/modules/filetypes
let token = ospaths.get_env "AS_TOKEN"
const filetype = "Personal_basicInfo"

suite "modules/upload":
  test "is failed":
    check(upload(token, filetype, "test") == false)
  test "is successful":
    let file = open "./tests/data/" & filetype & ".json"
    let entity = file.readAll()
    check(upload(token, filetype, entity) == true)

