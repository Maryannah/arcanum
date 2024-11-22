FROM ubuntu:20.04

WORKDIR /tmp
RUN mkdir /sdk

RUN apt update -y 
RUN apt install -y default-jdk unzip zip wget

RUN wget https://dl.google.com/android/repository/commandlinetools-linux-8092744_latest.zip -O /tmp/sdktools.zip
RUN unzip -qq /tmp/sdktools.zip -d /sdk

RUN yes | /sdk/cmdline-tools/bin/sdkmanager "platform-tools" "build-tools;32.0.0"  --sdk_root=/sdk/cmdline-tools
RUN wget https://github.com/iBotPeaches/Apktool/releases/download/v2.10.0/apktool_2.10.0.jar -O /sdk/apktool.jar
RUN keytool -genkeypair -v -keystore /sdk/store.jks -alias BNDLTOOL -keyalg RSA -keysize 2048 -validity 10000 -keypass azertyuiop -storepass azertyuiop -dname "CN=Mirage"

RUN rm -rf /tmp/*

WORKDIR /app

CMD ["echo", "No default command setup for this container"]
