# Overview

[Admiral Stats](https://www.admiral-stats.com/)の非公式コマンドラインツールです。

## ここがダメだよ艦これアーケード

艦これアーケードでは艦娘ドロップ時にカード化せずに改装設計図と交換することも可能で、  
この改装設計図を複数枚用意すれば、改カードと直接交換することも可能です。

よほど気に入った嫁であれば複数枚排出して重ねて使うと多少の戦闘能力向上にはなりますが、  
微々たる性能しか上がらないので、基本的にダブった艦娘は全て改装設計図にしてしまった方が得です。  

しかし、どの艦娘カードを既に所持しているかは公式サイトの提督情報からは極めて分かりづらく、  
出撃後の艦娘着任時の30秒弱でスマホを弄って所持しているか否かを確認することは不可能であり、  
提督は200枚弱の艦娘カードをゲームセンターに持ち込んで、艦娘着任の度に目視で確認する理不尽極まりない作業を強制させられます。

## Adminal Statsとは

[Admiral Stats](https://www.admiral-stats.com/)は非公式の情報蓄積ツールです。

公式の提督情報が裏でやり取りしているJSONファイルをダウンロードして、  
Admiral Statsのサーバーに流し込むことで提督情報では表示されないサマリー的な情報を閲覧できます。

![使い方](https://www.admiral-stats.com/assets/home/admiral_stats_concept-903bc7e44ef6c9b48e6ed31b66f25baca6a8bc014934c79b5bef5267cb810b2d.png)

## 何故非公式コマンドラインツールを作ったのか？

現状のエクスポータはユーザーが使うのに大変だからです。  
最も簡単なブックマークレート版は手作業でポチポチする必要があります。  
従って、資源が上限値まで溜まる瞬間を見逃しがちです。

RubyやPython、PowerShell版はOSによって動作する環境がまちまちで、  
ブックマークレート版と比べるとタスクスケジューラで自動化出来るのが強みですが、  
非エンジニアの方目線では自動化はとても困難で、(恐らく)使われていません。

そこでもう一つの選択とするべく実行ファイルを直接作って配布出来るような仕組みを考えました。

# Installation

リリースノートに実行ファイルを配布します。

(未実装)

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

オプションの内、id、pass、tokenの3つの項目は必須です。  
1個でも情報が足りない場合は不足していますという趣旨のエラー文が(日本語で)表示されます。

特に注目すべきは「autoupdate」の項目です。  
ツールを実行した瞬間に1度目の提督情報のダウンロード、Admiral Statsへのアップロードを行った後、30分に1度の更新モードに入ります。  
(その気になれば数分おきに実行する事も可能ですが、公式サイトへの負担を考慮して30分に1度のペースで行う控えめな設定にしました。)

# Development

下記の情報は開発者向け情報です。

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

