# Tech.Uni Member-Site-App
<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
[![All Contributors](https://img.shields.io/badge/all_contributors-1-orange.svg?style=flat-square)](#contributors-)
<!-- ALL-CONTRIBUTORS-BADGE:END -->

## 使用技術

- [Flutter](https://flutter.dev/)
  - Flutter は Google 社が開発しているオープンソースのアプリケーションフレームワーク。
  - クロスプラットフォームに対応しており、ワンソースで複数のプラットフォーム（iOS、Android、Web、Windows、Mac、Linux）に対応したアプリを開発することができます。
- [GitMoji](https://gitmoji.dev/) 😜
  - Commit メッセージに絵文字を使うことでパッと見で分かりやすくするものです。

## セットアップ

### ① Flutterの環境構築

まずは、Flutterを使える環境を用意しましょう
- [macの人向け](https://zenn.dev/kboy/books/ca6a9c93fd23f3/viewer/5232dc)
- [windowsの人向け](https://qiita.com/smiler5617/items/fbfee798b641f0352176)


### ② リポジトリのクローン

このリポジトリをローカル環境にクローンしてください。

コマンドで行う場合

```
git clone https://github.com/TechUni2020/Tech.Uni_Members.git
```

VS Code で行う場合は、リポジトリをクローンする（英語だと Clone Repository）というボタンがあるので、それをクリックしていただき、`https://github.com/TechUni2020/Tech.Uni_Members.git` を入力してエンターを押してください。


## 開発する

開発を行う場合

※先にシミュレーターを立ち上げておきましょう

```
flutter run // シミュレーターに起動されます
```

## Git ブランチルール

`main`

- マージされると本番に自動反映されます。

`develop`

- 本番反映前に確認するための環境（ステージング環境）。
- 常駐しているブランチで、feature からの変更を受け付け、main にマージする。

`hotfix`

- 本番で発生した緊急のバグに対処するためのブランチ。
- 必ず main から分岐し、main と develop にマージする。

`feature/あなたのGitHub名_*`

- 開発にはここを用いる。
- 必ず develop から分岐し、develop にマージする。
- 「あなたの GitHub 名」にはアカウント名を入力。
- `*` は開発するものを簡易的に記入。
- 例: feature/shouhi_add-about-page

`main`, `develop`, `hotfix` に直接 push してはいけません。基本的に皆さんが触って良いのは `feature/あなたのGitHub名_*` ブランチだけです。

## Contributors ✨

Thanks goes to these wonderful people

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="https://twitter.com/shouhi_ide"><img src="https://user-images.githubusercontent.com/63713624/123041698-9f3c9b00-d430-11eb-8faf-e98e27e347db.jpg" width="100px;" alt=""/><br /><sub><b>井手翔陽</b></sub></a><br /><a href="https://github.com/TechUni2020/member-site-app/commits?author=shouhi" title="Documentation">📖</a> <a href="#projectManagement-shouhi" title="Project Management">📆</a>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!
