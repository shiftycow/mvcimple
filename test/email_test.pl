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

###############################################
#Testing script for the MVCimple::EMail class#
###############################################


use Data::Dumper;

use strict;
use lib "../lib";
use MVCimple::EMail;

my $email = new MVCimple::EMail('email',{null=>0});

print "\n####\n#Testing email->to_sql()\n####\n\n" . $email->to_sql()."\n";

print "\n####\n#Testing email->to_input()\n####\n\n" . $email->to_input()."\n";

#######################################
# Validation tests for email addresses#
#######################################

# Insert any values you want tested into the array below.
my @tests = ('foo@bar.com','not an email address', '');

# Loop through and test all values
print "\n####\n#Validation tests for Email addresses.\n####\n";

foreach (@tests){
    $email->set_value($_);
    my $tmp = $email->validate();

    print "\nTesting '" . $email->get_value() . "'\n";
    print "Result: " .$email->get_value() . " is a valid email address\n" if($tmp->{'error'} eq undef);
    print "Result: Invalid. Error given is " . Dumper($tmp->{'error'}) if($tmp->{'error'} ne undef);        
}

