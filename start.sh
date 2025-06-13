#!/bin/bash

if [ "$(whoami)" != "root" ] ; then
  echo This script must be executed as root
  exit 1
fi

cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null

if [ ! -f config.sh ] ; then
  echo Could not find config.sh - please copy the config.example.sh and adjust the values >&2
  exit 2
fi

. config.sh

if ! which evtest &>/dev/null ; then
  echo Could not find evtest executable - please install it >&2
  exit 4
fi


while true ; do
	# Read raw key events from the RFID reader to get the token ID
	TOKEN_ID=""
	sudo evtest "$RFID_READER_INPUT_DEVICE" | while read line ; do
		if ! [[ $line =~ .*EV_KEY.*value\ 1 ]] ; then
			continue
		fi

		KEY="$(echo "$line" | sed 's/.*(KEY_\(.*\)).*/\1/')"

		if [ "$KEY" = "ENTER" ] ; then
			./actions.sh $TOKEN_ID
			TOKEN_ID=""
		else
			TOKEN_ID="$TOKEN_ID$KEY"
		fi
	done
done
