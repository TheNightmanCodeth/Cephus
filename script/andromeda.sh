#!/bin/bash

## This should print in a dialog if the switch is enabled
echo "Andromeda start shell script by the_nightman"
echo "Forked from the [projekt.] development team"
echo "and adapted for on-device use."

echo "Getting andromeda package location..."
pkg=$(pm path projekt.andromeda)
echo $pkg

# Scrape first 10 characters
pkg=$(echo $pkg | cut -d : -f 2 | sed s/\\r//g)

# Kill running Andromeda services
kill=$(pidof andromeda)

if [ "$kill" == "" ]; then
	am force-stop projekt.substratum
	appops set projekt.andromeda RUN_IN_BACKGROUND allow
	appops set projekt.substratum RUN_IN_BACKGROUND allow
	CLASSPATH=$pkg app_process /system/bin --nice-name=andromeda projekt.andromeda.Andromeda &
	echo "Andromeda is enabled"
else
	am force-stop prjekt.substratum
	kill -9 $kill
	appops set projekt.andromeda RUN_IN_BACKGROUND allow
	appops set projekt.substratum RUN_IN_BACKGROUND allow
	CLASSPATH=$pkg app_process /system/bin --nice-name=andromeda projekt.andromeda.Andromeda &
	echo "Andromeda is enabled"
fi
