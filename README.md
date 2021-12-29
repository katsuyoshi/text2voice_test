# text2voice_test

[Japanese](https://github.com/katsuyoshi/text2voice_test/blob/main/README_ja.md)

It is a test program for [VoiceText Web API](https://cloud.voicetext.jp/webapi), which HOYA Corporation provides.


# How to use

## Gem install

To install gems, execute the bundle command.

```
% cd text2voice_test
% bundle
```

## Set API Key

You can get API Key from the below link.

https://cloud.voicetext.jp/webapi/api_keys/new

Copy ```.env.sample``` to ```.env``` file.

```
% cp .env.sample .env
```

Replace YOUR_API_KEY with your API key in ```.env``` file.

```.env
TEXT2VOICE_APIKEY=YOUR_API_KEY
```

## Execution

Run text2voice_test.rb script.

```
% ruby text2voice_test.rb

0. Play with the selected conditions.
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

Choose command No. and then set parameters.

- 0: Speak with current conditions. (Or just press enter key.)
- 1-6: You can set [parameters](https://cloud.voicetext.jp/webapi/docs/api) for VoiceText Web.
- H: Show histories and speak with its conditions.
- Q: Quit
