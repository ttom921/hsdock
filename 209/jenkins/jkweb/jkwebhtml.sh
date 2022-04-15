#!/bin/bash
# 將上傳的web檔案更新到指定的位置
#
# 2020-05-17
#
#
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH


prjname=$1
tarfile=$2

# 看nginx的html的資料夾
nginxhtml="htfmsclient06"
username="hisharp"
dockerpathname="hs06web"

echo "prjname=${prjname}"
echo "tarfile=${tarfile}"

delhtmldata(){
   #echo "/usr/share/nginx/*.js"
   sudo rm -rf /usr/share/nginx/${nginxhtml}/*.js.map
   sudo rm -rf /usr/share/nginx/${nginxhtml}/*.js
   sudo rm -rf /usr/share/nginx/${nginxhtml}/*.css
   sudo rm -rf /usr/share/nginx/${nginxhtml}/*.ttf
   sudo rm -rf /usr/share/nginx/${nginxhtml}/*.html
   sudo rm -rf /usr/share/nginx/${nginxhtml}/*.eot
   sudo rm -rf /usr/share/nginx/${nginxhtml}/*.woff
   sudo rm -rf /usr/share/nginx/${nginxhtml}/*.woff2
   sudo rm -rf /usr/share/nginx/${nginxhtml}/*.svg
   sudo rm -rf /usr/share/nginx/${nginxhtml}/*.ico
   sudo rm -rf /usr/share/nginx/${nginxhtml}/*.png
}



echo "目前路徑"
currdir="/home/${username}/jenkins/jkweb"
cd ${currdir}

echo "解壓----${tarfile}"
tar zxvf ${tarfile}

echo "停止----web client docker --服務"
#sudo docker-compose -f ~/docker/uwsgi/docker-compose.yml down
sudo docker-compose -f ~/docker/${dockerpathname}/docker-compose.yml down

echo "刪除 nginx下的html"
delhtmldata
echo "刪除 /usr/shsre/nginx/${nginxhtml}/*.*"

echo "複制html到nginx"
sudo cp -Rf /home/${username}/jenkins/jkweb/${prjname}/* /usr/share/nginx/${nginxhtml}/
echo "複制  /home/${username}/jenkins/jkweb/${prjname}/* /usr/share/nginx/${nginxhtml}/ "

echo "開始----web client docker --服務"
#sudo docker-compose -f ~/docker/uwsgi/docker-compose.yml up -d
sudo docker-compose -f ~/docker/${dockerpathname}/docker-compose.yml up -d

echo "刪除上傳資料"
echo "刪除資料夾 /home/${username}/jenkins/jkweb/${prjname}/"
rm -rf          "/home/${username}/jenkins/jkweb/${prjname}/"
echo "刪除 /home/${username}/jenkins/jkweb/${tarfile}"
rm -rf    "/home/${username}/jenkins/jkweb/${tarfile}"
                                                   




