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
#Testing script for the MVCimple::Number class#
###############################################

use strict;

use Data::Dumper;

use lib "../lib";
use MVCimple::Number;

my $number = new MVCimple::Number("mynum",{'length'=>9,'precision'=>16,'scale'=>4,'null'=>0}); 

print "\n####\n#Testing number->to_sql()\n####\n\n" . $number->to_sql()."\n";
print "\n####\n#Testing number->to_input()\n####\n\n" . $number->to_input()."\n";

################################
# Validation tests for Numbers.#
################################

# Insert any values you want tested into the array below.
my @tests = ('asdf',5.5,'',0);

# Loop through and test all values
print "\n####\n#Validation tests for Numbers.\n####\n";

foreach (@tests){
    $number->set_value($_);
    my $tmp = $number->validate();

    print "\nTesting '" . $number->get_value() . "'\n";
    print "Result: " .$number->get_value() . " is a valid Number.\n" if($tmp->{'error'} eq undef);
    print "Result: Invalid. Error given is " . Dumper($tmp->{'error'}) if($tmp->{'error'} ne undef);  
}     
