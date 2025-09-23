#!/bin/bash

files_and_paths=(
  ".gitconfig:~/.gitconfig"
  "nvim:~/.config/nvim"
)

# シンボリックリンクを作成する関数
create_symlink() {
  local source_file="$1"
  local destination_path="$2"

  # ソースファイルが存在するかチェック
  if [ ! -e "$source_file" ]; then
    echo "エラー: ソースファイル '$source_file' が存在しません"
    return 1
  fi

  # 絶対パスに変換
  local absolute_source=$(realpath "$source_file")
  local backup_file="${destination_path}.bak"     # 退避先のファイル名

  # 展開されたホームディレクトリパスを取得
  local expanded_destination=$(eval echo "$destination_path")

  if [ -e "$expanded_destination" ]; then
    mv "$expanded_destination" "${expanded_destination}.bak"
    echo "既存のファイル '$expanded_destination' を '${expanded_destination}.bak' にバックアップしました"
  fi

  # 必要に応じて親ディレクトリを作成
  mkdir -p "$(dirname "$expanded_destination")"

  ln -s "$absolute_source" "$expanded_destination"  # シンボリックリンクの作成
  echo "シンボリックリンクを作成しました: '$absolute_source' -> '$expanded_destination'"
}

for entry in "${files_and_paths[@]}"; do
  IFS=":" read -r source_file destination_path <<< "$entry"
  echo "処理中: $source_file -> $destination_path"
  create_symlink "$source_file" "$destination_path"
done