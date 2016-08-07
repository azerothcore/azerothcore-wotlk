#!/bin/bash

git config --global credential.helper store

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd  $DIR

cd /home/hw2/usr/workspace/projects/AzerothShard/server-live
git pull
cd  $DIR
rm old.log
mv new.log old.log
cd /home/hw2/usr/workspace/projects/AzerothShard/server-live
git log origin/master --no-merges --pretty=format:'<%an> %s' > $DIR/new.log
cd  $DIR
awk '!/DEV-OP/' new.log > temp && mv temp new.log
comm -13 <(sort -u old.log) <(sort -u new.log) > shout.log

while read p; do
  echo "announcing $p\n"
  screen -X -S worldserver-live -p 0 stuff "announce DEV: $p ^M" 
  sleep 1
done <shout.log
