FROM m0kimura/ubuntu-base

ARG user=${user:-docker}

RUN apt-get update \


##  ORACLE JAVA8
&&  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections \
&&  add-apt-repository -y ppa:webupd8team/java \
&&  apt-get update \
&&  apt-get install -y oracle-java8-installer \
&&  rm -rf /var/cache/oracle-jdk8-installer \
&&  export JAVA_HOME=/usr/lib/jvm/java-8-oracle \



##  CORDOVA
&&  apt-get install -y sudo ant lib32stdc++6 lib32z1 \
&&  npm install -g cordova \
&&  cd /usr/local \
&&  wget http://dl.google.com/android/android-sdk_r24.4.1-linux.tgz \
&&  tar zxvf android-sdk_r24.4.1-linux.tgz \
&&  export ANDROID_HOME=/usr/local/android-sdk-linux \
&&  export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools \
&&  echo y | android update sdk --no-ui --all --filter "android-25,build-tools-25.0.1" \
&&  echo y | android update sdk --no-ui --all --filter "platform-tool" \
&&  echo y | android update sdk --no-ui --all --filter "extra-google-m2repository,extra-android-m2repository" \
&&  rm -rf /usr/local/android-sdk_r24.4.1-linux.tgz \
&&  add-apt-repository ppa:cwchien/gradle \
&&  apt-get update \
&&  apt-get install -y gradle \
&&  export PATH=$PATH:/opt/gradle/gradle-4.0.1/bin \



## VSCODE
&&  apt-get install -y libgtk2.0-0 libgconf2-4 \
      libnss3 libasound2 libxtst6 libcanberra-gtk-module libgl1-mesa-glx libnotify4 libxkbfile1 libxss1 \
&&  cd /root \
&&  wget https://packages.microsoft.com/repos/vscode/pool/main/c/code/code_1.12.2-1494422229_amd64.deb \
&&  dpkg -i code_1.12.2-1494422229_amd64.deb \
&&  rm code_1.12.2-1494422229_amd64.deb \
##

&&  apt-get install -y imagemagick \
&&  apt-get clean \
&&  rm -rf /var/lib/apt/lists/*


##  USER
ENV HOME=/home/${user} USER=${user}
WORKDIR $HOME
USER $USER
##

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
ENV ANDROID_HOME /usr/local/android-sdk-linux
ENV PATH $PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
ENV PATH $PATH:/opt/gradle/gradle-4.0.1/bin

COPY ./starter.sh /usr/bin/starter.sh
CMD starter.sh

