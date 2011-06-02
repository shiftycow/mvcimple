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

$ipnum->set_value(167772161);
print $ipnum->get_value() . " is a valid IP\n" if($ipnum->validate());
print "Testing decimal2IP: 167772161 as an ip " . $ipnum->decimal2IP(167772161) . "\n";
print "Testing get_as_string: " . $ipnum->get_as_string() . "\n";

$ipnum->set_value('asdf');
print $ipnum->get_value() . " is a valid IP\n" if($ipnum->validate());

$ipnum->set_value('192.168.1.1');
print $ipnum->get_value() . " is a valid IP\n" if($ipnum->validate());





my $ipstr = new MVCimple::IP("network",{datatype=>'String'});
print $ipstr->to_sql()."\n";
print $ipstr->to_input()."\n";

$ipstr->set_value('128.123.3.5');
print $ipstr->get_value() . " is a valid IP\n" if($ipstr->validate());
print "Testing ip2Decimal: " . $ipstr->get_value() . " as an int  " . $ipnum->ip2Decimal('128.123.3.5') . "\n";
print "Testing get_as_number: " . $ipstr->get_as_number() . "\n";

$ipstr->set_value('asf');
print $ipstr->get_value() . " is a valid IP\n" if($ipstr->validate());

$ipstr->set_value(167772161);
print $ipstr->get_value() . " is a valid IP\n" if($ipstr->validate());


