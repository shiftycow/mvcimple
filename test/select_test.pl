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
#Testing script for the MVCimple::Select class#
###############################################

use strict;

use Data::Dumper;

use lib "../lib";
use MVCimple::App;

my $select = new MVCimple::Select("test_select");
$select->set_list([{id=>1,name=>'hello'},{id=>2,name=>"goodbye"}]);

print "\n####\n#Testing to_sql()\n####\n\n" . $select->to_sql()."\n";
print "\n####\n#Testing to_input()\n####\n\n" . $select->to_input("blah")."\n";

