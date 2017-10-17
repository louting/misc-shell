#!/bin/bash
#date=20160307
#version=0.4
#inotifywait de jiandan shiyong

Usage() {
	echo "   Usage:./inotify.sh  stop
	./inotify.sh  file1 file2  ... "
}

if [ $# == 0 ];then
	Usage
	exit 1
fi

monitor() {
	/usr/bin/inotifywait -mrq --timefmt '%d/%m/%y %H:%M' --format  '%T %w%f %e' --event modify,delete,create,attrib  $1 | while read  date time file event
do
	case $event in
	MODIFY|CREATE|MOVE|MODIFY,ISDIR|CREATE,ISDIR|MODIFY,ISDIR)
	echo "`date`   $event'-'$file" >>/tmp/inotify_monitor.log
;;

MOVED_FROM|MOVED_FROM,ISDIR|DELETE|DELETE,ISDIR)
echo "`date`   $event'-'$file" >>/tmp/inotify_monitor.log
;;

esac
done
}

for i in ${@}
do
if [ $i == stop ];then
echo "The monitor has been stop !"
ps -ef |grep [i]notify |grep -v grep|awk '{print $2}'|xargs kill 2>/dev/null
else
monitor $i &
echo "starting monitor $i !"
fi
don

