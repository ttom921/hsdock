#!/bin/bash                                                                                                                                                                                                                                                                     
# 將上傳的python檔案更新到指定的位置
#
# 2020-05-20
#
#
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH


tarfile=$1

# 相關變數
uwsgisrv="uwsgi05.service"
username="ubuntu"

echo "tarfile=${tarfile}"

echo "目前路徑"
currdir="/home/${username}/jkapi"
cd ${currdir}
#pwd
#ls
echo "解壓----${tarfile}"
tar -zxvf ${tarfile}

echo "停止docker服務"
#sudo systemctl stop "${uwsgisrv}"
#sudo docker-compose -f ~/docker/uwsgi/docker-compose.yml down
sudo docker-compose -f ~/docker/hsweb/docker-compose.yml down
sudo docker-compose -f ~/docker/hsschedule/docker-compose.yml down

echo "刪除 python code"
sudo rm -rf /home/${username}/server.viewtec/*
echo "刪除 /home/${username}/server.viewtec/*"

sudo rm -rf /home/${username}/server.viewtec/.git
echo "刪除 /home/${username}/server.viewtec/.git"

echo "覆蓋 python code"
mv -f ${currdir}/pycodedata/code/ /home/${username}/server.viewtec/
echo "mv -f ${currdir}/pycodedata/code/ /home/${username}/server.viewtec/"
mv -f ${currdir}/pycodedata/.git/ /home/${username}/server.viewtec/
echo "mv -f ${currdir}/pycodedata/.git/ /home/${username}/server.viewtec/"

echo "開始docker服務"
#sudo systemctl restart "${uwsgisrv}"
#sudo docker-compose -f ~/docker/uwsgi/docker-compose.yml up -d
sudo docker-compose -f ~/docker/hsweb/docker-compose.yml up -d
sudo docker-compose -f ~/docker/hsschedule/docker-compose.yml up -d

echo "刪除上傳資料"
echo "刪除資料夾 ${currdir}/pycodedata"
rm -rf "${currdir}/pycodedata"
echo "刪除 ${currdir}/${tarfile}"
rm -rf "${currdir}/${tarfile}"

