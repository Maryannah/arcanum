#!/bin/bash

color() {
  echo -ne "\e[${1}m${2}\e[0m"
}

url="https://proxyconnection.touch.dofus.com/build/script.js"
dest="./static/script.js"

rm -rf $dest

echo ""
wget $url -O $dest
npx js-beautify $dest -o $dest

color 34 "Fetched & formatted script.js file, find it in static folder \n\n"
