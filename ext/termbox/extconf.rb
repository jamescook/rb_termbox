require 'mkmf'
$CFLAGS = "-fPIC -O0 -g -std=gnu99 -D_GNU_SOURCE"
create_makefile("libtermbox")
