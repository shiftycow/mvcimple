#!/usr/bin/perl
use strict;
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
# auto_test.pl
# provides an interface for automatic testing of MVCimple libraries
#

use lib "../lib";

#system includes
use Term::ANSIColor;

#local includes
use MVCimple::AutoTest;

fail();
pass();
warning();

# test some color output
sub fail
{
    print Term::ANSIColor::colored(" [ FAIL ] ","red");
    print "\n";
}

sub pass
{
    print Term::ANSIColor::colored(" [ PASS ] ","green");
    print "\n";
}

sub warning
{
    print Term::ANSIColor::colored(" [ WARN ] ","yellow");
    print "\n";
}
