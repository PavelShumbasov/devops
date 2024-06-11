#!/bin/bash

log() {
  message="$1"
  echo "$(date '+%Y-%m-%d %H:%M:%S') - $message" | tee -a "$log_file"
}

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

  if [ ! -d "$user_dir" ]; then
    mkdir -p "$user_dir"

    if [ $? -eq 0 ]; then
      chmod 755 "$user_dir"

      group=$(getent passwd "$user" | cut -d: -f4)
      group_name=$(getent group "$group" | cut -d: -f1)

      if [ -n "$group_name" ]; then
        chown "$user:$group_name" "$user_dir"
        if [ $? -eq 0 ]; then
          log "Создана директория для пользователя $user: $user_dir"
        else
          log "Ошибка при назначении прав для пользователя $user: $user_dir"
        fi
      else
        log "Группа для пользователя $user не найдена: $user_dir"
      fi
    else
      log "Ошибка при создании директории для пользователя $user: $user_dir"
    fi
  else
    log "Директория для пользователя $user уже существует: $user_dir"
  fi
done

echo "Все директории созданы и права установлены."
echo "Лог записан в файл: $log_file"
