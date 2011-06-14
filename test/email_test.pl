#!/usr/bin/perl
#
# testing script for the MVCimple::EMail class
#
#

use Data::Dumper;

use strict;
use lib "../lib";
use MVCimple::EMail;

my $email = new MVCimple::EMail('email',{null=>1});

print $email->to_sql()."\n";
print $email->to_input()."\n";

$email->set_value('foo@bar.com');
print "\nTesting '" . $email->get_value() . "'\n\n ";
print Dumper($email->validate());
print $email->get_value() . " is a valid email address.\n" if($email->validate()->{'error'} eq undef);

$email->set_value('not an email address');
print "\nTesting '" . $email->get_value() . "'\n\n ";
print Dumper($email->validate());
print $email->get_value() . " is a valid email address.\n" if($email->validate()->{'error'} eq undef);

$email->set_value();
print "\nTesting '" . $email->get_value() . "'\n\n ";
print Dumper($email->validate());
print $email->get_value() . " is a valid email address.\n" if($email->validate()->{'error'} eq undef);
