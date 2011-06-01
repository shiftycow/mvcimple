#!/usr/bin/perl
#
# testing script for the MVCimple::String class
#
#

use strict;
use lib "../lib";
use MVCimple::String;

my $string = new MVCimple::String("test_string",{length=>32});

print $string->to_sql()."\n";
print $string->to_input()."\n";
