#!/bin/bash

ps -ef|grep metal|grep -v grep|awk '{print $2}'|xargs kill
echo 'process killed'

echo 'building...'
go build

echo 'starting...'
nohup ./metal &
echo 'started!'
