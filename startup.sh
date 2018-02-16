#!/bin/bash
#
# Description:
#   - this script is used to configure and start a symphony application within a docker container
#   - run this script at container launch/start time
#
# Usage:
#   startup.sh [CMD]
#
#
# Command Line Args

# Misc
OUT_DIR='/tmp/hello-world'
SCONFIG='/opt/symphony/bin/sconfig'
APP_BASE_DIR='/opt/symphony/hello-world'
HOSTNAME=$(hostname)

function usage() {
  echo "$0 <CMD>"
  echo
  echo "Required Command:"
  echo
  echo "  run        - starts application"
  echo
}

function init() {
  echo "initializing environment..."
  mkdir -p $OUT_DIR
}

function clean_out() {
  echo "cleaning up outdir..."
  rm -rf $OUT_DIR
}

function start() {
  echo "starting services..."

  ### Propagate SIGTERM from .sh to child java process
  trap 'kill -TERM $PID' TERM INT

  java $SYM_ES_JAVAARGS -Dfile.encoding="UTF-8" -jar $APP_BASE_DIR/hello-world.jar &

  PID=$!
  wait $PID
  trap - TERM INT
  wait $PID
}

function main() {
  init
  CMD="$(echo $1 | tr '[:upper:]' '[:lower:]')"
  if [ "$CMD" == 'run' ]
  then
    # DEBUG: only clean up the output dir if DEBUG var is not set, otherwise leave it for inspection
    if [ -z "$DEBUG" ]
    then
      clean_out
    fi
    start
  else
    usage
  fi
}

echo
echo "Symphony PresentationML Live Renderer Tool Application Instance"
echo "------------------------------------"
echo
echo "starting..."
if [ $# -le 0 ]
then
  usage
else
  main $*
  # DEBUG: if DEBUG var is set, and if tomcat died, don't let container exit so we can debug what happened
  if [ -n "$DEBUG" ]
  then
    sleep 6000
  fi
fi
echo
echo "stopping..."