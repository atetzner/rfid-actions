#!/bin/bash

#
# This script will be called with the RFID token id as parameter once a token has been presented to the reader
#

case $1 in
  0003013694)
    echo Starting music player
    ;;

  *)
    echo Unknown token $1
    ;;
esac
