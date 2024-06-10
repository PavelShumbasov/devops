# Stage 1: Build stage
FROM python:3.10.10-slim AS builder

WORKDIR /app

# Скопируем файл зависимостей
COPY requirements.txt .
# Установка зависимостей
RUN pip install --user -r requirements.txt

# Скопируем исходный код приложения
COPY . .

# Скопируем конфигурационный файл Loki
COPY etc/loki/local-config.yaml /etc/loki/local-config.yaml

# Stage 2: Final stage
FROM python:3.10.10-slim

WORKDIR /app

# Скопируем установленные зависимости из builder
COPY --from=builder /root/.local /root/.local
# Скопируем исходный код из builder
COPY --from=builder /app /app

ENV PATH=/root/.local/bin:$PATH

# Установка переменной окружения для Django
ENV DJANGO_SETTINGS_MODULE=coolsite.settings

# Запуск приложения
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
