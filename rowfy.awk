#!/usr/bin/awk -f
# This is a bit like the paste command, but functions automatically on empty lines, so that contiguous lines all sit together in the same row
# The "0" version of this script worked but added tabs at the end of each line.
# This vrsion uses a constantly evolving string, S, which allows for a more elegant output.
# Tt's highly probable however that this version is less scalable.
BEGIN {
    START=1 # our marker for start of line
}
{
    if(/^$/) { # we hit an empty line
        printf "%s\n",S; # finally print out the string
        START=1;
    } else if (START) {
        S=sprintf("%s",$0);
        START=0;
    } else
        S=sprintf("%s\t%s",S,$0) # concatentate to the string
}
