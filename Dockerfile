ARG ARCH=amd64
FROM  --platform=${ARCH} debian:stable-slim
ARG ARCH=amd64
LABEL maintainer="kisaragychihaya"
RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list.d/debian.sources 
RUN apt-get update && apt-get -y install aria2 && apt clean
WORKDIR /core
COPY ./src ./
RUN mkdir ./uploads ./db ./log && touch /core/etc/aria2/aria2.session
ADD https://github.com/cloudreve/Cloudreve/releases/download/3.8.3/cloudreve_3.8.3_${ARCH}_amd64.tar.gz /core/
ADD https://github.com/WumaCoder/cloudreve-docker/raw/master/src/aria2/conf/dht.dat /core/etc/aria2/dht.dat
RUN chmod 755 /core/start.sh
VOLUME [ "/core/uploads","/core/db","/core/log" ]
CMD /bin/bash /core/start.sh
EXPOSE 5212

# docker build -t cloudreve .