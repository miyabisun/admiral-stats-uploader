# Overview

非公式提督情報表示ツール[Admiral Stats](https://www.admiral-stats.com/)を便利に扱う非公式コマンドラインツールです。

## Adminal Statsとは

[Admiral Stats](https://www.admiral-stats.com/)は非公式の提督情報蓄積ツールです。

公式の提督情報が裏でやり取りしているJSONファイルを利用して、  
Admiral Statsのサーバーに流し込むことで提督情報では表示されないサマリー的な情報を閲覧できます。  

詳細は[Admiral Stats の使い方](https://www.admiral-stats.com/manual/exporter)を参照してください。

## Admiral Stats Uploaderとは

Admiral Statsでのファイルアップロード作業を更に便利にするコマンドラインツールです。  

# Installation

リリースノートにて実行ファイルを配布します。

(ただいま実装中です。暫くお待ちください。)

OSに対応している実行ファイルをダウンロードしてください。  
パソコン操作に慣れている方はPATHの通ったフォルダに移動すると便利かと思います。

# Usage

本家Admiral Stats Exporterとは使い方が全く異なるので注意してください。  
`-h`オプション付きで実行すると使い方説明が表示されます。

```Bash
$ asu -h
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
```

注意: 利用には以下の情報が必要となります。  
エンジニアの矜持に誓ってこれらの情報は持ち逃げしませんが、  
気になる方はパケットキャプチャー等を使って動作を見張ってください。

- 提督情報のSEGA ID
- 提督情報のPassword
- Admiral StatsのAPIトークン

asu.exeという実行ファイルで配布されます。  
オプションの内、id、pass、tokenの3つの項目は必須です。  
1個でも情報が足りない場合は不足していますという趣旨のエラー文が(日本語で)表示されます。

特に注目すべきは「autoupdate」の項目です。  
ツールを実行した瞬間に1度目の提督情報のダウンロード、Admiral Statsへのアップロードを行った後、30分に1度の更新モードに入ります。  
(その気になれば数分おきに実行する事も可能ですが、公式サイトへの負担を考慮して30分に1度のペースで行う控えめな設定にしました。)

(直接asu.exeを実行する方法も載せるよう考えています)

# Development

下記の情報は開発者向け情報です。

## 開発動機

何故非公式コマンドラインツールを作ったのか？

現状のエクスポータはユーザーが使うのに大変だなと感じました。  
最も簡単なブックマークレート版は手作業でポチポチする必要があります。  
従って、資源が上限値まで溜まる瞬間を見逃しがちです。

RubyやPython、PowerShell版はOSによって動作する環境がまちまちで、  
ブックマークレート版と比べるとタスクスケジューラで自動化出来るのが強みですが、  
非エンジニアの方目線では自動化はとても困難で、(恐らく)使われていません。

そこでもう一つの選択とするべく実行ファイルを直接作って配布出来るような仕組みを考えました。

## 環境

言語はNimを利用しています。  
また開発の支援用にNode.jsを採用しました。

```Bash
$ nim -v
Nim Compiler Version 0.18.1 [Linux: amd64]
Copyright (c) 2006-2018 by Andreas Rumpf

active boot switches: -d:release

$ nimble -v
nimble v0.8.10 compiled at 2018-03-24 19:16:39
git hash: 347b6b7ab135e4d01a4f383db9bef2abdefb664c

$ node -v
v9.9.0
```

## テスト方法

テストはコマンドライン引数を指定してやるという事はせず、  
環境変数に依存する仕組みになっています。

- AS_ID: 提督情報のSEGA ID
- AS_PASS: 提督情報のPassword
- AS_TOKEN: Admiral StatsのAPIトークン

テストの方法は二通り用意しています。

```Bash
# 全てのテストを実施
$ nimble test

# ファイルを監視して更新したタイミングで実施
$ npm test

> admiral_stats_exporter_cli@1.0.0 test /root/project/admiral-stats-uploader
> node bin/watch

Get Ready.
---------- ---------- ----------
```

## ビルド・リリース方法

未着手

