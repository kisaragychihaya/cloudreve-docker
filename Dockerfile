FROM  --platform=arm64 debian:stable-slim
LABEL maintainer="kisaragychihaya"
WORKDIR /core
COPY ./src ./
RUN mkdir ./uploads ./db ./log && touch /core/etc/aria2/aria2.session 
RUN apt-get -y install aria2
ADD cloudreve_3.8.3_linux_arm64.tar.gz /core/
ADD https://raw.githubusercontent.com/kisaragychihaya/cloudreve-docker/master/src/aria2/conf/dht.dat /core/etc/aria2/dht.dat
CMD /bin/bash /core/start.sh
EXPOSE 5212

# docker build -t cloudreve .