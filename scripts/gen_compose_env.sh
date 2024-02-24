#!/bin/bash

readonly SSH_USER=username
readonly n="\n"

# todo ファイルパス移動して
source ./docker/useful_function.sh

# source ../.env

# Shellのエラーハンドリング
# https://www.marketechlabo.com/bash-batch-best-practice/

# || の意味
# https://qiita.com/sh19910711/items/db382a9da77e8ebbf041

# echo "$(date +'%Y-%m-%d %H:%M:%S') Started."

usage() {
  local -r hoge="This is usage"
  local -r SCRIPT=$(basename ${0})

  printf "$SCRIPT is a tool to generate env file for each environment.$n"
  printf "Usage:$n"
  printf "$SCRIPT [base env] [--debug | -d]$n"
  printf "$(basename ${0})$n"
}

# usage: file_env VAR [DEFAULT]
#    ie: file_env 'XYZ_DB_PASSWORD' 'example'
# (will allow for "$XYZ_DB_PASSWORD_FILE" to fill in the value of
#  "$XYZ_DB_PASSWORD" from a file, especially for Docker's secrets feature)
file_env() {
	local var="$1"
	local fileVar="${var}_FILE"
	local def="${2:-}"
  # 間接参照
	if [ "${!var:-}" ] && [ "${!fileVar:-}" ]; then
		printf >&2 'error: both %s and %s are set (but are exclusive)\n' "$var" "$fileVar"
		exit 1
	fi

	local val="$def"
	if [ "${!var:-}" ]; then
		val="${!var}"
	elif [ "${!fileVar:-}" ]; then
		val="$(< "${!fileVar}")"
	fi

  # 環境変数定義
	export "$var"="$val"
	unset "$fileVar"
}

_main() {
  init_template

  # if [ $# -lt 1 ]; then
  #   usage
  #   exit 0
  # fi

  # 引数にexamaple ファイルを指定 ⇒ exampleすらない方がいいかもしれない。
  # 

  usage

  for arg in "$@"; do
    case "$arg" in
    dev)
      printf "dev req"
      ;;
    -* | --*=) # unsupported flags
      echo "Error: Unsupported flag $1" >&2
      exit 1
      ;;
    *) # preserve positional arguments
      usage
      exit 1
      # PARAMS="$PARAMS $1"
      # shift
      ;;
    esac
  done
}

_main

# case "$1" in

# # 選択リストのオプション
# OPTIONS=("Option 1" "Option 2" "Option 3")

# # 初期の選択を設定
# SELECTED=()

# # 各選択肢
# for OPTION in "${OPTIONS[@]}"; do
#   SELECTED+=(" ")
# done
