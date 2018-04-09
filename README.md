# jenkins-npm-agent

This agent builds on the jenkins-agent by adding the ability to execute npm commands within the container. As an added benefit, the jenkins user can install npm items globally without having to run as root.

## Node and NPM install

The latest version of Node 8 (LTS) and npm will be installed when this image is built.

The global prefix for npm is `/.npm-global`. All globally installed npm packages will be placed in to that folder and the user `jenkins` will be able to access it without using sudo.

This image also includes the following packages:

- `build-essential` - Enables the image to install and run NPM packages that require a C compiler.
- `expect` - Enables the image to respond to terminal prompts. Useful for things such as logging into an npm registry for automatic publishing.
- `maven` &amp; `ca-certificates-java` - Enables the image to contact maven central using the proper ssl certificates
