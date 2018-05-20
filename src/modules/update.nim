from parseoptions import asuOptions
import times, strutils, sequtils, filetypes, login, info, upload

proc update*(options: asuOptions): bool =
  let time = format(now(), "yyyyMMdd,HHmmss").split(",").join("_")

  # タイプ一覧を取得
  let types = filetypes(options.token)
  if (types.len == 0):
    echo "Admiral Statusにアクセスできませんでした。"
    echo "APIトークンが正しい事を確認してください。"
    return false

  # 提督情報にログイン
  let cookie = login(options.id, options.pass)
  if (cookie == ""):
    echo "提督情報にログイン出来ませんでした。"
    echo "SEGA IDやPasswordが正しい事を確認してください。"
    return false

  # 提督情報をダウンロードし、Admiral Statsにアップロード
  for path in types:
    echo path & "の更新..."
    var json = info(path.split("_").join("/"), cookie)
    if (json == ""):
      echo "提督情報のJSONのダウンロードに失敗しました。"
      continue
    var pathResult = upload(options.token, path, json, time)
    if (pathResult == false):
      echo "Admiral Statsのアップロードに失敗しました。"
      continue
  return true

