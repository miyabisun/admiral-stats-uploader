import unittest, ../../src/modules/parseoptions

suite "modules/parseoptions":
  # default
  let default = parseoptions ""
  test "default: set option: id":
    check(default.id == "")
  test "default: set option: pass":
    check(default.pass == "")
  test "default: set option: token":
    check(default.token == "")
  test "default: set option: autoupdate":
    check(default.autoupdate == false)
  test "default: set option: help":
    check(default.help == false)

  # long
  let long_opt = parseoptions "--id:foo --pass:password --token:123456abcdef --autoupdate --help"
  test "long: set option: id":
    check(long_opt.id == "foo")
  test "long: set option: pass":
    check(long_opt.pass == "password")
  test "long: set option: token":
    check(long_opt.token == "123456abcdef")
  test "long: set option: autoupdate":
    check(long_opt.autoupdate == true)
  test "long: set option: help":
    check(long_opt.help == true)

  # short
  let short_opt = parseoptions "-i:foo -p:password -t:123456abcdef -a -h"
  test "short: set option: id":
    check(short_opt.id == "foo")
  test "short: set option: pass":
    check(short_opt.pass == "password")
  test "short: set option: token":
    check(short_opt.token == "123456abcdef")
  test "short: set option: autoupdate":
    check(short_opt.autoupdate == true)
  test "short: set option: help":
    check(short_opt.help == true)

