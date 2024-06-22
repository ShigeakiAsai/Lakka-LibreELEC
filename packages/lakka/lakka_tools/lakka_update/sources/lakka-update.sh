#!/bin/bash

MIRROR=@LAKKA_UPDATE_SERVER_URL@/@LAKKA_TARGET_DEVICE_ARCH@

FILE=`wget $MIRROR/.index -q -O - | head -1`

if [ -z "$FILE" ]; then
	echo "Could not find latest update."
	exit 1
fi

URL=$MIRROR/$FILE

# cleanup before downloading
rm -rf ~/.update/*

echo ":: Downloading updade"
wget -P ~/.update/ $URL

if [ ! -f ~/.update/$FILE ]; then
	echo "Something went wrong during the download."
	exit 1
fi

echo ":: Done, you can now reboot"
