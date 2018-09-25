# jenkins-nvm-agent

This agent builds on the [jenkins-agent](https://github.com/AHumanFromCA/jenkins-agent) by adding the ability to start the container with any nvm available Node.js version. Nvm is available to user root and jenknis. 

The jenkins user can install npm items globally without having to run as root. 

## Usage 

`docker run jenkins-nvm-agent` will start the container with the default Node.js version (v10.11.0).

To switch, set `NODE_JS_NVM_VERSION` environment variable to the desired version on the `docker run` command:
```
docker run -e "NODE_JS_NVM_VERSION=8.12.0" jenkins-nvm-agent
```

Any arguments that appear after the image name will be passed to `exec "$@"` in the `docker-entrypoint.sh` script.

## Node and NVM install

[Nvm](https://github.com/creationix/nvm) is used to manage local versions of Node.js for user root and user jenkins. 

When the container starts, the value set by `NODE_JS_NVM_VERSION` environment variable is passed to nvm. The default specified within the image (globally and nvm) is the Node.js "current" (currently at v10.11.0).

This image also includes the following packages:

- `build-essential` - Enables the image to install and run NPM packages that require a C compiler.
- `expect` - Enables the image to respond to terminal prompts. Useful for things such as logging into an npm registry for automatic publishing.
- `maven` &amp; `ca-certificates-java` - Enables the image to contact maven central using the proper ssl certificates
