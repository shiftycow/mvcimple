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

#
# testing script for the MVCimple::String class
#
#
use strict;

use Data::Dumper;

use lib "../lib";
use MVCimple::String;

my $string = new MVCimple::String("test_string",{'length'=>10, 'null'=>1});
my $return = {};

print $string->to_sql()."\n";
print $string->to_input()."\n";

$string->set_value('trololol');
print "\n";
print Dumper($return = $string->validate());
print $string->get_value() . " is a valid string.\n" if($return->{'error'} eq undef);

$string->set_value();
print "\n";
print Dumper($return = $string->validate());
print $string->get_value() . " is a valid string.\n" if($return->{'error'} eq undef);

$string->set_value('Longer String than allowed');
print "\n";
print Dumper($return = $string->validate());
print $string->get_value() . " is a valid string.\n" if($return->{'error'} eq undef);

my $string2 = new MVCimple::String("new_string",{'length'=>30, 'null'=>0});

print "\n";
print Dumper($return = $string2->validate());
print $string2->get_value() . " is a valid string.\n" if($return->{'error'} eq undef);


