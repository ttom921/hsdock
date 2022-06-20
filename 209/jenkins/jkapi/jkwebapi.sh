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
websrv="hs06web"
tasksrv="celery"
codepath="server06"
username="hisharp"

echo "tarfile=${tarfile}"

echo "目前路徑"
currdir="/home/${username}/jenkins/jkapi"
cd ${currdir}
#pwd
#ls
echo "解壓----${tarfile}"
tar -zxvf ${tarfile}

echo "停止docker服務"


#sudo docker-compose -f ~/docker/uwsgi/docker-compose.yml down
sudo docker-compose -f /home/${username}/docker/${websrv}/docker-compose.yml down
sudo docker-compose -f /home/${username}/docker/${tasksrv}/docker-compose.yml down

echo "刪除 python code"
sudo rm -rf /home/${username}/${codepath}/*
echo  "刪除 /home/${username}/${codepath}/*"

sudo rm -rf /home/${username}/${codepath}/.git
echo  "刪除 .git /home/${username}/${codepath}/.git"

echo "覆蓋 python code"
mv -f       ${currdir}/pycodedata/code/ /home/${username}/${codepath}/
echo "mv -f ${currdir}/pycodedata/code/ /home/${username}/${codepath}/"
mv -f ${currdir}/pycodedata/.git/ /home/${username}/${codepath}/
echo "mv -f ${currdir}/pycodedata/.git/ /home/${username}/${codepath}/"

echo "開始docker服務"
#sudo systemctl restart "${uwsgisrv}"
#sudo docker-compose -f ~/docker/uwsgi/docker-compose.yml up -d
sudo docker-compose -f /home/${username}/docker/${websrv}/docker-compose.yml up -d
sudo docker-compose -f /home/${username}/docker/${tasksrv}/docker-compose.yml up -d

echo "刪除上傳資料"
echo "刪除資料夾 ${currdir}/pycodedata"
rm -rf "${currdir}/pycodedata"
echo "刪除 ${currdir}/${tarfile}"
rm -rf    "${currdir}/${tarfile}"

