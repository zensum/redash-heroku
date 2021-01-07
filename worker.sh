#!/bin/bash
exec /app/bin/docker-entrypoint worker &
exec /app/bin/docker-entrypoint scheduler &

while sleep 60; do
  ps aux |grep '/app/bin/docker-entrypoint worker' |grep -q -v grep
  PROCESS_1_STATUS=$?
  ps aux |grep '/app/bin/docker-entrypoint scheduler' |grep -q -v grep
  PROCESS_2_STATUS=$?
  if [ $PROCESS_1_STATUS -ne 0 -o $PROCESS_2_STATUS -ne 0 ]; then
    exit 1
  fi
done