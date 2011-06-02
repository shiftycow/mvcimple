#!/usr/bin/perl
#
# testing script for the MVCimple::Number class
#
#

use strict;
use lib "../lib";
use MVCimple::Number;

my $number = new MVCimple::Number("mynum",{'length'=>9,'precision'=>16,'scale'=>4});

print $number->to_sql()."\n";
print $number->to_input()."\n";

$number->set_value('asdf');
print "asfd is a valid number\n" if($number->validate());
$number->set_value(5.5);
print "5.5 is a valid number\n" if($number->validate());
