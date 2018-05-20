import unittest, ospaths, strutils, sequtils, ../../src/modules/info, ../../src/modules/login, ../../src/modules/filetypes
let id = ospaths.get_env "AS_ID"
let pass = ospaths.get_env "AS_PASS"
let token = ospaths.get_env "AS_TOKEN"

suite "modules/info":
  let cookie = login(id, pass)
  let types = filetypes(token)
  # @["Personal_basicInfo", "TcBook_info", "CharacterList_info", "Event_info", "BlueprintList_info", "EquipBook_info", "EquipList_info"]
  for path in types:
    test path & ": successful":
      var result = info(path.split("_").join("/"), cookie)
      check(result != "")

