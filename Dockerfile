FROM ubuntu:16.04

MAINTAINER Dan Lynn <docker@danlynn.org>

WORKDIR /myapp

RUN \
    apt-get update &&\
    apt-get install -y curl less git

RUN \
    curl -L https://github.com/sharkdp/bat/releases/download/v0.10.0/bat-v0.10.0-x86_64-unknown-linux-gnu.tar.gz | tar -C /usr/local/src -zxf - &&\
    ln -s /usr/local/src/bat-v0.10.0-x86_64-unknown-linux-gnu/bat /usr/local/bin/bat

# configure bash to check window size after each command
RUN \
    echo "shopt -s checkwinsize" >> ~/.bashrc

# execute `bat` after a slight pause in order to give
# the tty time to realize the current window size
ENTRYPOINT [ "bash", "-c", "sleep 0.1; bat $0 $@" ]
