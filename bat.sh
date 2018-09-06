#!/usr/bin/env bash

docker run --rm -it -e BAT_THEME -v "$(pwd):/myapp" danlynn/bat:0.6.1 $@
