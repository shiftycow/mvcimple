#!/usr/bin/perl
#
# testing script for the MVCimple::Number class
#
#
use strict;

use Data::Dumper;

use lib "../lib";
use MVCimple::Number;

my $number = new MVCimple::Number("mynum",{'length'=>9,'precision'=>16,'scale'=>4,'null'=>0 });
my $return = {};

print $number->to_sql()."\n";
print $number->to_input()."\n";

$number->set_value('asdf');
print Dumper($return = $number->validate());
print "asfd is a valid number\n" if($return->{'error'} eq undef);


$number->set_value(5.5);
print Dumper($return = $number->validate());
print "5.5 is a valid number\n" if($return->{'error'} eq undef);


$number->set_value();
print Dumper($return = $number->validate());
print "Null is a valid number\n" if($return->{'error'} eq undef);

