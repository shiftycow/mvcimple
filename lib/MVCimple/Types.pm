#!/usr/bin/perl
use strict;
package MVCimple::Types;
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

=pod

=h1 Name 

Types.pm

=h2 Synopsis

This library provides a convenient interface to `use` the type libraries
included in MVCimple. These type libraries provide an object-oriented 
way to handle different data types passed around MVCimple-based applications

=cut

#define type libraries here
#use EthernetMAC;
#use IP;
#use Password;
use lib "../";
use MVCimple::String;
use MVCimple::Number;
use MVCimple::Integer;
use MVCimple::IP;
use MVCimple::EMail;
use MVCimple::EtherMAC;
use MVCimple::Password;
use MVCimple::DateTime;

1;
