#!/bin/bash

kubectl set image -n test deployment/metal metal=metal:$1

# kubectl rollout restart -n test deployment/metal