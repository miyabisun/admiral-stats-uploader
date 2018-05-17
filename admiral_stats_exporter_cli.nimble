# Package

version       = "0.1.0"
author        = "miyabisun"
description   = "admiral_stats_exporter_cli"
license       = "MIT"
srcDir        = "src"
bin           = @["admiral_stats_exporter_cli"]

# Dependencies

requires "nim >= 0.18.1"

task hello, "this is hello task":
  let hoge = 1 + 2
  echo $hoge
