FROM openjdk:8-jdk

LABEL maintainer="github/gitlab:jhbez"

#./android/app/build.gradle
ENV ANDROID_COMPILE_SDK "28" 
# ~/Android/Sdk/build-tools/
ENV ANDROID_BUILD_TOOLS "29.0.2" 
# Last number android studio
ENV ANDROID_SDK_TOOLS   "4333796" 

ENV FLUTTER_VERSION  "1.9.1+hotfix.2"

RUN apt-get --quiet update --yes
RUN apt-get --quiet install --yes wget tar unzip lib32stdc++6 lib32z1

RUN  wget --quiet --output-document=android-sdk.zip https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_TOOLS}.zip && \
  unzip -d android-sdk-linux android-sdk.zip && \
  rm -rf android-sdk.zip
RUN  mkdir ~/.android && touch ~/.android/repositories.cfg
RUN echo y | android-sdk-linux/tools/bin/sdkmanager "platforms;android-${ANDROID_COMPILE_SDK}" >/dev/null
RUN echo y | android-sdk-linux/tools/bin/sdkmanager "platform-tools" >/dev/null
RUN echo y | android-sdk-linux/tools/bin/sdkmanager "build-tools;${ANDROID_BUILD_TOOLS}" >/dev/null

ENV ANDROID_HOME $PWD/android-sdk-linux
ENV PATH $PATH:$PWD/android-sdk-linux/platform-tools/

#temporarily disable checking for EPIPE error and use yes to accept all licenses
#RUN set +o pipefail
RUN yes | android-sdk-linux/tools/bin/sdkmanager --licenses
#RUN set -o pipefail

# flutter sdk setup  
RUN wget --output-document=flutter-sdk.tar.xz "https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_v${FLUTTER_VERSION}-stable.tar.xz" && \
  tar xf flutter-sdk.tar.xz && \
  rm -rf flutter-sdk.tar.xz
ENV PATH $PATH:$PWD/flutter/bin:$PWD/flutter/bin/cache/dart-sdk

#RUN touch android/local.properties
#RUN echo flutter.sdk=$PWD/flutter > android/local.properties 
RUN yes | flutter doctor --android-licenses
RUN flutter doctor

