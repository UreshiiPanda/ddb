FROM python:latest

ARG mysql_host
ARG mysql_user
ARG mysql_password
ARG mysql_db
ARG mysql_port
ARG app_port
ARG session_key

WORKDIR /

COPY ./requirements.txt ./

ENV MYSQL_HOST=$mysql_host
ENV MYSQL_USER=$mysql_user
ENV MYSQL_PASSWORD=$mysql_password
ENV MYSQL_DB=$mysql_db
ENV MYSQL_PORT=$mysql_port
ENV APP_PORT=$app_port
ENV SESSION_KEY=$session_key

RUN pip install -r requirements.txt

COPY . .

EXPOSE 8000

CMD ["python", "app.py"]
