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

=pod
GenSQL_test.pl

This script provides testing functions for GenSQL.pm

=cut

use lib "../lib";

use MVCimple::GenSQL;

my $item = {"manufaturer_part_number" => {"type" => "String", "length" => 64},
         "upc" => {"type" => "String", "length" => 12},
         "vendor_part_number" => {"type" => "String", "length" => 64},
         "property_tag" => {"type" => "String", "length" => 64},
         "location"  => {"type" => "String", "length" => 128},
         "description" => {"type" => "String", "length" => 256},
         "id" => {"type" => "Number","PRIMARY_KEY"=>"yes"},
         "entered_by" => {"FOREIGN_KEY" => "user.username"}
        };  

my $user = {"fname" => {"type" => "String", "length" => 64},
         "lname" => {"type" => "String", "length" => 64},
         "username" => {"type" => "String", "length" => 64, "PRIMARY_KEY"=>"yes"},
         "password" => {"type" => "String", "length" => 64},
         "email" => {"type" => "String", "length" => 128}
        };  

## models need to be packed into this hash at the end
my $models = {"item"=>$item, "user"=>$user};

#print XML::Dumper::pl2xml($models->{"user"}->{"email"});
MVCimple::GenSQL::generate_sql($models);
