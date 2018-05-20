import unittest, ../../src/modules/parseoptions

suite "modules/parseoptions":
  let long_opt = options "--id:foo --pass:password --token:123456abcdef"
  let short_opt = options "-i:foo -p:password -t:123456abcdef"
  test "long: set option: id":
    check(long_opt.id == "foo")
  test "long: set option: pass":
    check(long_opt.pass == "password")
  test "long: set option: token":
    check(long_opt.token == "123456abcdef")
  test "long: set option: autoupdate":
    check(long_opt.autoupdate == false)
  test "short: set option: id":
    check(short_opt.id == "foo")
  test "short: set option: pass":
    check(short_opt.pass == "password")
  test "short: set option: token":
    check(short_opt.token == "123456abcdef")
  test "short: set option: autoupdate":
    check(short_opt.autoupdate == false)

