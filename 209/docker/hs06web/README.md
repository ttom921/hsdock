## Docker重啟機制

### 定時檢查是否需要重新啟動Docker

由於異常時會寫檔案到`/tmp/restart_docker`，所以需要執行以下指令

```
sudo chmod 777 /tmp/restart_docker
```

啟動定期檢查機制

```bash
vim /etc/crontab
```

內容為：

```
*/5 *   * * *   root    sh /home/hisharp/docker/hs06web/check_restart_docker.sh >> /tmp/restart_docker.log 2>&1 &
```

