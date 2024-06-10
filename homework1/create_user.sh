#!/bin/bash

while getopts ":d:" opt; do
  case $opt in
    d)
      root_dir="$OPTARG"
      ;;
    \?)
      echo "Неверный ключ: -$OPTARG" >&2
      exit 1
      ;;
  esac
done

if [ -z "$root_dir" ]; then
  read -p "Введите путь к корневой директории создания директорий: " root_dir
fi

if [ ! -d "$root_dir" ]; then
  echo "Указанная директория не существует: $root_dir" >&2
  exit 1
fi

log_file="script.log"

users=$(getent passwd | cut -d: -f1)

for user in $users; do
  user_dir="$root_dir/$user"
  mkdir -p "$user_dir"

  chmod 755 "$user_dir"

  chown "$user:$user" "$user_dir"

  echo "$(date '+%Y-%m-%d %H:%M:%S') - Создана директория для пользователя $user: $user_dir" | tee -a "$log_file"
done

echo "Все директории созданы и права установлены."
echo "Лог записан в файл: $log_file"