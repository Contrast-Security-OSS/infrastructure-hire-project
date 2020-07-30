FROM python:3.7-alpine

COPY requirements.txt /

RUN pip install -r /requirements.txt

COPY app/ app/

WORKDIR /app

CMD [ "gunicorn", "--bind", "0.0.0.0:8080","wsgi:app" ]