#!/bin/sh

IMAGE_NAME='jenkins-npm-agent'

CONTAINER_NAME=$IMAGE_NAME'-container'

CONTAINER=$(docker ps -a | grep $CONTAINER_NAME) 

if [ -n "$CONTAINER" ] ; then
   echo $CONTAINER
   docker stop $CONTAINER_NAME
   docker rm $CONTAINER_NAME
fi

if [ "$1" = "bash" ] ; then 
   echo "running in bash mode"
   docker run --name $CONTAINER_NAME -it -p 4873:4873 --user jenkins $IMAGE_NAME bash
elif [ "$1" = "clean" ] ; then 
   echo "clean up container"
else
   echo "running in daemon mode"
   docker run --name $CONTAINER_NAME -d -p 4873:4873 $IMAGE_NAME
fi 
