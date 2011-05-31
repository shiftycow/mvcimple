#!/usr/bin/perl
#
# testing script for the MVCimple::EMail class
#
#

use strict;
use lib "../lib";
use MVCimple::EMail;

my $email = new MVCimple::EMail('email');

print $email->to_sql()."\n";
print $email->to_input()."\n";
my $test_email = 'foo@bar.com';
print "$test_email is valid \n" if ($email->validate($test_email));


