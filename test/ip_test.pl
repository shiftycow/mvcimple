#!/usr/bin/perl
#
# testing script for the MVCimple::Number class
#
#

use strict;
use lib "../lib";
use MVCimple::IP;

my $ipnum = new MVCimple::IP("network",{datatype=>'Number'});
print $ipnum->to_sql()."\n";
print $ipnum->to_input()."\n";
print "167772161 is a valid IP\n" if($ipnum->validate(167772161));
print "asf is a valid IP\n" if($ipnum->validate('asf'));
print "167772161 as a ip " . $ipnum->decimal2IP(167772161) . "\n";



my $ipstr = new MVCimple::IP("network",{datatype=>'String'});
print $ipstr->to_sql()."\n";
print $ipstr->to_input()."\n";
print "128.123.3.5 is a valid IP\n" if($ipstr->validate('128.123.3.5'));
print "asf is a valid IP\n" if($ipstr->validate('asf'));
print "128.123.3.5 as an int  " . $ipnum->ip2Decimal('128.123.3.5') . "\n";
