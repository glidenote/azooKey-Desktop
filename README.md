# azooKey on macOS

[azooKey](https://github.com/ensan-hcl/azooKey)のmacOS版です。高精度なニューラルかな漢字変換エンジン「Zenzai」を導入した、オープンソースの日本語入力システムです。

**現在アルファ版のため、動作は一切保証できません**。

## 動作環境

macOS 14とmacOS 15で動作確認しています。macOS 13でも利用できますが、動作は検証していません。

## リリース版インストール

[Releases](https://github.com/ensan-hcl/azooKey-Desktop/releases)から`.pkg`ファイルをダウンロードして、インストールしてください。

その後、以下の手順で利用できます。

- macOSからログアウトし、再ログイン
- 「設定」>「キーボード」>「入力ソース」を編集>「+」ボタン>「日本語」>azooKeyを追加>完了
- メニューバーアイコンからazooKeyを選択

## コミュニティ

azooKey on macOSの開発に参加したい方、使い方に質問がある方、要望や不具合報告がある方は、ぜひ[azooKeyのDiscordサーバ](https://discord.gg/dY9gHuyZN5)にご参加ください。


### azooKey on macOSを支援する

GitHub Sponsorsをご利用ください。


## 機能

* ニューラルかな漢字変換システム「Zenzai」による高精度な変換
  * プロフィールプロンプト機能
  * 履歴学習機能
  * ユーザ辞書機能
  * 個人最適化システム「[Tuner](https://github.com/azooKey/Tuner)」との連携機能

* ライブ変換
* LLMによる「いい感じ変換」機能
* その他の

## 開発ガイド

コントリビュート歓迎です！！

### 想定環境
* macOS 14+
* Xcode 16+
* Git LFS導入済み
* SwiftLint導入済み

### 開発版のビルド・デバッグ

cloneする際には`--recursive`をつけてサブモジュールまでローカルに落としてください。

```bash
git clone https://github.com/azooKey/azooKey-Desktop --recursive
```

以下のスクリプトを用いて最新のコードをビルドしてください。`.pkg`によるインストールと同等になります。その後、上記の手順を行ってください。また、submoduleが更新されている場合は `git submodule update --init` を行ってください。

```bash
# submoduleを更新
git submodule update --init

# ビルド＆インストール
./install.sh
```

開発中はazooKeyのプロセスをkillすることで最新版を反映することが出来ます。また、必要に応じて入力ソースからazooKeyを削除して再度追加する、macOSからログアウトして再ログインするなど、リセットが必要になる場合があります。

### 開発時のトラブルシューティング

`install.sh`でビルドが成功しない場合、以下をご確認ください。

#### 1. Git LFSとサブモジュールの初期化

リソースファイル（機械学習モデルなど）が見つからないエラーが発生する場合：

```bash
# Git LFSをインストール（Homebrewを使用）
brew install git-lfs

# Git LFSを初期化
git lfs install

# サブモジュールを初期化・更新
git submodule update --init --recursive

# 各サブモジュールでGit LFSファイルを取得
cd azooKeyMac/Resources/base_n5_lm
git reset --hard HEAD

cd ../zenz-v3-small-gguf
git reset --hard HEAD

# プロジェクトルートに戻る
cd ../../..
```

#### 2. コード署名の問題

「No profiles for team」や「No Account for Team」エラーが発生する場合、`install.sh`は自動的にコード署名を無効化してローカル開発用にビルドします。手動で対処する場合は以下を確認してください：

* XcodeのGUI上で「Team ID」を変更する必要がある場合があります
* 「Packages are not supported when using legacy build locations, but the current project has them enabled.」と表示される場合は[https://qiita.com/glassmonkey/items/3e8203900b516878ff2c](https://qiita.com/glassmonkey/items/3e8203900b516878ff2c)を参考に、Xcodeの設定をご確認ください

#### 3. 変換精度の確認

変換精度がリリース版に比べて悪いと感じた場合、以下をご確認ください：
* Git LFSが導入されていない環境では、重みファイルがローカル環境に落とせていない場合があります。`azooKey-Desktop/azooKeyMac/Resources/zenz-v3-small-gguf/ggml-model-Q5_K_M.gguf`が70MB程度のファイルとなっているかを確認してください

### pkgファイルの作成
`pkgbuild.sh`によって配布用のdmgファイルを作成できます。`build/azooKeyMac.app` としてDeveloper IDで署名済みの.appを配置してください。

### TODO
* 予測変換を表示する
* CIを増やす
  * アルファ版を自動リリースする
* 「いい感じ変換」の改良
* 「Tuner」との相互運用性の向上

### Future Direction

* WindowsとLinuxもサポートする
  * @7ka-Hiira さんによる[fcitx5-hazkey](https://github.com/7ka-Hiira/fcitx5-hazkey)もご覧ください
  * @fkunn1326 さんによる[azooKey-Windows](https://github.com/fkunn1326/azooKey-Windows)もご覧ください

* iOS版のazooKeyと学習や設定を同期する

## Reference

Thanks to authors!!

* https://mzp.hatenablog.com/entry/2017/09/17/220320
* https://www.logcg.com/en/archives/2078.html
* https://stackoverflow.com/questions/27813151/how-to-develop-a-simple-input-method-for-mac-os-x-in-swift
* https://mzp.booth.pm/items/809262

## Acknowledgement
本プロジェクトは情報処理推進機構(IPA)による[2024年度未踏IT人材発掘・育成事業](https://www.ipa.go.jp/jinzai/mitou/it/2024/koubokekka.html)の支援を受けて開発を行いました。
