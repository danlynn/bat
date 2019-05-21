FROM alpine:3.9

MAINTAINER Dan Lynn <docker@danlynn.org>

WORKDIR /myapp

ARG BAT_VERSION="0.11.0"

RUN apk add --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing --no-cache \
      # required for window size detection
      bash \
      # `bat`s default pager
      less \
      bat="${BAT_VERSION}-r0" && \

    # configure bash to check the window size after each command
    echo "shopt -s checkwinsize" >> ~/.bashrc

# execute `bat` after a pause so that tty can detect the current window size
ENTRYPOINT [ "bash", "-c", "sleep 0.1; bat $0 $@" ]
