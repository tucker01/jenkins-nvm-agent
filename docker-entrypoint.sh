#!/bin/bash

#########################################################
# Setup ENTRYPOINT script when running the image:       #
# - Installs the desired version of node js for root    #
# - Installs the desired version of node js for jenkins #
#########################################################

# Exit if any commands fail
set -e

# Extract the command line arguments
while test $# -gt 0; do
    case "$1" in
        --node-version)
            shift
            VERSION=$1
            shift
            ;;
        --exec)
            shift
            EXEC_ME=$1
            shift
            ;;
        *)
            echo "$1 is not a recognized flag!"
            return 1;
            ;;
    esac
done  

# If no version was supplied, then set to the default from the environment variable in the docker image
if [ -z $VERSION ]; then
   echo "No Node.js version supplied via param! Defaulting to $NODE_JS_DEFAULT_VERSION as set in environment variable."
   VERSION=$NODE_JS_DEFAULT_VERSION
else 

   # If the version was supplied, but exec was NOT - then default to ssh
   if [ -z $EXEC_ME ]; then 
      EXEC_ME="/usr/sbin/sshd -D"
   fi 
fi

# Execute the node installation script
echo "Installing Node.js version $VERSION for current user..."
install_node.sh $VERSION

# Execute the script for user jenkins
echo "Installing Node.js version $VERSION for jenkins user..."
su -c "install_node.sh $VERSION" - jenkins 

# The default is to exec ssh
if [[ ! -z $EXEC_ME ]]; then
    exec $EXEC_ME
fi

exit 0
