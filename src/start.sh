#!/bin/bash
if [ ! -f "/core/etc/conf.ini" ];then
	echo "fnf"
	echo "[System]" > /core/etc/conf.ini
	echo "Mode = master" >> /core/etc/conf.ini
	echo "Listen = :5212" >> /core/etc/conf.ini
	echo "Debug = false" >> /core/etc/conf.ini
	echo "[Database]" >> /core/etc/conf.ini
	echo "DBFile = /core/db/cloudreve.db" >> /core/etc/conf.ini
fi
rand_sec=$(cat /dev/urandom | head -n 10 | md5sum | cut -c 1-16)
sed -i 's/Your_CR_SEC/'${rand_sec}'/g' /core/etc/conf.ini
rand_sec=$(cat /dev/urandom | head -n 10 | md5sum | cut -c 1-16)
sed -i 's/Sth_Deep_Sth_Dark_Out_of_Fantasty/'${rand_sec}'/g' /core/etc/conf.ini
/bin/chmod +x /core/cloudreve
aria2c --conf /core/etc/aria2/conf.ini -D
/core/cloudreve -c /core/etc/conf.ini > /core/log/cloudreve.log
