#!/usr/bin/perl
###############################################################################
#    This file is part of MVCimple.
#
#    MVCimple is free software: you can redistribute it and/or modify
#    it under the terms of the GNU Lesser General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    MVCimple is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Lesser General Public License for more details.
#
#    You should have received a copy of the GNU Lesser General Public License
#    along with MVCimple.  If not, see <http://www.gnu.org/licenses/>. 
###############################################################################

###########################################
#Testing script for the MVCimple::IP class#
###########################################


use Data::Dumper;

use strict;
use lib "../lib";
use MVCimple::IP;

###########################################################
# Validation tests for IP address represented as a Number.#
###########################################################
my $ipnum = new MVCimple::IP("network",{datatype=>'Number', null=>1});


# Insert any values you want tested into the array below.
my @tests = (167772161, 'asdf','192.168.1.1','');

# Loop through and test all values
print "\n####\n#Validation tests for IP adress as a Number.\n####\n";

foreach (@tests){
    $ipnum->set_value($_);
    my $tmp = $ipnum->validate();

    print "\nTesting '" . $ipnum->get_value() . "'\n";
    print "Result: " .$ipnum->get_value() . " is a valid IP\n" if($tmp->{'error'} eq undef);
    print "Result: Invalid. Error given is " . Dumper($tmp->{'error'}) if($tmp->{'error'} ne undef);                                                                                                }      

###########################################################
# Validation tests for IP address represented as a String.#
###########################################################
my $ipstr = new MVCimple::IP("network",{datatype=>'String', null=>0});

# Insert any values you want tested into the array below.
my @tests = ('128.123.3.5', 'asf', 167772161, '');

# Loop through and test all values
print "\n####\n#Validation tests for IP adress as a String.\n####\n";

foreach (@tests){
    $ipstr->set_value($_);
    my $tmp = $ipstr->validate();

    print "\nTesting '" . $ipstr->get_value() . "'\n";
    print "Result: " .$ipstr->get_value() . " is a valid IP\n" if($tmp->{'error'} eq undef);
    print "Result: Invalid. Error given is " . Dumper($tmp->{'error'}) if($tmp->{'error'} ne undef);
}

#############
# Other tests
#############
$ipnum->set_value(2155545349);

print "\n####\n#Testing ipnum->to_sql()\n####\n" . $ipnum->to_sql()."\n";

print "\n####\n#Testing ipnum->to_input()\n####\n" . $ipnum->to_input()."\n";

print "\n####\n#Testing decimal2IP()\n####\n" . $ipnum->get_value() . " as a string is  " . $ipnum->decimal2IP($ipnum->get_value()) . "\n";

print "\n####\n#Testing ip2Decimal()\n####\n" . $ipstr->get_value() . " as a number is  " . $ipstr->ip2Decimal($ipstr->get_value()) . "\n";


print "\n####\n#Testing get_as_string()\n####\n". $ipnum->get_value() . " as a string is  " . $ipnum->get_as_string() . "\n";

$ipstr->set_value('128.123.3.5');
print "\n####\n#Testing get_as_number()\n####\n". $ipstr->get_value() . " as a string is  " . $ipstr->get_as_number() . "\n";



