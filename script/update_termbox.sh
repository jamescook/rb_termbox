#! /usr/bin/env bash

TERMBOX_GIT=https://github.com/nsf/termbox.git
rm -rf /tmp/termbox
git clone $TERMBOX_GIT /tmp/termbox
cp /tmp/termbox/src/*.h /tmp/termbox/src/*.c ./ext/tim/


