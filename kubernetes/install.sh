#!/bin/bash

# ./install -e miaohua-test

# 环境=命名空间
# 注意：.env配置文件后缀名与所处空间名一致，比如： .env.miaohua-staging , .env.miaohua-test, .env.miaohua-production
ns="miaohua-test"

while getopts "e:" opt; do 
  case $opt in
    e)
      env=$OPTARG
      ;;
    ?) 
      echo "Invalid option: -$OPTARG index:$OPTIND"
      exit 1
      ;;
  esac
done


kubectl create configmap metal-config --from-file ./conf.toml -n ${ns}
kubectl create -f deployment.yaml -n ${ns}
kubectl create -f service.yaml -n ${ns}
