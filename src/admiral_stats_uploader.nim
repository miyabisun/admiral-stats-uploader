import os, times, strutils, tables, httpclient, modules/parseoptions, modules/update, modules/isundermaintenance

const HelpText = """
Admiral Stats Uploader

提督情報からJSONデータを抽出してAdmiral Statsにアップロードします
本家とは違って書き込み機能やコンフィグファイルはありません
'--id=ユーザID' みたいな感じでオプション指定して使ってください

Usage:
  asu [options]

Options:
  --id=[SEGA ID]   , -i=[SEGA ID]   提督情報のSEGA ID
  --pass=[Password], -p=[Password]  提督情報のPassword
  --token=[Token]  , -t=[Token]     Admiral StatsのAPIトークン
  --autoupdate     , -a             30分に一度自動実行
  --verbose                         詳細出力を行います
  --help           , -h             ヘルプを表示します

Example:
  asu -h
  asu -i=aaa -p=bbb -t=ccc
  asu -i=aaa -p=bbb -t=ccc -a
"""

proc main () =
  let options = os.commandLineParams().join(" ").parseoptions
  if (options.help):
    echo HelpText
    return

  # validate
  let checker = @[
    ("id", options.id),
    ("pass", options.pass),
    ("token", options.token),
  ]
  for val in checker:
    if (val[1] == ""):
      echo "エラー: " & val[0] & "は必須です"
      echo "ヘルプ(asu -h)を参考にオプションを設定し直してください"
      return

  # doing
  if (now().isundermaintenance):
    echo "現在メンテナンス中です。"
  else:
    let client = newHttpClient()
    if (not client.update options):
      echo "Admiral Statsのアップデートに失敗しました"
      echo "ヘルプ(asu -h)を参考に、設定内容を見直してください"
      return
    client.close()

  if (options.autoupdate):
    echo "オートアップデートモードに入ります"
    echo "30分毎に自動的に更新を行います"
    while true:
      sleep 30 * 60 * 1000
      let client = newHttpClient()
      echo now().format("yyyy-MM-dd HH:mm:ss") & ": アップデートを開始します"
      if (now().isundermaintenance): echo "メンテナンス中なのでスキップします"
      else: discard client.update options
      client.close()

main()

