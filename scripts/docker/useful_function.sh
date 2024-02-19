#!/bin/bash

function raise() {
  # 1>&2: 1の標準出力を、2の標準エラー出力にリダイレクト (https://simply-k.hatenadiary.org/entry/20100801/1280617927)
  echo $1 1>&2
  # exitではなく、コード1を返し、エラーハンドラにキャッチさせる
  return 1
}

function on_err() {
  local -r status=$?
  local -r line=$1
  err_str="ERROR: [$(date +'%Y-%m-%d %H:%M:%S')] ${SCRIPT}:${func_name}() returned non-zero exit status ${status} at line ${lineno}"
  #     echo "Called from line:${BASH_LINENO[0]}" こっちじゃだめ？

  echo ${err_str}
}

function finally() {
  printf 終了
}

function init_template() {
  #  -e:errexit, -u:nounset
  set -eu -o pipefail
  trap finally EXIT
  trap ERR
  cd $(dirname $0) || exit
}

# ##########
# memo
#
# $0 - 現在のスクリプトの名前
# $n - スクリプトに渡されたn番目の引数 ($1, $2, $3, ...)
# $# - スクリプトに渡された引数の数
# $* - スクリプトに渡された全ての引数
# $@ - スクリプトに渡された全ての引数（引用符内 で個々に処理）
# $? - 最後に実行されたコマンドの終了ステータス
# $PWD - 現在のディレクトリ
# $HOME - ホームディレクトリ
# $USER - 現在のユーザ名
# $HOSTNAME - 現在のホスト名
# $RANDOM - ランダムな整数
# $SECONDS - スクリプトが開始してからの秒数
# $LINENO - 現在実行しているスクリプトの行番号
# $BASH_VERSION - bashのバージョン
# $PS1 - プライマリプロンプト文字列

# shift と$@ の組み合わせで、可変長引数の処理に対応できそう？
