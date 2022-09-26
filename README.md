# 推し概念集めてみた

## サービス概要
推しの概念（イメージカラーやモチーフのもの）情報をスクラップブックのような形で収集することで、欲しい時に探しやすく集める楽しみも得られるサービスです

## メインのターゲットユーザー
年代は問わず、２次元に推しがいる女性

## なぜこのサービスを作りたいのか？
以前推しのイメージカラーとモチーフで全身固めてライブ参戦しようとしたときに、前もってネットやTwitter上で検索して画像保存しておいたつもりでも、いざ探し始めるといつ保存したか忘れてしまったり他の写真やツイートに埋もれたりしてすぐに見つけられなかった。また、推しっぽいカフェやお店をネットで見つけたときに「お気に入り」しておくけれど、月日が経つと同じく他の「お気に入り」に埋もれて見つけづらいという経験があった。そこで、いいなと思ったツイートやネットで見つけた情報、商品の画像を一箇所に集約しておけるサービスがあったら便利だなと思った。

## ユーザーが抱える課題
Twitterで検索したときにいいなと思うツイートがあっても、月日が経つと関係ないツイートに埋もれてしまって探すのが大変。また、ネットで探した情報もスクショや「お気に入り」などで保存する場所が散在していて、いざ欲しい時に探そうと思うと時間がかかる。

## 解決方法
自分の端末の中であちこちに分散されている情報を集約して、スクラップブックのような形で画像やURLをリスト保存することで、欲しい時にすぐ見つけられるようにする。

## サービス紹介
### TOPページ
<img src="https://i.gyazo.com/23a9f3d6243ca60e1ff4b16c88e44aa8.jpg" />

### ジャンルを追加
ジャンルを選択してから推しを登録する。
<img src="https://i.gyazo.com/934519b9afc6aef355177ecc0d9e724e.png" />

### 概念を投稿
上で追加したジャンルを選択して、カテゴリを選択し、投稿したいURLがTwitterかWEBページか選択して投稿する。
<img src="https://i.gyazo.com/15e0c2b288528b991a5a558952a40041.png"/>

### マイページ
右上のボタンで登録したジャンルを選択し、ALLボタンを押すとそのジャンルで投稿した概念がすべて表示される。
<img src="https://i.gyazo.com/c9e3a534fd03fc83f6cb47d1a34b250d.jpg"/>

### マイページ編集
ユーザー名や、マイページの上に表示されるマイページ名、マイページのアイコン画像の編集ができる。
<img src="https://i.gyazo.com/1a4c1bfc70c1147e7e8d3db559741c7f.png"/>

### 推しを編集
登録済みのジャンルを選択して、推しを追加したり削除したり編集できる。
<img src="https://i.gyazo.com/77530a4e85ea7452784d94d029d52986.png"/>

## 実装機能
- 未登録ユーザー
  - 編集不可のサンプルページを用意してマイページの雰囲気を知ってもらう
- 登録ユーザー
  - 作品（ジャンル）ごとに推しを登録したマイページを作成して、以下の３つのカテゴリ別にURLやツイートを保存できる
    - ファッション
    - 雑貨
    - 場所（お店や建物）
  - Twitterログイン実装
  - Twitterシェア機能実装

- 管理ユーザー
  - 登録ユーザーCRUD
  - マイページCRUD
  - 作品（ジャンル）CRUD
  - 作品（ジャンル）追加に伴いキャラCRUD

### 本番リリース後に追加予定機能
 - チェックボタンのようなもので実際に行った場所や買ったものが分かるようにする
 - URLだけでなく自分が保存した画像や写真をコメント付きで投稿できるようにする

## スケジュール
企画〜技術調査：5/25〆切
README〜ER図作成：6/2 〆切
メイン機能実装：6/2 - 7/31
β版をRUNTEQ内リリース（MVP）：8/7〆切
本番リリース：9/10

## 使用技術
< バックエンド ><br>
・Ruby 3.1.2<br>
・Rails 6.1.6<br>
< フロントエンド ><br>
・Vue.js 2.6.14<br>
・tailwindcss 3.0.24 (+daisyui 2.15.1)<br>
< インフラ ><br>
・heroku（デプロイ）<br>
・AWS S3（画像保存）<br>

## 画面遷移図
https://www.figma.com/file/KHw0qZ9Wad6BvZIRUyAjBc/oshi-concept?node-id=0%3A1

## ER図
https://drive.google.com/file/d/12xVbIFFxI2ZAHeXm9iArFJl1q2ExpkDT/view?usp=sharing
