#!/bin/bash

read -e -p "ADB executable : " adbpath
read -p "IP address : " ip
read -p "Pairing port : " port
read -p "Pairing code : " code

"$adbpath" connect "$ip"
echo "$code" | "$adbpath" pair "$ip:$port"

echo "Device connected remotely !"
"$adbpath" devices -l
