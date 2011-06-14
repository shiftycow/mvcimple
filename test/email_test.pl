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
# testing script for the MVCimple::EMail class
#
#

use strict;
use lib "../lib";
use MVCimple::EMail;

my $email = new MVCimple::EMail('email');

print $email->to_sql()."\n";
print $email->to_input()."\n";

$email->set_value('foo@bar.com');
if($email->validate()){
    print $email->get_value();
    print " This email address is valid \n"; 
}

$email->set_value('not an email address');
if($email->validate()){
    print $email->get_value();
    print " This email address is valid \n"; 
}


