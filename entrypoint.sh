#!/bin/bash

exec="/usr/bin/gunicorn"

# if empty, display help
if [[ $# -eq 0 ]]; then
  $exec -h
  exit 0
fi

# parse for options
while [ "$1" != "" ]; do
  case $1 in
    -s|--shell)
      #create-module-links
      echo "Starting interactive shell..."
      bash
      exit $?
      ;;
    *)
      #create-module-links
      exec $exec $@
      ;;
  esac
  shift
done