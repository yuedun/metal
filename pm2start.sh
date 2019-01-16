#!/bin/bash

echo 'building...'
go build

pid=`ps -ef|grep metal|grep -v grep|awk '{print $2}'`
if [ -n "$pid" ]; then
    echo "process id is: $pid"
    kill $pid
    echo 'process killed'
else
    echo "metal process id is not found!"
fi

pm2 ls
# pm2 startOrRestart pm2.json
