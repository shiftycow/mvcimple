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
# testing script for the MVCimple::Password class
#
#

use strict;
use lib "../lib";
use MVCimple::Password;

my $password = new MVCimple::Password('password',{hash_type => "SHA-1",
                                                  salt_length => 12}
                                     );

print $password->to_sql()."\n";
print $password->to_input()."\n";
#print $password->to_hash()."\n";

$password->set_value('som3cr4ppypasswd');
if($password->validate()){
    print $password->get_value();
    print " This password is valid \n"; 
}

$password->set_value('2short');
if($password->validate()){
    print $password->get_value();
    print " This password is invalid \n"; 
}

