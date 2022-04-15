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
echo "---------web2-----------${tarfile}"
