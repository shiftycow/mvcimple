#!/usr/bin/perl
#
# testing script for the MVCimple::EtherMAC class
#
#

use strict;

use Data::Dumper;

use lib "../lib";
use MVCimple::EtherMAC;

my $mac = new MVCimple::EtherMAC("mac");
my $return = {};


$mac->set_value('00 11 22 33 FF 55');

print Dumper($return = $mac->validate());
print "MAC = ". $mac->get_value() ."\n" if($return->{'error'} eq undef);
