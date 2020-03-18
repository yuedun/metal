#!/bin/bash

rm metal
echo "上传文件......"
rz
echo "文件执行权限"
chmod u+x metal
echo "重启服务"
pm2 restart metal
# pm2 startOrRestart pm2.json
