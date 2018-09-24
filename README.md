# jenkins-nvm-agent

This agent builds on the [jenkins-agent](https://github.com/AHumanFromCA/jenkins-agent) by adding the ability to start the container with any nvm available Node.js version. Nvm is available to user root and jenknis. 

The jenkins user can install npm items globally without having to run as root. 

## Usage 

`docker run jenkins-nvm-agent` will start the container with the default Node.js version (v10.11.0).

Flag | Type | Desc
--- | --- | ---
`--node-version` | string | The Node.js version you want to be available by default when the container starts for user root and jenkins
`--exec` | string | Command to exec after ENTRYPOINT script runs - defaults to ssh

## Node and NVM install

[Nvm](https://github.com/creationix/nvm) is used to manage local versions of Node.js for user root and user jenkins. 

When the container starts, the `--node-version` parameter is passed to nvm. The default specified within the image (globally and nvm) is the current "current" (v10.11.0).

This image also includes the following packages:

- `build-essential` - Enables the image to install and run NPM packages that require a C compiler.
- `expect` - Enables the image to respond to terminal prompts. Useful for things such as logging into an npm registry for automatic publishing.
- `maven` &amp; `ca-certificates-java` - Enables the image to contact maven central using the proper ssl certificates
