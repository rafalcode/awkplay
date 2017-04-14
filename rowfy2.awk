#!/usr/bin/awk -f
# This is a bit like the paste command, but functions automatically on empty lines, so that contiguous lines all sit together in the same rown
# The uncommented version of this
BEGIN {
    START=1
}
{
    if(/^$/) { # we hit an empty line
        printf "%s\n",S;
        START=1;
    } else if (START) {
        S=sprintf("%s",$0);
        START=0;
    } else
        S=sprintf("%s\t%s",S,$0)
}
