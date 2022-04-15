sudo chmod 777 /tmp/restart_docker;
touch /tmp/error_webfms_209_89.log;
touch /tmp/supervisord_webfms_209_89.log;
touch /tmp/uwsgi_0.6_webfms_209_89.log;
touch /tmp/kafka_service_webfms_209_89.log;
touch /tmp/access_webfms_209_89.log;
sudo docker-compose down; sudo docker-compose up -d;
