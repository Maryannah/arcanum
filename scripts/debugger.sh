#!/bin/bash

color() {
  echo -ne "\e[${1}m${2}\e[0m"
}

tmp="/tmp"
game="game.apk"
dist="debuggable.apk"
static="/static/apks"

tgame="$tmp/$game"
sgame="$static/$game"
dgame="$static/$dist"

apktool="/sdk/apktool.jar"
btools="/sdk/cmdline-tools/build-tools/32.0.0"
store="/sdk/store.jks"

decoded="$tmp/decoded"
encoded="$tmp/encoded.apk"
aligned="$tmp/aligned.apk"
signed="$tmp/signed.apk"

rm -rf /tmp/* $dgame
cp $sgame $tgame

echo ""

color 34 "Decoding APK ...          "
java -jar $apktool d $tgame -o $decoded > /dev/null || { color 31 "Error occured : \n"; exit 1; }
color 32 "Done ! \n"
color 34 "Building back APK ...     "
java -jar $apktool b $decoded -o $encoded -d > /dev/null || { color 31 "Error occured : \n"; exit 1; }
color 32 "Done ! \n"
color 34 "Aligning APK ...          "
"$btools/zipalign" -p -f -v 4 $encoded $aligned > /dev/null || { color 31 "Error occured : \n"; exit 1; }
color 32 "Done ! \n"
color 34 "Signing APK ...           "
"$btools/apksigner" sign --out $signed --ks $store --ks-pass pass:azertyuiop $aligned > /dev/null || { color 31 "Error occured : \n"; exit 1; }
color 32 "Done ! \n"

cp $signed $dgame
color 32 "\nAPK set for debug mode, check your static folder !\n\n"

rm -rf $tmp/*