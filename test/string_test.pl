#!/usr/bin/perl
#
# testing script for the MVCimple::String class
#
#

use strict;
use lib "../lib";
use MVCimple::String;

my $string = new MVCimple::String("34","test_string");

print $string->to_sql()."\n";
print $string->to_input()."\n";
