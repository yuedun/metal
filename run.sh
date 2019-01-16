#!/bin/bash

#ps -ef|grep metal|grep -v grep|awk '{print $2}'|xargs kill
pid=`ps -ef|grep metal|grep -v grep|awk '{print $2}'`
if [ -n "$pid" ]; then
    echo "process id is: $pid"
    kill $pid
    echo 'process killed'
else
    echo "metal process id is not found!"
fi

echo 'building...'
go build

echo 'starting...'
nohup ./metal &
echo 'started!'
