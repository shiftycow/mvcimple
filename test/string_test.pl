#!/usr/bin/perl
#
# testing script for the MVCimple::String class
#
#

use strict;
use lib "../lib";
use MVCimple::String;

my $string = new MVCimple::String("test_string",{'length'=>30});

print $string->to_sql()."\n";
print $string->to_input()."\n";

$string->set_value('This is a string');

print" 'This is a string' is a valid string.\n" if($string->validate());
