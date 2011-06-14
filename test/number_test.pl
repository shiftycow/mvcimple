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
# testing script for the MVCimple::Number class
#
#
use strict;

use Data::Dumper;

use lib "../lib";
use MVCimple::Number;

my $number = new MVCimple::Number("mynum",{'length'=>9,'precision'=>16,'scale'=>4,'null'=>1 });
my $return = {};

print $number->to_sql()."\n";
print $number->to_input()."\n";

$number->set_value('asdf');
print Dumper($return = $number->validate());
print "asfd is a valid number\n" if($return->{'error'} eq undef);


$number->set_value(5.5);
print Dumper($return = $number->validate());
print "5.5 is a valid number\n" if($return->{'error'} eq undef);


$number->set_value();
print Dumper($return = $number->validate());
print "Null is a valid number\n" if($return->{'error'} eq undef);

$number->set_value(0);
print Dumper($return = $number->validate());
print "0 is a valid number\n" if($return->{'error'} eq undef);
