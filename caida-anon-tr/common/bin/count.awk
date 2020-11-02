#!/usr/bin/env awk -f
# -*- mode: awk; coding: utf-8; fill-column: 80; -*-
#
# Count the total number of lines in the input stream, and print the value.
#

{ n++ }

END { 
    print n
}
