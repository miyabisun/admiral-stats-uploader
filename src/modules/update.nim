from parseoptions import asuOptions
import times, strutils, sequtils, filetypes, login, info, upload

proc update*(client: HttpClient, options: asuOptions): bool =
  let time = format(now(), "yyyyMMdd,HHmmss").split(",").join("_")

  # タイプ一覧を取得
  let types = client.filetypes(options.token, options.verbose)
  if (types.len == 0):
    echo "Admiral Statusにアクセスできませんでした。"
    echo "APIトークンが正しい事を確認してください。"
    return false

  # 提督情報にログイン
  let cookie = client.login(options.id, options.pass, options.verbose)
  if (cookie == ""):
    echo "提督情報にログイン出来ませんでした。"
    echo "SEGA IDやPasswordが正しい事を確認してください。"
    return false

  # 提督情報をダウンロードし、Admiral Statsにアップロード
  for path in types:
    echo path & "の更新..."
    var json = client.info(path.split("_").join("/"), cookie, options.verbose)
    if (json == ""):
      echo "提督情報のJSONのダウンロードに失敗しました。"
      continue
    var pathResult = client.upload(options.token, path, json, time, options.verbose)
    if (pathResult == false):
      echo "Admiral Statsのアップロードに失敗しました。"
      continue
  return true

