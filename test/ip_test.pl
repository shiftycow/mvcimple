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

my $ipnum = new MVCimple::IP("network",{datatype=>'Number', null=>1});

print "\n\n#### testing ipnum->to_sql() and ipnum->to_input()";
print "\n" . $ipnum->to_sql()."\n";
print $ipnum->to_input()."\n";

print "\n####Validation tests for IP adress as a Number. \n";
$ipnum->set_value(167772161);
print "\nTesting '" . $ipnum->get_value() . "'\n";
print $ipnum->get_value() . " is a valid IP\n" if($ipnum->validate()->{'error'} eq undef);

$ipnum->set_value('asdf');
print "\nTesting '" . $ipnum->get_value() . "'\n";
print $ipnum->get_value() . " is a valid IP\n" if($ipnum->validate()->{'error'} eq undef);

$ipnum->set_value('192.168.1.1');
print "\nTesting '" . $ipnum->get_value() . "'\n";
print $ipnum->get_value() . " is a valid IP\n" if($ipnum->validate()->{'error'} eq undef);

print "\n#### end.";

#
# Validation tests for IP address represented as a String
#
#

my $ipstr = new MVCimple::IP("network",{datatype=>'String', null=>1});

print "\n\n#### testing ipstr->to_sql() and ipstr->to_input()";
print "\n\n" . $ipstr->to_sql()."\n";
print $ipstr->to_input()."\n";

print "\nTesting ip2Decimal: " . $ipstr->get_value() . " as an int  " . $ipnum->ip2Decimal('128.123.3.5') . "\n";
print "Testing get_as_number: " . $ipstr->get_as_number() . "\n";


$ipstr->set_value('128.123.3.5');
print "\n####Validation tests for IP adress as a String. \n";
print "\nTesting '" . $ipstr->get_value() . "'\n";
print $ipstr->get_value() . " is a valid IP\n" if($ipstr->validate()->{'error'} eq undef);

$ipstr->set_value('asf');
print "\nTesting '" . $ipstr->get_value() . "'\n";
print $ipstr->get_value() . " is a valid IP\n" if($ipstr->validate()->{'error'} eq undef);

$ipstr->set_value(167772161);
print "\nTesting '" . $ipstr->get_value() . "'\n";
print $ipstr->get_value() . " is a valid IP\n" if($ipstr->validate()->{'error'} eq undef);


print "\n#### end.";

##
# Test parent validate methods
##
print "\n\nTesting for null through parent class String. \n";

$ipstr->set_value();
print "\nTesting '" . $ipstr->get_value() . "'\n";
print $ipstr->get_value() . " is a valid IP\n" if($ipstr->validate()->{'error'} eq undef);

print "\nTesting for null through parent class Number. \n";
$ipnum->set_value();
print "\nTesting '" . $ipnum->get_value() . "'\n";
print $ipnum->get_value() . " is a valid IP\n" if($ipnum->validate()->{'error'} eq undef);
