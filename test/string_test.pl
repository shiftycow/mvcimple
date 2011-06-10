#!/usr/bin/perl
#
# testing script for the MVCimple::String class
#
#
use strict;

use Data::Dumper;

use lib "../lib";
use MVCimple::String;

my $string = new MVCimple::String("test_string",{'length'=>30, 'null'=>0});
my $return = {};

print $string->to_sql()."\n";
print $string->to_input()."\n";

$string->set_value('trololol');
print Dumper($return = $string->validate());
print $string->get_value() . " is a valid string.\n" if($return->{'error'} eq undef);

$string->set_value();
print Dumper($return = $string->validate());
print $string->get_value() . " is a valid string.\n" if($return->{'error'} eq undef);

