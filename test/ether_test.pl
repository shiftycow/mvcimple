#!/usr/bin/perl
#
# testing script for the MVCimple::EtherMAC class
#
#

use strict;
use lib "../lib";
use MVCimple::EtherMAC;

my $mac = new MVCimple::EtherMAC("mac");



$mac->set_value('00 11 22 33 FF 55');


print "MAC = ". $mac->get_value() ."\n";
