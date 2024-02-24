## Develop
### Shellscript
1. 
1. 編集後
  1. syntax check
  bash -n script.sh

## Commit
`commit type` としては次のようなものがあります。

- feat
    - 新しい機能、章、節の追加など
    - 更新履歴に載るような新しいページを追加
- fix
    - 意味が変わる修正
    - 更新履歴に載るような修正
- docsK
    - 基本的には使わない
    - README.mdやCONTRIBUTING.mdや本体のプロジェクト全体のドキュメントについて
- refactor
    - 意味が変わらない修正
    - 更新履歴に載らないような修正
- style
    - スペースやインデントの調整
    - Lintエラーの修正など
- perf
    - パフォーマンス改善
- test
    - テストに関して
- chore
    - その他
    - typoの修正など


`commit type`は、迷ったらとりあえず`chore`と書きます。
`scope`も省略して問題ないので以下のような形でも問題ありません。

```
chore: コミットメッセージ
```