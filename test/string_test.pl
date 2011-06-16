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
#Testing script for the MVCimple::String class#
###############################################

use strict;

use Data::Dumper;

use lib "../lib";
use MVCimple::String;

my $string = new MVCimple::String("test_string",{'length'=>10, 'null'=>0});

print "\n####\n#Testing string->to_sql()\n####\n\n" . $string->to_sql()."\n";
print "\n####\n#Testing string->to_input()\n####\n\n" . $string->to_input()."\n";

################################
# Validation tests for Strings.#
################################

# Insert any values you want tested into the array below.
my @tests = ('trolololol','Longer string than allowed','');

# Loop through and test all values
print "\n####\n#Validation tests for Strings.\n####\n";

foreach (@tests){
    $string->set_value($_);
    my $tmp = $string->validate();

    print "\nTesting '" . $string->get_value() . "'\n";
    print "Result: " .$string->get_value() . " is a valid String\n" if($tmp->{'error'} eq undef);
    print "Result: Invalid. Error given is " . Dumper($tmp->{'error'}) if($tmp->{'error'} ne undef);                                                                                       
}

