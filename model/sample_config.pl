#!/usr/bin/perl
use strict;
#
#
# This is a sample configuration file for the `mvcimple` MCV Framework Generator. 
#
# This configuration defines a simple inventory-control database
# that allows multiple users to check in items, check them out again, and
# view reports. 
#

##
## Models
## 

$item = {"manufaturer_part_number" => {"type" => "string", "length" => 64},
         "upc" => {"type" => "string", "length" => 12},
         "vendor_part_number" => {"type" => "string", "length" => 64},
         "property_tag" => {"type" => "string", "length" => 64},
         "location"  => {"type" => "string", "length" => 128},
         "description" => {"type" => "string", "length" => 256}
         "id" => {"type" => "number"}
         };

$user = {"fname" => {"type" => "string", "length" => 64},
         "lname" => {"type" => "string", "length" => 64},
         "username" => {"type" => "string", "length" => 64},
         "password" => {"type" => "password", "length" => 64},
         "email" => {"type" => "password", "length" => 128}
        };

