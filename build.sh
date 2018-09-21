#!/bin/sh

NAME=$1

# Test if input is empty
if [ -z $NAME ] ; then 
   NAME='jenkins-nvm-agent'
fi

# Trigger docker build command with image name
# docker build --no-cache -t $NAME .
docker build -t $NAME .
