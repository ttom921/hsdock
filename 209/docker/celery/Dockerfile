# sudo docker build -f Dockerfile -t hs_celery:python3.9 .
# refer to https://github.com/tiangolo/uwsgi-nginx-docker/tree/master/docker-images

FROM python:3.9

LABEL maintainer="gavin <gavin@hisharp.com.tw>"

# 執行 apt 安裝時注意加入 -y --no-install-recommends，
# 並且在安裝完成後執行 rm -rf /var/lib/apt/lists/* && apt-get clean 命令，
# 可以有效減小鏡像的體積。
# Install Supervisord ...
# COPY resources/sources.list /etc/apt/
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    cron supervisor && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

COPY  resources/run-cron /etc/cron.d/run-cron
RUN chmod 0644 /etc/cron.d/run-cron
RUN crontab /etc/cron.d/run-cron

# Custom Supervisord config
COPY resources/supervisord-debian.conf /etc/supervisor/conf.d/supervisord.conf

# install pip modules
RUN pip install flask aiokafka coloredlogs Flask-HTTPAuth kafka-python \
    marshmallow marshmallow-sqlalchemy msgpack \
    numpy pandas Pillow psutil pyDes pytz pyzmq PyYAML pynng \
	qrcode requests schedule SQLAlchemy zmq redis APScheduler psycopg2 shapely geoalchemy2 Celery Authlib
COPY resources/requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy start.sh script that will check for a /app/prestart.sh script and run it before starting the app
COPY resources/start.sh /start.sh
RUN chmod +x /start.sh

# Add demo app
COPY ./app /app
WORKDIR /app

# Run the start script, it will check for an /app/prestart.sh script (e.g. for migrations)
# And then will start Supervisor, which in turn will start Nginx and uWSGI
CMD ["/start.sh"]
