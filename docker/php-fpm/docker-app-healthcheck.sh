#!/bin/sh

if [ -z "$APP_SCRIPT_NAME" ]; then
  echo 0
else
  count=`ps -ef | grep "$APP_SCRIPT_NAME" | grep -v grep | grep -v \<defunct\> | wc -l`
  if [ $count -eq 0 ]; then
    cd $APP_SCRIPT_PATH && php $APP_SCRIPT_NAME > /dev/null 2>&1 &
    echo 1
  else
    echo 0
  fi
fi