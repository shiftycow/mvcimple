#!/usr/bin/perl
#
# testing script for the MVCimple::Number class
#
#

use Data::Dumper;

use strict;
use lib "../lib";
use MVCimple::IP;

#
# Validation tests for IP address represented as a Number
#
#

my $ipnum = new MVCimple::IP("network",{datatype=>'Number'});
print $ipnum->to_sql()."\n";
print $ipnum->to_input()."\n";

print "Validation tests for IP adress as a Number. \n";
$ipnum->set_value(167772161);
print "Testing '" . $ipnum->get_value() . "'\n";
print $ipnum->get_value() . " is a valid IP\n" if($ipnum->validate()->{'error'} eq undef);

print "Testing decimal2IP: 167772161 as an ip " . $ipnum->decimal2IP(167772161) . "\n";
print "Testing get_as_string: " . $ipnum->get_as_string() . "\n";

print "Validating asdf for ipstr. \n";
$ipnum->set_value('asdf');
print "Testing '" . $ipnum->get_value() . "'\n";
print $ipnum->get_value() . " is a valid IP\n" if($ipnum->validate()->{'error'} eq undef);

print "Validating 192.168.1.1 for ipstr. \n";
$ipnum->set_value('192.168.1.1');
print "Testing '" . $ipnum->get_value() . "'\n";
print $ipnum->get_value() . " is a valid IP\n" if($ipnum->validate()->{'error'} eq undef);



#
# Validation tests for IP address represented as a String
#
#

my $ipstr = new MVCimple::IP("network",{datatype=>'String', null=>1});
print $ipstr->to_sql()."\n";
print $ipstr->to_input()."\n";

print "Validation tests for IP adress as a String. \n";
$ipstr->set_value('128.123.3.5');
print $ipstr->get_value() . " is a valid IP\n" if($ipstr->validate()->{'error'} eq undef);
print "Testing ip2Decimal: " . $ipstr->get_value() . " as an int  " . $ipnum->ip2Decimal('128.123.3.5') . "\n";
print "Testing get_as_number: " . $ipstr->get_as_number() . "\n";

$ipstr->set_value('asf');
print "Testing '" . $ipstr->get_value() . "'\n";
print $ipstr->get_value() . " is a valid IP\n" if($ipstr->validate()->{'error'} eq undef);

$ipstr->set_value(167772161);
print "Testing '" . $ipstr->get_value() . "'\n";
print $ipstr->get_value() . " is a valid IP\n" if($ipstr->validate()->{'error'} eq undef);


##
# Test parent validate methods
##
print "\nTesting parent class validate for ipstr. \n";

$ipstr->set_value();
print "Testing '" . $ipstr->get_value() . "'\n";
print $ipstr->get_value() . " is a valid IP\n" if($ipnum->validate()->{'error'} eq undef);

print "\nTesting parent class validate for ipnum. \n";
$ipnum->set_value();
print "Testing '" . $ipnum->get_value() . "'\n";
print $ipnum->get_value() . " is a valid IP\n" if($ipnum->validate()->{'error'} eq undef);


