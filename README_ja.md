# text2voice_test

[English](https://github.com/katsuyoshi/text2voice_test/blob/main/README.md)

HOYA株式会社で提供している[VoiceText Web API](https://cloud.voicetext.jp/webapi)の動作確認用です。

# 使用方法

## Gem インストール

bundleコマンドで必要なgemをインストールします

```
% cd text2voice_test
% bundle
```

## APIキー設定

以下のリンクよりAPIキーを取得します。

https://cloud.voicetext.jp/webapi/api_keys/new

.env.sampleファイルをコピーし.envファイルを作成します。

```
% cp .env.sample .env
```

.envファイルのYOUR_API_KEYの部分を取得したAPIキーに置き換えます。

```.env
TEXT2VOICE_APIKEY=YOUR_API_KEY
```

## 実行

text2voice_test.rbスクリプトを実行します。

```
% ruby text2voice_test.rb

0. Play selectd condition.
1. Set text to say.         current: こーんにーちは。こんにちはじゃねぇよこんばんはだろう。
2. Select speaker.          current: haruka
3. Select emotion.          current: happiness
4. Set emotion level.       current: 4
5. Set pitch.               current 100%
6. Set speed.               current 100%
H. History.
Q. Quit.

Choose a command No.: 
```


コマンド番号を選択し、パラメータを設定します。

- 0: 現在の条件で話します。(↩キーのみも同様)
- 1-6: VoiceText Web APIの[パラメータ](https://cloud.voicetext.jp/webapi/docs/api)を設定します。
- H: セットしたパラメータの履歴を表示しその条件で話すことができます。
- Q: 終了します。
