#!/usr/bin/perl
use strict;

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
