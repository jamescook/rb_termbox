#! /usr/bin/env bash

ruby ./ext/termbox/extconf.rb
cd ./ext/termbox && make
