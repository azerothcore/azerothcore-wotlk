#!/bin/bash
cd "$(dirname "$0")"

if [ -z "$RECAPTCHA_SECRET" ]; then
  echo "Need RECAPTCHA_SECRET env variable"
  exit -1
fi

rm ./server/build -rf
cd website 
npm run build
mv build ../server/build
cd ..
PORT=5000 node ./server/server 