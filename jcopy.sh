#!/bin/bash

if [ -d WEB-INF ]; then
	echo "コピー開始"
else
	echo "WEB-INFフォルダがカレントディレクトリにないよ"
	echo "Copy Failed."
	exit -1
fi

if [ -d /usr/local/MyApp/WEB-INF ]; then
	cp -ir WEB-INF /usr/local/MyApp
else
	cp -ir WEB-INF /usr/local/MyApp/WEB-INF
	echo "Created WEB-INF."
fi

exit 0
