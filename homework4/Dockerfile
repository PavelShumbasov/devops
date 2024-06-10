# Используем официальный образ Ubuntu 20.04
FROM ubuntu:20.04

# Информация о создателе образа
MAINTAINER Шумбасов Павел <pavelshumbasov2335@gmail.com>

# Установка переменных среды для предотвращения появления запросов во время установки
ENV DEBIAN_FRONTEND=noninteractive

# Обновление и установка необходимых пакетов, включая Apache, MySQL и другие утилиты
RUN apt-get update && \
    apt-get install -y apache2 mysql-server && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Установка рабочего каталога
WORKDIR /var/www/html

# Добавление простого HTML-файла в корневой каталог Apache
ADD index.html /var/www/html/index.html

# Копирование образца файла конфигурации MySQL
COPY my.cnf /etc/mysql/my.cnf

# Открытие порта 80 для веб-сервера и 3306 для MySQL
EXPOSE 80 3306

# Создание тома для данных MySQL
VOLUME ["/var/lib/mysql"]

# Установка пользователя, от имени которого будет выполняться контейнер
USER www-data

# Запуск сервисов Apache и MySQL при запуске контейнера
CMD ["sh", "-c", "service mysql start && apache2ctl -D FOREGROUND"]
