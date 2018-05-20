import os, strutils, tables, modules/parseoptions, modules/update

const HelpText = """
Admiral Stats Uploader

提督情報からJSONデータを抽出してAdmiral Statsにアップロードします。
本家とは違って書き込み機能やコンフィグファイルはありません。
'--id=ユーザID' みたいな感じでオプション指定して使ってください。

Usage:
  asu [options]

Options:
  --id=[SEGA ID]   , -i=[SEGA ID]   提督情報のSEGA ID
  --pass=[Password], -p=[Password]  提督情報のPassword
  --token=[Token]  , -t=[Token]     Admiral StatsのAPIトークン
  --autoupdate     , -a             30分に一度自動実行
  --help           , -h             ヘルプを表示します

Example:
  asu -h
  asu -i=aaa -p=bbb -t=ccc
  asu -i=aaa -p=bbb -t=ccc -a
"""

proc main() =
  let options = os.commandLineParams().join(" ").parseoptions
  if (options.help):
    echo HelpText
    return
  let checker = @[
    ("id", options.id),
    ("pass", options.pass),
    ("token", options.token),
  ]
  for val in checker:
    if (val[1] == ""):
      echo "エラー: " & val[0] & "は必須です"
      echo "ヘルプを参考にオプションを設定し直してください。"
      echo ""
      echo HelpText
      return
  if (not update(options)):
    echo "Admiral Statsのアップデートに失敗しました。"
    echo "ヘルプ(-h)オプションを参考に、設定内容を見直してください。"
    return
  if (options.autoupdate):
    echo "オートアップデートモードに入ります。"
    echo "30分毎に自動的に更新を行います。"
    while true:
      sleep(30 * 60 * 1000)
      discard update(options)
main()

