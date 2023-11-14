#!/bin/bash

GOOS=linux GOARCH=amd64 go build 

# LstCommitId=`git rev-list -1 HEAD 2> /dev/null || echo 1`
# if [ ! -n "$1" ] ;then
#     echo "编译当前系统可执行文件……"
#     CGO_ENABLED=0 go build -ldflags "-X main.CommitId=${LstCommitId}" ..
# else
#     echo "编译Linux可执行文件……"
#     CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags "-X main.CommitId=${LstCommitId}" ..
# fi