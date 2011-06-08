#!/usr/bin/perl
#
# testing script for the MVCimple::String class
#
#

use strict;
use lib "../lib";
use MVCimple::String;

my $string = new MVCimple::String("test_string",{'length'=>30, 'null'=>0});

print $string->to_sql()."\n";
print $string->to_input()."\n";

$string->set_value('trololol');

print $string->get_value() . " is a valid string.\n" if($string->validate());

$string->set_value();
print $string->get_value() . " is a valid string.\n" if($string->validate());
