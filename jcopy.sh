#!/bin/bash

if [ -d /usr/local/MyApp/WEB-INF ]; then
	cp -ir WEB-INF /usr/local/MyApp
else
	cp -ir WEB-INF /usr/local/MyApp/WEB-INF
	echo "Created WEB-INF."
fi

exit 0
