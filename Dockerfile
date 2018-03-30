# This docker file will build on the jenkins-agent to provide access to npm utilities
FROM wrich04ca/jenkins-agent

# Install minimum required software
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" >> /etc/apt/sources.list
RUN apt-get update

RUN apt-get -y install git
RUN apt-get -y install curl

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

# Install curl, maven,
RUN apt-get update && apt-get install -y \
curl \
git \
openjdk-8-jdk \
sshpass \
&& rm -rf /var/lib/apt/lists/*

# Add node version 8 which should bring in npm, add maven and build essentials and required ssl certificates to contact maven central
# expect is also installed so that you can use that to login to your npm registry if you need to
RUN curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
RUN apt-get install -y nodejs expect build-essential maven ca-certificates-java && update-ca-certificates -f

# Make the global npm install directory and update the environmental variables
RUN mkdir /.npm-global
ENV NPM_CONFIG_PREFIX=/.npm-global
ENV PATH=/.npm-global/bin:$PATH

# Grab the latest version of npm and put it in the new space
RUN npm install npm --global

# Adjust permissions so that the jenkins user can execute global npm commands
RUN groupadd npmusers \
  && usermod -aG npmusers jenkins \
  && chown root:npmusers /.npm-global -R \
  && chmod g+rwx /.npm-global -R

CMD ["/usr/sbin/sshd", "-D"]
