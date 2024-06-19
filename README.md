# [MotoTokyo](https://moto-tokyo.com)

![OGP](https://github.com/miyataro0314/MotoTokyo/assets/125170964/8d353014-767f-4926-8c15-d0fc07cf6a7b)

東京を走るライダーの皆さん集まれ〜〜〜！

MotoTokyoは東京特化のバイクツーリングサポートサービスです。

スポットと付近の駐輪場、東京の天気の情報が一度に取得でき、ユーザーによるスポット投稿・ブックマークも可能です。

ブックマークや検索履歴に応じておすすめスポットの提案もしてくれます。


## 開発の背景
私は月に数回、東京へツーリングに行きます。活気に溢れている東京の街並みの中を、実際に風を切って走るのがとても好きなんです。

ただ、東京エリアのツーリングでいつも困るのがパーキングの問題です。規模の大きい施設であれば、バイク専用パーキングが用意されているところもありますが、食事やショッピングが目的の場合、まず利用可能なパーキングを探すところから始める必要があります。パーキングを探して、そこから行ける範囲でスポットを探して...という手間があり、実際にバイクで行く場所はほとんど同じ場所でした。

きっと同じような悩みを抱えているライダーの方も沢山いると思い、スポットとパーキングのマッチングを促進させるアプリの開発を行うことにしました。

当サービスにはあらかじめ都内のパーキング情報が約600件登録してあります。ユーザーがお気に入りのスポットを投稿すると、付近のパーキング情報をデータベースから取得し、同一画面で表示してくれます。
これにより、ユーザーはパーキングを探す手間を排除しつつ、新しいスポットを見つけることができます。

また、東京エリアは交通量も多く、道も複雑なため、中々知らない道を走るのが不安なこともあります。
そのような悩みを解決するため、スポットに行きやすさの投票機能を実装しております。
ユーザーは自由に投票が行え、各項目は一目でわかるよう色分けしてグラフ化して表示されます。

東京を走るライダーの皆さまが、より多くの素敵なスポットに出会えるように、これからも開発を続けてまいります。


## こだわりポイント（ユーザビリティ）
- ユーザーが最も必要としている『スポット情報』と『付近の駐車場情報』を1つの画面上で確認できるようにしました。
- スポット登録ではウィザードフォームにすることで、淡々とした入力作業にならないようにしました。
- 初心者ライダーがスポットを選びやすくなるように、交通量や道の複雑さを考慮した行きやすさの投票機能を実装しました。
- ツーリングでは天候が重要なため、東京エリアの天気情報を掲載しました。
- バイクから降りなくても操作ができるよう、シンプルかつ直感的に操作できるUIを目指しました。
  各ボタンは大きく配置しつつ、スクロールの少ない画面設計にしており、グローブを着用したままでも操作しやすいようにしました。
- ユーザー情報の不特定多数への公開を避けるため、ユーザーIDを知っている場合のみ友達に追加できるようにしました。
  （類似サービスでは「フォロー」機能が原因で出会い厨が多発したため、当サービスではユーザーIDを知っている場合に限り友達追加が可能です。）
- タブレット以上の画面サイズの端末からアクセスしている場合、スマホでの利用を案内するQRコードが表示するようにしました。
- PWAに対応していることが一般ユーザーからもわかるよう、GIFでの案内を追加しました。


## こだわりポイント（開発面）
- スポット登録機能ではsessionStrageでデータを管理する自作のウィザードフォームを実装しました。
- 営業時間や定休日、住所などのスポットの詳細情報はGoogleMapAPIを使用して取得することで、ユーザーの入力項目を最小限に抑えました。
- turboで実装したモーダルや部分更新を多くのページで取り入れ、バイク乗車時でも使用しやすいスクロールの少ない画面設計を実現しました。
- マップビュー（マップ上で全件のスポットを表示する機能）では、表示範囲内のマーカーのみを動的に表示に切り替えることで、
　ユーザー端末への負担を軽減させました。
- スポットの閲覧履歴と検索履歴を基に、エリア、カテゴリ、駐車場有無の各項目で重み付けを計算し、全てのスポットでスコアを算出することで、
　ユーザーに合ったおすすめスポットを抽出するアルゴリズムを自作しました。
- PWAに対応させ、必要なときにすぐアクセスできるようにしました。
- 開発環境用・本番環境用の2つのcomposeファイルを用意し、本番環境で無駄なビルドが発生しない設計にしました。
　開発環境（web:アプリ本体、db:データベース、chrome:システムスペック） 本番環境（web:アプリ本体、nginx: nginx）
- nginxコンテナではCronを使用してSSL証明書を自動更新するように設計し、運営上の管理の手間を軽減しました。


## 主な機能
- お気に入りスポットの登録機能
- スポット付近のパーキング取得機能
- 行きやすさ投票機能
- スポットのブックマーク機能
- おすすめポイント（コメント）の投稿機能
- スポット投稿時、公式Xに自動ポスト機能
- スポットの検索機能
- 地図上での動的なスポット・パーキング閲覧機能（マップビュー）
- 東京エリアの天気情報の掲載
- 独自アルゴリズムによる閲覧履歴・検索履歴からのおすすめポイント提案機能
- プロフィール・愛車情報の登録機能
- 友達検索・追加機能
- 駐車場情報更新機能（管理者用）


## 今後開発予定の機能
- プッシュ通知機能（友達申請受信時等）
- スポット名・おすすめポイント（コメント）からのキーワード検索
- 行ったスポットの保存・管理機能
- マップビューのアップデート（動的な絞り込み機能）


## 外部API
- スポットオートコンプリート・詳細取得・マップ埋め込み
  - [GoogleMapApi](https://developers.google.com/maps?hl=ja)
- 天気取得
  - [天気予報API](https://weather.tsukumijima.net)
- 公式Xへの自動ポスト
  - [TwitterAPI V2](https://developer.x.com/ja/docs/twitter-api)
 
## 使用技術
| カテゴリ | 使用技術 |
| --- | --- |
| フロントエンド | HTML, CSS, JavaScript |
| バックエンド | Ruby on Rails |
| データベース | PostgresSQL |
| 環境構築 | DockerCompose |
| Webサーバー | Nginx |
| インフラ | AWS(EC2,RDS,S3) |
| CI/CD | GithubActions |
| CSSライブラリ | TailwindCSS, DaisyUI |
| その他 | Swiper, GoogleAnalytics, GoogleSearchConsole |


## ER図
[![Image from Gyazo](https://i.gyazo.com/d3e922527304a5c11cc9decba953752a.png)](https://gyazo.com/d3e922527304a5c11cc9decba953752a)


## 初期画面遷移図案
[Figma](https://www.figma.com/file/b2YCfKzmKqggwpyZhK91mq/%E7%94%BB%E9%9D%A2%E9%81%B7%E7%A7%BB%E5%9B%B3?type=design&node-id=0%3A1&mode=design&t=ZoZS5TOVkbeCjIzD-1)
