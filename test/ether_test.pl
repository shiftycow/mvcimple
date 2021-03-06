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

#################################################
#Testing script for the MVCimple::EtherMAC class#
#################################################

use strict;

use Data::Dumper;

use lib "../lib";
use MVCimple::EtherMAC;

my $mac = new MVCimple::EtherMAC("mac",{null=>0});

###########################################################
# Validation tests for IP address represented as a Number.#
###########################################################

# Insert any values you want tested into the array below.
my @tests = ('00 11 22 33 FF 55','garbage','');

# Loop through and test all values
print "\n####\n#Validation tests for MAC addresses.\n####\n";

foreach (@tests){
    $mac->set_value($_);
    my $tmp = $mac->validate();

    print "\nTesting '" . $mac->get_value() . "'\n";
    print "Result: " .$mac->get_value() . " is a valid MAC address.\n" if($tmp->{'error'} eq undef);
    print "Result: Invalid. Error given is " . Dumper($tmp->{'error'}) if($tmp->{'error'} ne undef);                                                                                                }

