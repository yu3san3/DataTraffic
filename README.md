# データ通信量(仮)

#### モバイルデータ通信量の許容量(目安)を簡単に確認できるiOSアプリです。

## アプリ概要
契約しているプランのデータ容量を登録すれば、現時点におけるデータ使用量の目安を簡単に確認することができます。

例えば、月に30GBの容量を使える契約をしているとします。  
それをこのアプリに登録すると、◯月1日には1GB、◯月2日には2GB、◯月30日には30GBといったように、契約プランの容量を日割りして、その時々で許容されるデータ通信量を確認することができます。

## 画面イメージ
<img src="https://user-images.githubusercontent.com/125545184/223168879-8e107862-c9d2-4e25-9ee4-db6d8fa27103.png" width="240px">
<img src="https://user-images.githubusercontent.com/125545184/223169050-44f54839-89f8-4e59-8ff6-a00de17bc471.png" width="240px">
<img src="https://user-images.githubusercontent.com/125545184/223169263-6745967b-51ac-4d79-b0f6-64207a940c24.png" width="240px">

## 開発の背景
iPhoneには、モバイルデータ通信の使用状況を確認する機能があります。(設定→モバイル通信)

そこには、現在自分がモバイルデータ通信を何GB使用しているのかが表示されるのですが、

- データ通信を「使いすぎているのか」
- それとも「あまり使っていないのか」

が、数字だけではあまり分かりません。

そこで、データ通信の使用量の多寡をさっと把握できるように、データ通信量の目安を表示するアプリを開発しようと考えました。

### 開発期間
- 約2週間

### 使用技術

- Swift
- SwiftUI

## 今後の展望
- トップ画面が寂しいです。「これを表示したらアプリがもっと便利になる」という確証を持てるような要素が見つかれば、実装したいです。
- 使用量の目安をグラフとして視覚的に見られれば便利だと思っていましたが、比較するべき数字が同じ画面内にないので、グラフが無意味であるような気もします。どのような画面表示が一番良いのか、常に考えて開発を進めていきたいです。
- 実際のデータ通信量も表示させたかったのですが、技術的に難しかったです。キャリアのWebサイトからスクレイピングをすれば実現できるのかもしれませんが、サイトの規約などの問題があると思いました。
- ウィジェットでデータ通信量の目安を確認できれば便利だろうと思ったのですが、現時点では完成していません。早く実装したいです。

## 機能一覧
- 現時点におけるデータ使用量の目安を、簡単に確認することができる
- 契約しているプランのデータ容量を自由に編集することができる

# こだわったポイント

## アプリのUI/UX

- データ使用量の目安をすぐに確認できるよう、アプリを起動してすぐのところに大きく表示されるようにした。
- 契約データ量は頻繁に変わるものではないので、意図せず編集してしまわないよう、奥まった場所に編集画面を配置した。

など、情報を素早く得られるような工夫や、意図した操作のみを確実に行えるような工夫を凝らし、使う人のことを考えたアプリに仕上げました。

## グラフ内の文字表記

このアプリの根幹となるデータ使用量の目安を、いちばん目立つように太字で配置し、見やすいデザインとなるように工夫しました。

## 日付が変わると最新のデータを反映

日付が変わったらすぐに更新内容を画面に反映するようにし、古いデータを見てしまうのを防ぐ設計にしました。
