import unittest, ospaths, json, ../../src/modules/filetypes
let token = ospaths.get_env "AS_TOKEN"

suite "modules/filetypes":
  test "is failed":
    let types = filetypes("")
    check(types.len == 0)
  test "is successful":
    let types = filetypes(token)
    check(types.len > 0)
    check(types[0] == "Personal_basicInfo")

