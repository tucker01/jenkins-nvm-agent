#!/bin/bash

#########################################################
# Setup ENTRYPOINT script when running the image:       #
# - Installs the desired version of node js for root    #
# - Installs the desired version of node js for jenkins #
#########################################################

# Exit if any commands fail
set -e

# Extract Node.js version from env var
VERSION=$NODE_JS_NVM_VERSION

# Execute the node installation script
echo "Installing Node.js version $VERSION for current user..."
install_node.sh $VERSION

# Execute the script for user jenkins
echo "Installing Node.js version $VERSION for jenkins user..."
su -c "install_node.sh $VERSION" - jenkins 

# Execute passed cmd
exec "$@"
