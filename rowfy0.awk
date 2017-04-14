#!/usr/bin/awk -f
#
# This is a bit like the paste command, but functions automatically on empty lines, so that contiguous lines all sit together in the same rown
#
# awk '{if(/^$/) printf "\n"; else printf "%s ",$0}END{printf "\n"}'
{
    if(/^$/) # we hit an empty line
        printf "\n";
    else
        printf "%s\t",$0
}

END {
    printf "\n"
}
