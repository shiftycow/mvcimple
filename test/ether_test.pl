#!/usr/bin/perl
#
# testing script for the MVCimple::EtherMAC class
#
#

use strict;

use Data::Dumper;

use lib "../lib";
use MVCimple::EtherMAC;

my $mac = new MVCimple::EtherMAC("mac",{null=>0});
my $return = {};


$mac->set_value('00 11 22 33 FF 55');
print "\nTesting '" . $mac->get_value() . "'\n\n ";
print Dumper($return = $mac->validate()) ."\n" ;
print "MAC = ". $mac->get_value() ."\n\n" if($return->{'error'} eq undef);

$mac->set_value('garbage');
print "\nTesting '" . $mac->get_value() . "'\n\n ";
print Dumper($return = $mac->validate()) ."\n" ;
print "MAC = ". $mac->get_value() ."\n\n" if($return->{'error'} eq undef);

$mac->set_value();
print "\nTesting '" . $mac->get_value() . "'\n\n ";
print Dumper($return = $mac->validate()) ."\n" ;
print "MAC = ". $mac->get_value() ."\n\n" if($return->{'error'} eq undef);
