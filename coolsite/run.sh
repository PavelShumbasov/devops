#!/bin/bash

# Проверка на наличие аргумента
if [ -z "$1" ]; then
  echo "Необходимо указать тег. Пример использования: ./run.sh <тег>"
  exit 1
fi

# Запуск контейнеров с использованием docker-compose
TAG=$1 docker-compose up -d
