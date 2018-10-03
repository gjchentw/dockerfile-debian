#!/bin/sh

S6_DISABLE=${S6_DISABLE:-"crond"}

if [ -n "$1" ]; then
  exec $@
  exit $?
fi


/bin/s6-svscan /etc/s6.d
