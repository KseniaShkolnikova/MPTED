FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

RUN apt-get update && apt-get install -y \
    gcc \
    libpq-dev \
    postgresql-client \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app/project

COPY project/requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir psycopg2-binary
RUN pip install --no-cache-dir -r /tmp/requirements.txt

COPY project/ /app/project/

EXPOSE 8000

CMD ["sh", "-c", "python manage.py migrate && python manage.py ensure_superuser && python manage.py collectstatic --noinput && gunicorn project.wsgi:application --bind 0.0.0.0:8000 --workers ${WEB_CONCURRENCY:-2} --timeout ${GUNICORN_TIMEOUT:-120}"]
